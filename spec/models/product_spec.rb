require "rails_helper"

describe Product do
  it { should have_many :order_items }

  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than(0.0) }

  describe '#remove_linked_items' do
    it "removes any linked order items" do
      product = FactoryBot.create(:product)
      item = FactoryBot.create(:order_item, product: product)
      product.destroy
      expect(OrderItem.all).to eq([])
    end
  end
end
