class VenueSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :latitude, :longitude, :user_id

  embed :ids, include: :true
  has_many :posts
  has_many :ratings
end