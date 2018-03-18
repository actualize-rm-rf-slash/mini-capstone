class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :description, presence: true
  validates :description, length: { in: 10..500 }

  # a product belongs to a supplier
  def supplier
    Supplier.find_by(id: supplier_id)
  end

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
      is_discounted: is_discounted,
      supplier: supplier.as_json
    }
  end
end
