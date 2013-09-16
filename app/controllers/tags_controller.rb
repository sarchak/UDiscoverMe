class TagsController < ApplicationController
	respond_to :json

	def index
    	belongs_to = params[:belongs_to]
		results = Tag.where(:belongs_to => belongs_to).desc(:size).limit(50)  
		respond_with  do |format|
      		#format.html { results }
      		format.json { render json: results}
    	end
	end
end
