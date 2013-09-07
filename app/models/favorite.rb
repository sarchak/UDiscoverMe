class Favorite
  	include Mongoid::Document
  	include Mongoid::Search
  	
  	#has_and_belongs_to_many :users, inverse_of: :user
  	field :_id, type: String
	field :text, type: String
	field :screen_name , type: String
	field :uid , type: String
	field :created_at , type: String
	field :urls , type: Array
	field :user_mentions , type: Array
	field :hashtags, type: Array
	field :favorite_count , type: Integer
	field :retweet_count , type: Integer
	field :belongs_to, type: String
	field :media_url, type: String
	field :linktext, type: String
	field :from_user_img, type: String
	field :temptext, type:String
	search_in :text,:linktext

	def self.from_tweet(user,tweet,text,imageurl,title)
	  	favorite = Favorite.new do |favorite|
	  		favorite["_id"] = tweet.attrs[:id_str]
	  		favorite["favorites_id"] = tweet.attrs[:id_str]
	  		favorite["text"] = tweet["text"]
	  		favorite["screen_name"] = tweet["user"]["screen_name"]
	  		favorite["uid"] = tweet.attrs[:user][:id_str]
	  		favorite["created_at"] = tweet["created_at"]
	  		favorite["urls"] = tweet.urls.map{|url| url.expanded_url}
	  		favorite["user_mentions"] = tweet.user_mentions.map{|mention| mention.screen_name}
	  		favorite["hashtags"] = tweet.hashtags.map{|hashtag| hashtag.text}
	  		favorite["favorite_count"] = tweet["favorite_count"]
	  		favorite["retweet_count"] = tweet["retweet_count"]
	  		favorite["belongs_to"] = user.screen_name
	  		favorite["from_user_img"] = tweet.user.profile_image_url
	  		favorite["title"] = title
	  		tweet.media.each do |photo|
	  			favorite["media_url"] = photo.media_url
	  		end

	  		if(favorite["media_url"].nil?)
	  			favorite["media_url"] = imageurl	
	  		end

	  		favorite["linktext"] = text
	 	end

	  	favorite.upsert
	end
end
