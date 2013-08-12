class Venue < ActiveRecord::Base
	acts_as_voteable
	validates :title, presence: true, length: {maximum: 60}

end
