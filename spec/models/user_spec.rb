require "rails_helper"

describe User do
  it { should have_many :orders }

  it { should validate_presence_of :name }
  it { should validate_presence_of :email }
  it { should validate_presence_of :password }
  it { should validate_presence_of :password_confirmation }
  it { should validate_uniqueness_of :name }
  it { should validate_uniqueness_of :email }

  describe '#previous_orders' do
    it "eturns all user assigned orders with status 2" do
      user = FactoryBot.create(:user, name: "123", email: "123@123.com")
      order1 = FactoryBot.create(:order, user: user, status: 1)
      user.orders.push(order1)
      order2 = FactoryBot.create(:order, user: user)
      user.orders.push(order2)
      order3 = FactoryBot.create(:order, user: user, status: 1)
      user.orders.push(order3)
      expect(user.previous_orders).to eq([order1, order3])
    end
  end
end
