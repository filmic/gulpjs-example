class Two extends One

	render: ->
		label = @makeLabel 'TWO READY'
		@container.appendChild label

new Two().render()