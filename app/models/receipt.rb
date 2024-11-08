class Receipt < ApplicationRecord
  has_one_attached :image

  validates :seller, presence: true
  validates :description, presence: true
  validates :total_amount, presence: true, numericality: { greater_than_or_equal_to: 0 }, format: { with: /\A\d+(?:\.\d{1,2})?\z/ }
  validates :date, presence: true
  validates :image, presence: true
  validate :acceptable_attachment

  private

  def acceptable_attachment
    return unless image.attached?

    # Increase max size to accommodate PDFs
    unless image.blob.byte_size <= 20.megabyte
      errors.add(:image, "is too big (should be less than 20MB)")
    end

    acceptable_types = [ "image/jpeg", "image/png", "image/heic", "application/pdf" ]
    unless acceptable_types.include?(image.content_type)
      errors.add(:image, "must be a JPEG, PNG, HEIC, or PDF")
    end
  end
end
