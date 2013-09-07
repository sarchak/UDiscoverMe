class TagsController < ApplicationController
	respond_to :json

	def index
    	belongs_to = params[:belongs_to]
		#results = [{"text" =>"Timmy Doe","size"=>100},{"text"=>"John Doe","size"=>50}]
		results = Tag.where(:belongs_to => belongs_to)  
		respond_with  do |format|
      		#format.html { results }
      		format.json { render json: results}
    	end
	end
end
