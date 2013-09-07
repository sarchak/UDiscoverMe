require 'httpclient'
require 'json'
class FavoriteFetcher
	include Sidekiq::Worker
	sidekiq_options retry: false

	def fetch_url(url)

	end

	def perform(user_id)
		user = User.find(user_id)
		twitterUser = Twitter::Client.new(
  			:oauth_token => user.token,
  			:oauth_token_secret => user.secret,
  			:include_entitites => 1
		)

		httpclient = HTTPClient.new
		res = ""
		twitterUser.favorites({:count => 200}).each do |tweet|
			res =""
			tweet.urls.map { |url|
				begin
					res = httpclient.get_content "http://udiscover.me:9090/linkextract?imagefetch=true&url="+url.expanded_url
					break
				rescue
				end
				
			}
			if( res.length > 10) 
				data = JSON.parse(res)
				Favorite.from_tweet(user,tweet,data["text"],data["imageurl"],data["title"])
			else
				Favorite.from_tweet(user,tweet,nil,nil,nil)
			end
		end
		twitterUser.user_timeline({:count => 200}).each do |tweet|
			res = ""
			index_url = ""
			tweet.urls.map { |url|
				index_url = url
				begin
					res = httpclient.get_content "http://udiscover.me:9090/linkextract?imagefetch=true&url="+url.expanded_url
					break
				rescue
				end
				
			}
			if( res.length > 10) 
				data = JSON.parse(res)
				Favorite.from_tweet(user,tweet,data["text"],data["imageurl"],data["title"])
				res = httpclient.get_content "http://access.alchemyapi.com/calls/url/URLGetRankedKeywords?apikey=a5ee0cafd4a871434e1fa61e34968665b9e5bf94&outputMode=json&url="+index_url.expanded_url
				new_hash = JSON.parse(res)
				for keyword in new_hash["keywords"]
  					puts "Keyword :" + keyword["text"] + " size : " + (keyword["relevance"].to_f*100).to_s
					Tag.from_data(user,keyword["text"],(keyword["relevance"].to_f*100))  
					break					
				end

			else
				Favorite.from_tweet(user,tweet,nil,nil,nil)
			end
		end
	end
end

