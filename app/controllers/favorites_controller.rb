class FavoritesController < ApplicationController
  respond_to :json

  def index

    belongs_to = params[:belongs_to]
    if(!params[:community].nil?)
      favorites = []
      data = Favorite.mongo_session.command(:text =>'favorites', search: params[:search])
      data["results"].each do |ent|
        favorites.push(ent["obj"])
      end
    else
      if(params[:belongs_to].nil? && !current_user.nil?)
          belongs_to = current_user.screen_name
      end
      if(params[:id].nil?)
          belongs_to = params[:id]
      end        

      if(params[:search] == nil && params[:belongs_to] == nil)
        favorites = Favorite.where(:belongs_to => belongs_to)  
      elsif(params[:search] == nil)
        favorites = Favorite.where(:belongs_to => belongs_to)
      else
        favorites = []
        if(!params["search"].nil?)
          data = Favorite.mongo_session.command(:text =>'favorites', search: params[:search],filter: { belongs_to: belongs_to })
          data["results"].each do |ent|
            favorites.push(ent["obj"])
          end
        elsif (!params["id"].nil?)
          favorites = Favorite.where(:belongs_to => params[:id])
        end
      end
    end

    respond_with  do |format|
      format.html { favorites }
      format.json { render json: favorites}
    end
        
    #@favorites = 
    #respond_with favorites
  end
  
  def show
  	#@favorites = Favorite.where(:belongs_to => current_user.screen_name)
    respond_with favorites
  end

end
