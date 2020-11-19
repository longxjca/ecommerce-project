class ProductsController < ApplicationController
  def index
    # @products = Product.order(:name)
    @products = Product.includes(:developer).order("name").includes(:publisher).order("name").includes(:genres).page(params[:page])
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    @products = Product.where("name LIKE ?", "%#{params[:search_term]}%")

  end
end
