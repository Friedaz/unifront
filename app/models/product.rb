class Product < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :reviews
  has_many :image, dependent: :destroy
  before_destroy :ensure_not_referenced_by_any_line_item

  belongs_to :user
  belongs_to :store

  has_attached_file :image,  :styles => { large: "600x600>", medium: "300x300>",  small: "120x80>", thumb: "100x100>" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  scope :recent, -> { where('expired > :date', date: DateTime.now) }


  private
    # ensure that there are no line items referencing this product
    def ensure_not_referenced_by_any_line_item
     unless line_items.empty?
      errors.add(:base, 'Line Items present')
      throw :abort
    end
  end
end
