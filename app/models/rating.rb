class Rating < ActiveRecord::Base
  default_scope where('updated_at > ?', 5.hours.ago)
  belongs_to :venue
  belongs_to :user
end
