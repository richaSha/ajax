require "rails_helper"

describe "the cart management path" do
  before do
    @user = FactoryBot.create(:user)
    visit '/sign_in'
    fill_in "Email", with: @user.email
    fill_in "Password", with: @user.password
    click_on "sign_in_button"
  end

  it "allows a user to add items to their cart" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    expect(page).to have_content("Cart | Total Items: 1")
  end

  it "allows a user to remove items from their cart" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    expect(page).to have_content("Cart | Total Items: 1")
    visit cart_path
    click_on "Remove"
    expect(page).to have_no_content(product.name)
    expect(page).to have_content("Cart | Total Items: 0")
  end

  it "allows an authenticated user to finalize their cart order" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    expect(page).to have_content("Cart | Total Items: 1")
    visit cart_path
    click_on "Finalize Order"
    expect(@user.orders.last.status).to eq(1)
  end

  it "does not allow an unauthenticated user to finalize a cart" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    click_on "Sign out"
    visit finalize_path
    expect(page).to have_content("You need to sign up or sign in to complete your order.")
    expect(Order.first.status).to eq(nil)
  end

  it "displays an authenticated user's order history on their cart page" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    expect(page).to have_content("Cart | Total Items: 1")
    visit cart_path
    click_on "Finalize Order"
    expect(page).to have_content("Order History")
    expect(page).to have_content(product.name)
  end

  it "does not display order history for unauthenticated users" do
    product = FactoryBot.create(:product)
    visit product_path(product)
    click_button "add_to_cart"
    expect(page).to have_content("Cart | Total Items: 1")
    visit cart_path
    click_on "Finalize Order"
    click_on "Sign out"
    visit cart_path
    expect(page).to have_no_content("Order History")
  end
end
