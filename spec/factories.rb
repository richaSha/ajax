FactoryBot.define do
  factory(:user) do
    email("123@123.com")
    name("test")
    password("123")
    password_confirmation("123")
  end

  factory(:product) do
    name("Test Product")
    description("This is a test product for testing.")
    price(10)
  end

  factory(:order) do
    user
  end

  factory(:order_item) do
    product
    order
    quantity(1)
  end
end
