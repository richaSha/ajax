require "rails_helper"

describe Order do
  it { should have_many :order_items }
  it { should belong_to :user }

  describe '#item_total' do
    it "returns the total of an order's items' quantities" do
      order = FactoryBot.create(:order)
      order.order_items.push(FactoryBot.create(:order_item, order: order))
      order.order_items.push(FactoryBot.create(:order_item, order: order, quantity: 2))
      order.order_items.push(FactoryBot.create(:order_item, order: order))
      expect(order.item_total).to eq(4)
    end
  end

  describe '#calculate_total' do
    it "sets the cart_total to the total cost of all items in an order" do
      order = FactoryBot.create(:order)
      order.order_items.push(FactoryBot.create(:order_item, order: order))
      order.order_items.push(FactoryBot.create(:order_item, order: order, quantity: 2))
      order.order_items.push(FactoryBot.create(:order_item, order: order))
      expect(order.calculate_total).to eq(40)
    end
  end

  describe '#finalize' do
    it "marks status of order as 1 (complete)" do
      order = FactoryBot.create(:order)
      order.finalize(order.user)
      expect(order.status).to eq(1)
    end

    it "saves the user who placed the order" do
      order = FactoryBot.create(:order, user: nil)
      user = FactoryBot.create(:user)
      order.finalize(user)
      expect(order.user).to eq(user)
    end
  end

  describe '#finalized?' do
    it "returns true if order status is 1" do
      order = FactoryBot.create(:order, status: 1)
      expect(order.finalized?).to eq(true)
    end

    it "returns if order status is not 1" do
      order = FactoryBot.create(:order)
      expect(order.finalized?).to eq(false)
    end
  end
end
