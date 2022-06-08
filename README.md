# Rails Engine

Rails Engine is an API providing both RESTful and non-RESTful endpoints for a user or application to consume.

The mock data provided is that of a ficticious eCommerce platform, with merchants and items.

To access the below endpoints, clone the project down, move into the project directory and start a rails server by running `rails server` in your terminal.

## Tests can be run by typing `bundle exec rspec` in your terminal from the project directory, and using the following Postman test suites:

https://www.getpostman.com/collections/a91a82a90f0c8ca26e8e

https://www.getpostman.com/collections/510d75f3df3739f655ba

## Sample of Available Endpoints
Check the Postman tests linked above for a more exhaustive list

### Get all merchants
`get` http://localhost:3000/api/v1/merchants

### Get one merchant with id # 42
`get` http://localhost:3000/api/v1/merchants/42

### Get all items for merchant with id # 42
`get` http://localhost:3000/api/v1/merchants/42/items

### Get all items
`get` http://localhost:3000/api/v1/items

### Get one item with id # 179
`get` http://localhost:3000/api/v1/items/179

### Find one merchant by name fragment "iLl"
`get` http://localhost:3000/api/v1/merchants/find?name=iLl

### Find all items by name fragment "hArU"
`get` http://localhost:3000/api/v1/items/find_all?name=hArU
