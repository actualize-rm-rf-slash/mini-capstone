require "unirest"
require "tty-table"

response = Unirest.get("http://localhost:3000/v1/all_products_url")
products = response.body
puts JSON.pretty_generate(products)

table_header = ["Id", "Name", "Price"]
table_body = products.map { |product| [product["id"], product["name"], product["price"]]}
table = TTY::Table.new table_header, table_body
puts table.render(:ascii)
