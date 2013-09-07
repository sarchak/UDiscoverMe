class UDiscoverMe.Views.Header extends Backbone.View
	events:
          'click #pagehead': 'navigate'
          'click .page-header' : 'navigate'
 	initialize:->
      	console.log('Page Header')
    
	render: ->
		$(@el).html('<h3 class="page-header">UDiscoverMe</h3>')
		this	

	navigate: ->
		console.log("Navigate called")
		Backbone.history.navigate("/",true)
		Backbone.pubSub.trigger('mainpage', { 'searchkey' : "shrikar"} );