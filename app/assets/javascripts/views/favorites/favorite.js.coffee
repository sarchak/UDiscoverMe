class UDiscoverMe.Views.Favorite extends Backbone.View
  template: JST['favorites/favorite']
  className: 'pin'
  events:
  	'click #more' : 'showmore'

  render: ->
    $(@el).html(@template(favorite: @model))
    this
