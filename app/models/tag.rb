class Tag
  include Mongoid::Document
  field :text, type: String
  field :belongs_to , type: String
  field :size , type: Float
  def self.from_data(user,text,score)
  	tag = Tag.new do |tag|
  		tag["text"] = text
	  	tag["belongs_to"] = user.screen_name
	  	tag["size"] = score
  	end	
  	tag.upsert
  end
end
