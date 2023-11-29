// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"



const url = /api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20


fetch(/api/explore/v2.1/catalog/datasets/dechetterie/records?limit=20)
  .then(response => response.json())
  .then((data) => {
    console.log(data)
  })
