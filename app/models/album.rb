class Album < ActiveRecord::Base

  validates :name, presence: true
  validates :band_id, presence: true

  belongs_to :band
  has_many :tracks, dependent: :destroy

end
