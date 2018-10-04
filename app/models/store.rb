class Store < ApplicationRecord
  belongs_to :user, optional: true
  has_many :products, dependent: :destroy

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\z/

end
