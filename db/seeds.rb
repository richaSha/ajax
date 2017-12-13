class Seed

  def self.begin
    seed = Seed.new
    seed.destroy_old_data
    seed.generate_products
  end

  def destroy_old_data
    OrderItem.destroy_all
    Order.destroy_all
    Product.destroy_all
  end

  def generate_products

    50.times do |i|
      Product.create!(
        name: Faker::Name.name,
        price: Faker::Number.between(1, 100),
        description: Faker::Lorem.sentence(20, false, 0).chop,
        image: open("public/images/smaple.png")
      )
    end
  end
end

Seed.begin
