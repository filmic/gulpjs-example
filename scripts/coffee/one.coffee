class One

	constructor: ->
		@container = document.getElementById 'status'

	render: ->
		label = @makeLabel 'ONE READY'
		@container.appendChild label

	makeLabel: (labelText) ->
		el = document.createElement('p')
		el.innerHTML = labelText
		el

new One().render()