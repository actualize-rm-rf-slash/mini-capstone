class V1::ProductsController < ApplicationController
  def all_products_method
    products = Product.all
    render json: products.as_json
  end

  def first_product_method
    product = Product.first
    render json: product.as_json
  end

  def second_product_method
    product = Product.second
    render json: product.as_json
  end

  def third_product_method
    product = Product.third
    render json: product.as_json
  end
end
