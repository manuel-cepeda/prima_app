class Venue < ActiveRecord::Base
	validates :title, presence: true, length: {maximum: 60}

end
