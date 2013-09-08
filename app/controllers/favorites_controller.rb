class FavoritesController < ApplicationController
  respond_to :json


  def index
    limit_docs = 200
    belongs_to = params[:belongs_to]
    if(!params[:community].nil?)
      favorites = []
      data = Favorite.mongo_session.command(:text =>'favorites', search: params[:search],:limit => 100)
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
        favorites = Favorite.where(:belongs_to => belongs_to).limit(limit_docs)  
      elsif(params[:search] == nil)
        favorites = Favorite.where(:belongs_to => belongs_to).limit(limit_docs)
      else
        favorites = []
        if(!params["search"].nil?)
          data = Favorite.mongo_session.command(:text =>'favorites', search: params[:search],:limit => limit_docs,filter: { belongs_to: belongs_to })
          data["results"].each do |ent|
            favorites.push(ent["obj"])
          end
        elsif (!params["id"].nil?)
          favorites = Favorite.where(:belongs_to => params[:id]).limit(limit_docs)
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
  
  def save
    if current_user.nil?
      #redirect_to "/landing"
      render 'public/500.html', :status => 401, :layout => false
    else   
      twitterUser = Twitter::Client.new(
      :oauth_token => current_user.token,
      :oauth_token_secret => current_user.secret,
      :include_entitites => 1
      )
      puts "Favorite this " + params[:favoritethis]
      result = {"status" => "success"}
      res = twitterUser.favorite(params[:favoritethis].to_i)
      puts res.to_json
      respond_with do |format|
        format.json{ render json: result}
      end  
    end
  end

  def show
  	#@favorites = Favorite.where(:belongs_to => current_user.screen_name)
    respond_with favorites
  end

end
