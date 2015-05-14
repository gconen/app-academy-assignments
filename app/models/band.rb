class Band < ActiveRecord::Base
  validates :name, presence: true

  has_many(
    :albums,
    class_name: "Album",
    foreign_key: :band_id,
    primary_key: :id
    dependent: :destroy
  )

  has_many(
    :tracks,
    through: :albums,
    source: :tracks
  )
end
