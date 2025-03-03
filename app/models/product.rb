class Product < ApplicationRecord
  has_one_attached :image

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item




  validates :title, :description, :image, presence: true

  validates :price, numericality: { greater_than_or_equal_to: 0.01 }

  validates :title, uniqueness: true

  validate :acceptable_image




  def acceptable_image
    return unless image.attached?
    acceptable_types = ['image/jpeg', 'image/png', 'image/gif']
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a GIF, JPG or PNG image")
    end
  end # END def




  private

  # Ensure that there are no line-items referencing this product.
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      # IF the hook method throws :abort, then row isn't destroyed.
      throw :abort
    end
  end # END def




end # END class
