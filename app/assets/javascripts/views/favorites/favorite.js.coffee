class UDiscoverMe.Views.Favorite extends Backbone.View
  template: JST['favorites/favorite']
  className: 'pin'
  events:
  	'click #more' : 'showmore'
  	'click #savefavorite' : 'favorite'

  favorite: (event) ->
  	favid = $(event.currentTarget).data("id")
  	alert( favid)
  	this.model.save {"favoritethis" : favid},
	  success: ->
	    console.log(response)

	  error: (model, response) ->
	  	alert("Please login before favoriting.")
		Backbone.history.navigate("/vishals",true)  	

  render: ->
    $(@el).html(@template(favorite: @model))
    this
