class Post < ActiveRecord::Base
	belongs_to :user
	belongs_to :venue
    default_scope -> { order('created_at DESC') }
	validates :user_id, :venue_id, presence: true
	validates :content, presence: true, length: {maximum:140}
end
