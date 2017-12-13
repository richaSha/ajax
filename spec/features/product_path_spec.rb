require "rails_helper"

describe "the product management path" do
  before do
    @user = FactoryBot.create(:user)
    visit '/sign_in'
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "sign_in_button"
  end

  it "allows administrators to add products" do
    @user.update(admin: true)
    visit root_path
    click_on "Add a Product"
    fill_in "Name", with: "A New Product"
    fill_in "Description", with: "This product is new."
    fill_in "Price", with: 10
    click_button "Submit"
    expect(page).to have_content("A New Product")
  end

  it "allows administrators to edit products" do
    @user.update(admin: true)
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_on "Edit"
    fill_in "Name", with: "A Different Name"
    click_button "Submit"
    expect(page).to have_no_content(product.name)
    expect(page).to have_content("A Different Name")
  end

  it "allows administrators to delete products" do
    @user.update(admin: true)
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_on "Delete"
    expect(page).to have_no_content(product.name)
  end

end
