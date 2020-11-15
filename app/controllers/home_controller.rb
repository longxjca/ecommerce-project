class HomeController < ApplicationController
  def index
    @products = Product.order("name")
    @genres = Genre.order("name")
  end
end
