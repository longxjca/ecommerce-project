class ProductsController < ApplicationController
  def index
    # @products = Product.order(:name)
    @products = Product.includes(:developer).order("name").includes(:publisher).order("name").includes(:genres).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    genre_filter = params[:category]
    if params[:category].present?
      @products = Product.joins(:genres).where("genres.name"=>genre_filter).where("products.name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)

    else
      @products = Product.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)

    end
  end
end
