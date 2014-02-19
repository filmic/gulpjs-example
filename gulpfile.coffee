gulp = require 'gulp'
gutil = require 'gulp-util'

coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
sass = require 'gulp-sass'
refresh = require 'gulp-livereload'

connect = require 'connect'
http = require 'http'
path = require 'path'
lr = require 'tiny-lr'
server = do lr

# Starts the webserver (http://localhost:3000)
gulp.task 'webserver', ->
	port = 3000
	hostname = null # allow to connect from anywhere
	base = path.resolve '.'
	directory = path.resolve '.'

	app = connect()
		.use(connect.static base)
		.use(connect.directory directory)

	http.createServer(app).listen port, hostname

# Starts the livereload server
gulp.task 'livereload', ->
    server.listen 35729, (err) ->
        console.log err if err?

# Compiles CoffeeScript files into js file
# and reloads the page
gulp.task 'scripts', ->
	gulp.src('scripts/coffee/**/*.coffee')
		.pipe(concat 'scripts.coffee')
		.pipe(do coffee)
		.pipe(do uglify)
		.pipe(gulp.dest 'scripts/js')
		.pipe(refresh server)

# Compiles Sass files into css file
# and reloads the styles
gulp.task 'styles', ->
    gulp.src('styles/scss/init.scss')
        .pipe(sass includePaths: ['styles/scss/includes'])
        .pipe(concat 'styles.css')
        .pipe(gulp.dest 'styles/css')
        .pipe(refresh server)

# Reloads the page
gulp.task 'html', ->
	gulp.src('*.html')
		.pipe(refresh server)

# Watches files for changes
gulp.task 'watch', ->
  gulp.watch 'scripts/coffee/**', ['scripts']
  gulp.watch 'styles/scss/**', ['styles']
  gulp.watch '*.html', ['html']

# The default task
gulp.task 'default', ['webserver', 'livereload', 'scripts', 'styles', 'watch']

