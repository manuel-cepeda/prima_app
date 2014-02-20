class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :fb_id

  embed :ids, include: :true
  has_many :posts
  has_many :venues
  has_many :ratings
end