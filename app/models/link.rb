class Link < ActiveRecord::Base
  SLUG_LENGTH = 6

  validates :url, presence: true, length: { maximum: 255 }
  validates :slug, presence: true, length: { maximum: SLUG_LENGTH }, uniqueness: true

  before_validation :generate_slug
  
  private

  # Uses SecureRandom.alphanumeric to generate the "random" slug.
  # Set desired length by replacing SLUG_LENGTH
  def generate_slug
    self.slug = SecureRandom.alphanumeric(SLUG_LENGTH) if self.slug.nil? || self.slug.blank?
  end
end