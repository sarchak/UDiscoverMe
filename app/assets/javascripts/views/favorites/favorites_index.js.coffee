class UDiscoverMe.Views.FavoritesIndex extends Backbone.View
  id = 0
  controlpanel = 0
  template: JST['favorites/index']
  events:
          'submit #new_search': 'newSearch'

  initialize:->
      id = this.options.user
      controlpanel = this.options.controlpanel
      @collection.on('reset', @render, this)
      Backbone.pubSub.on('mainpage', this.resetPage, this);

  render: ->

      $('#favorites').empty()
      $(@el).html(@template())
      @collection.each(@addFavorite)
      this

  resetPage: (id)->
      $('#favorites').empty()
      @collection.fetch({reset:true}) 
      @collection.reset()

  addFavorite: (favorite) ->
      favorite.set "temptext", favorite.get("linktext").substr(0, 200)  if favorite.get("linktext")?
      view = new UDiscoverMe.Views.Favorite(model : favorite)
      $('#favorites').append(view.render().el)

  newSearch: (event) ->

    console.log('New Search called :' + @collection)
    event.preventDefault()
    searchterm = $("#search").val()
    @collection.fetch({reset:true, data : {"search": $("#search").val(), "belongs_to":id}}) 
    @collection.reset()
    console.log("SENDING : " + searchterm+ " id "+ id)
    Backbone.pubSub.trigger('view2event', { 'searchkey' : searchterm} );
    $("#new_search")[0].reset()



