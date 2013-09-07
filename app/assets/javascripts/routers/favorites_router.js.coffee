

class UDiscoverMe.Routers.Favorites extends Backbone.Router
	Backbone.pubSub = _.extend({}, Backbone.Events);
	Backbone.shrikar = "archak"
	ControlPanel = ->
  		@events = _.extend({}, Backbone.Events)
  	controlPanel = new ControlPanel()	
	routes:
		'':'index'
		':id': 'userload'


	initialize:->
		@collection = new UDiscoverMe.Collections.Favorites()
		@collection.fetch({reset:true})
		@communitycollection = new UDiscoverMe.Collections.Favorites()
		@communitycollection.fetch({reset:true})
		@tags = new UDiscoverMe.Collections.TagClouds()
		@tags.fetch({reset:true})

	index: ->

		console.log("Router :" + controlPanel.events)
		view = new UDiscoverMe.Views.FavoritesIndex(collection: @collection, controlpanel : controlPanel)
		$('#container').html(view.render().el)
		cview = new UDiscoverMe.Views.CommunityFavoritesIndex(collection: @communitycollection, controlpanel : controlPanel)
		$('#communitycontainer').html(cview.render().el)
		hview = new UDiscoverMe.Views.Header()
		$('#pagehead').html(hview.render().el)


	show: (id) ->
		alert "Favorites #{id}"

	userload: (id) ->
		@test = id
		view = new UDiscoverMe.Views.FavoritesIndex(collection: @collection, user : id)
		@collection.fetch({reset:true, data : { "belongs_to":id, "search": $("#search").val()}}) 
		$('#container').html(view.render().el)

		cview = new UDiscoverMe.Views.CommunityFavoritesIndex(collection: @communitycollection,user : id)
		@communitycollection.fetch({reset:true, data : { "belongs_to":id, "search": $("#search").val()}}) 
		$('#communitycontainer').html(cview.render().el)

		hview = new UDiscoverMe.Views.Header()
		$('#pagehead').html(hview.render().el)
		
		tagview = new UDiscoverMe.Views.TagCloud(collection: @tags, user: 'shrikar test')
		@tags.fetch({reset:true}) 
		$('#tagcloud').html(tagview.render().el)
		console.log("Router : " + @tags.length)


