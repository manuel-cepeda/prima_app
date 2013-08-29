class Authorization < ActiveRecord::Base

	belongs_to :user
	validates :provider, :uid, :presence => true

	def self.find_or_create(auth_hash)
	  unless auth = find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	    user = User.create :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"], :fb_id => auth_hash["extra"]["raw_info"]["id"], :gender => auth_hash["extra"]["raw_info"]["gender"]
	    auth = create :user => user, :provider => auth_hash["provider"], :uid => auth_hash["uid"], :token => auth_hash['credentials']['token']

        @graph = Koala::Facebook::API.new(auth_hash['credentials']['token'])
        profile = @graph.get_object("me")
        @graph.put_connections("me", "feed", :message => "#{current_user.name} es un nuevo usuario en Crowdly! #{root_url}")
	 	

	  end
	 
	  auth
	end

end
