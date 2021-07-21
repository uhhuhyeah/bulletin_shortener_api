class Link < ActiveRecord::Base
  SLUG_LENGTH = 6

  validates :url, presence: true, length: { maximum: 255 }
  validates :slug, presence: true, length: { maximum: SLUG_LENGTH }, uniqueness: true

end