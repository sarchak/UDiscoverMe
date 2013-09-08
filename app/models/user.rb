class User
  include Mongoid::Document
  #has_and_belongs_to_many :favorites, inverse_of: :user
  auto_increment :id
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :screen_name, type: String
  field :url, type: String
  field :imageurl, type: String
  field :location, type: String
  field :followers, type: Integer
  field :friends, type: Integer
  field :token, type: String
  field :secret, type: String

  def self.from_omniauth(auth)
  	where(auth.slice('provider','uid')).first || create_new_user(auth)
  end

  def self.create_new_user(auth)
  	create! do |user|
  		user.provider = auth["provider"]
  		user.uid = auth["uid"]
  		user.name = auth["info"]["name"]
  		user.screen_name = auth["extra"]["raw_info"]["screen_name"]
  		user.url = auth["info"]["urls"]["Twitter"]
  		user.imageurl = auth["info"]["image"]
  		user.location = auth["info"]["location"]
  		user.followers = auth["extra"]["raw_info"]["followers_count"]
  		user.friends = auth["extra"]["raw_info"]["friends_count"]
  		user.token = auth["credentials"]["token"]
  		user.secret = auth["credentials"]["secret"]
  	end
  end
end
