class Venue < ActiveRecord::Base
	acts_as_voteable
	has_many :posts, dependent: :destroy
	validates :title, presence: true, length: {maximum: 60}

end
