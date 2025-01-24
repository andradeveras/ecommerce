class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find(params[:id])
  end

  def add_item
    @cart = current_user.cart
    @product = Product.find(params[:product_id])
    @cart_item = @cart.cart_items.find_or_initialize_by(product: @product)
    @cart_item.quantity += 1
    @cart_item.save
    redirect_to cart_path
  end

  def remove_item
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.destroy
    redirect_to cart_path
  end

  def update_item
    @cart = current_user.cart
    @cart_item = @cart.cart_items.find(params[:id])
    @cart_item.update(quantity: params[:quantity])
    redirect_to cart_path
  end
end
