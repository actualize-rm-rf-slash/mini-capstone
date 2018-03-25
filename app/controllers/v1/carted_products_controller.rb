class V1::CartedProductsController < ApplicationController
  def index
    # carted_products = CartedProduct.all.select {|carted_product| carted_product.user_id == current_user.id && carted_product.status == "carted"} 
    # carted_products = CartedProduct.where(user_id: current_user.id, status: "carted")
    # carted_products = current_user.carted_products.select {|carted_product| carted_product.status == "carted"}
    carted_products = current_user.carted_products.where(status: "carted")
    render json: carted_products.as_json
  end

  def create
    carted_product = CartedProduct.new(
      user_id: current_user.id,
      product_id: params[:product_id],
      quantity: params[:quantity],
      status: "carted"
    )
    carted_product.save
    render json: carted_product.as_json
  end
end
