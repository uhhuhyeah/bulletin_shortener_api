class Link < ActiveRecord::Base
  # DateHelper gives time_ago_in_words
  # TODO - build a presenter object so that we can move
  #        view logic out of the model
  include ActionView::Helpers::DateHelper
  SLUG_LENGTH = 6

  validates :url, presence: true, length: { maximum: 255 }
  validates :slug, presence: true, length: { maximum: SLUG_LENGTH }, uniqueness: true

  before_validation :generate_slug

  def self.shorten(url)
    self.where(url: url).first_or_create!
  end
  
  private

  # Uses SecureRandom.alphanumeric to generate the "random" slug.
  # Set desired length by replacing SLUG_LENGTH
  def generate_slug
    self.slug = SecureRandom.alphanumeric(SLUG_LENGTH) if self.slug.nil? || self.slug.blank?
  end

  # TODO - build a presenter object so that we can move
  #        view logic out of the model
  def time_since_creation
    time_ago_in_words(self.created_at || Time.now)
  end
end