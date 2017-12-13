module CartHelper
  def cart_items
    current_order.item_total
  end
end
