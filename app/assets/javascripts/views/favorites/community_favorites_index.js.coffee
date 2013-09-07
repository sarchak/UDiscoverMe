class UDiscoverMe.Views.CommunityFavoritesIndex extends Backbone.View
  id = 0
  pubsub = 0
  template: JST['favorites/communityfavorites']
  events:
          'submit #new_search_global': 'newSearch'

  initialize:->
      id = this.options.user
      #console.log('Community Render called ' + @collection.length)
      @collection.on('reset', @render, this)
      Backbone.pubSub.on('view2event', this.newSearch, this);

  render: ->
      #console.log('Community Render called ' + Backbone.shrikar)
      $('#community_favorites').empty()
      $(@el).html(@template())
      @collection.each(@addFavorite)
      console.log(this.user)
      this

  testfunc: (id)->
      console.log("AAA :" + id + "  "+@test)

  addFavorite: (favorite) ->
      favorite.set "temptext", favorite.get("linktext").substr(0, 200)  if favorite.get("linktext")?
      view = new UDiscoverMe.Views.Favorite(model : favorite)
      $('#community_favorites').append(view.render().el)

  newSearch: (data) ->
    console.log("DATA " + data.searchkey)
    #event.preventDefault()
    @collection.fetch({reset:true, data : {"search": data.searchkey,"community":"enabled"}}) 
    @collection.reset()
    $("#new_search")[0].reset()



