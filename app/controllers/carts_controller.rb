# app/controllers/carts_controller.rb
class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
  end

  def add_item
    @cart = current_user.cart || current_user.create_cart
    @product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity ||= 0
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to cart_path(@cart)
  end

  def remove_item
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path(@cart)
  end

  def update_item
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update(quantity: params[:quantity])
    redirect_to cart_path(@cart)
  end
end
