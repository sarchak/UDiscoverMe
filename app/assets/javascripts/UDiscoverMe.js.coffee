window.UDiscoverMe =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: -> 
  		app = new UDiscoverMe.Routers.Favorites
  		Backbone.history.start({ pushState: true, root: "/" })

$(document).ready ->
  UDiscoverMe.initialize()

 


