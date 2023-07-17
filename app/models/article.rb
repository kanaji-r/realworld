class Article < ApplicationRecord
  before_validation :generate_slug
  validates :title, presence: true
  validates :description, presence: true
  validates :body, presence: true

  private

  def generate_slug
    self.slug = title.parameterize
  end
end
