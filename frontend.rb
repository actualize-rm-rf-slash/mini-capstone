require "unirest"

system "clear"
puts "Choose an option:"
puts "[1] Show all products"
puts "[2] Create a product"
puts "[3] Show one product"
puts "[4] Update a product"
puts "[5] Delete a product"

input_option = gets.chomp
if input_option == "1"
  response = Unirest.get("http://localhost:3000/v1/products")
  products = response.body
  puts JSON.pretty_generate(products)
elsif input_option == "2"
  params = {
    name: "Test Name",
    price: 100,
    image_url: "https://www.outbrain.com/techblog/wp-content/uploads/2017/05/road-sign-361513_960_720.jpg",
    description: "Test description"
  }
  response = Unirest.post("http://localhost:3000/v1/products", parameters: params)
  product = response.body
  puts JSON.pretty_generate(product)
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
    name: "Updated Name",
    price: 0,
    image_url: "https://www.outbrain.com/techblog/wp-content/uploads/2017/05/road-sign-361513_960_720.jpg",
    description: "Updated description"
  }
  response = Unirest.patch("http://localhost:3000/v1/products/#{product_id}", parameters: params)
  product = response.body
  puts JSON.pretty_generate(product)
elsif input_option == "5"
  print "Enter a product id: "
  product_id = gets.chomp
  response = Unirest.delete("http://localhost:3000/v1/products/#{product_id}")
  body = response.body
  puts JSON.pretty_generate(body)
end
