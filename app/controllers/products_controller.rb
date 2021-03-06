class ProductsController < ApplicationController
  def index
    # @products = Product.order(:name)
    @products = Product.includes(:developer).order("name").includes(:publisher).order("name").includes(:genres).page(params[:page])

    # session[:visit_count] ||= 0
    # session[:visit_count] += 1
    # @visit_count = session[:visit_count]
  end

  def show
    @product = Product.find(params[:id])
  end

  def search
    wildcard_search = "%#{params[:keywords]}%"
    genre_filter = params[:category]
    time_filter = params[:time]

    @products = Product.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)
    if time_filter == "New"
      # @products = Product.where(created_at: Time.zone.now)
      @products = @products.where(created_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
    elsif time_filter == "Recently Updated"
      @products = @products.where(updated_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
    end

    if params[:category].present?
      @products = Product.joins(:genres).where("genres.name"=>genre_filter).where("products.name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)

      # else
      #   @products = Product.where("name LIKE ? OR description LIKE ?", wildcard_search, wildcard_search)

    end
    @products = @products.page(params[:page])
  end

  # def filter_by_new
  #   @products = Product.where(created_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
  # end

  # def filter_by_updated
  #   @products = Product.where(updated_at: (Time.now.getlocal - 1.day)..Time.now.getlocal)
  # end

  def add_to_cart
    id = params[:id].to_i
    quantity = params[:game]["quantity"].to_i
    # session[:cart] << id unless session.include?(id)
    session[:cart][id] = quantity
    flash[:notice] = "#{Product.find(id).name} added to your cart."

    redirect_to products_path
  end

  def remove_from_cart
    id = params[:id].to_i
    session[:cart].delete(id.to_s)
    flash[:notice] = "#{Product.find(id).name} removed from your cart."
    redirect_to products_path
  end

  private

  def increment_visit_count
    session[:visit_count] += 1
    @visit_count = session[:visit_count]
  end
end
