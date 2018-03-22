require "unirest"

system "clear"
puts "Choose an option:"
puts "[1] Signup"
puts "[2] Login"
puts "[3] Logout"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.post(
    "http://localhost:3000/v1/users",
    parameters: {
      name: "Saron",
      email: "saron@email.com",
      password: "password",
      password_confirmation: "password"
    }
  )
  p response.body
elsif input_option == "2"
  response = Unirest.post(
    "http://localhost:3000/user_token",
    parameters: {
      auth: {
        email: "saron@email.com",
        password: "password"
      }
    }
  )

  # Save the JSON web token from the response
  jwt = response.body["jwt"]
  # Include the jwt in the headers of any future web requests
  Unirest.default_header("Authorization", "Bearer #{jwt}")
elsif input_option == "3"
  jwt = ""
  Unirest.clear_default_headers()
end


puts "Press enter to continue"
gets.chomp

system "clear"
puts "Choose an option:"
puts "[1] Show all products"
puts "  [1.1] Search products with the word saber"
puts "  [1.2] Sort products by price ascending"
puts "  [1.3] Show products in weapons category"
puts "[2] Create a product"
puts "[3] Show one product"
puts "[4] Update a product"
puts "[5] Delete a product"
puts "[6] Order a product"
puts "[7] See all orders"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/products")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "1.1"
  response = Unirest.get("http://localhost:3000/v1/products?q=saber")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "1.2"
  response = Unirest.get("http://localhost:3000/v1/products?sort_by_price=true")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "1.3"
  response = Unirest.get("http://localhost:3000/v1/products?category=Weapons")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "2"
  params = {
    name: "New product",
    price: 34,
    image_url: "https://www.outbrain.com/techblog/wp-content/uploads/2017/05/road-sign-361513_960_720.jpg",
    description: "Test description"
  }
  response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
  product = response.body
  if product["errors"]
    puts "Uh oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product info:"
    puts JSON.pretty_generate(product)
  end
elsif input_option == "3"
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.get("http://localhost:3000/v1/products/#{product_id}")
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "4"
  print "Enter a product id: "
  product_id = gets.chomp
  params = {
    price: 0,
    image_url: "https://www.outbrain.com/techblog/wp-content/uploads/2017/05/road-sign-361513_960_720.jpg",
    description: "Updated description"
  }
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body
  if product["errors"]
    puts "Uh oh! Something went wrong..."
    p product["errors"]
  else
    puts "Here is your product info:"
    puts JSON.pretty_generate(product)
  end
elsif input_option == "5"
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  body = response.body
  puts JSON.pretty_generate(body)
elsif input_option == "6"
  params = {
    product_id: 2,
    quantity: 4
  }
  response = Unirest.post("http://localhost:3000/v1/orders", parameters: params)
  order = response.body
  puts JSON.pretty_generate(order)
elsif input_option == "7"
  puts "Here are all your orders"
  response = Unirest.get("http://localhost:3000/v1/orders")
  orders = response.body
  puts JSON.pretty_generate(orders)
end
