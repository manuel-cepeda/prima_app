class Venue < ActiveRecord::Base
	acts_as_voteable
	has_many :posts, dependent: :destroy
	belongs_to :user
	validates :title, presence: true, length: {maximum: 60}

	searchable  do
		
		text :title
	end

end
