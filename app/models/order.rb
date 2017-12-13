class Order < ApplicationRecord
  has_many :order_items
  belongs_to :user, optional: true

  before_save :calculate_total

  def item_total
    order_items.collect { |item| item.quantity }.sum
  end

  def calculate_total
    self.total_price = order_items.collect { |item| item.product.price * item.quantity }.sum
  end

  def finalize(user)
    self.user_id = user.id
    self.status = 1
    self.save
  end

  def finalized?
    return self.status == 1
  end
end
