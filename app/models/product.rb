class Product < ApplicationRecord
  def is_discounted
    price <= 2
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def as_json
    {
      id: id,
      name: name,
      description: description,
      image_url: image_url,
      price: price,
      tax: tax,
      total: total,
      is_discounted: is_discounted
    }
  end
end
