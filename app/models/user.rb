class User < ActiveRecord::Base
    ajaxful_rater
    acts_as_voter
	has_many :authorizations
	has_many :feedbacks, dependent: :destroy
	has_many :posts, dependent: :destroy
	has_many :venues, dependent: :destroy
	has_many :vote_records
    has_many :feedbacks, dependent: :destroy
    has_many :ratings, dependent: :destroy
    validates :name,  presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

	before_save { self.email = email.downcase }


	def add_provider(auth_hash)
	  # Check if the provider already exists, so we don't add it twice
	  unless authorizations.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
	    Authorization.create :user => self, :provider => auth_hash["provider"], :uid => auth_hash["uid"]
	  end
	end



end
