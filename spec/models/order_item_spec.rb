require "rails_helper"

describe OrderItem do
  it { should belong_to :order }
  it { should belong_to :product }

  it { should validate_numericality_of(:quantity).is_greater_than_or_equal_to(1) }
end
