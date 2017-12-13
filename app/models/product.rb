class Product < ApplicationRecord
  has_many :order_items
  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than: 0.0 }
  before_destroy :remove_linked_items

  # Paperclip
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.jpeg"
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  def remove_linked_items
    self.order_items.destroy_all
  end
end
