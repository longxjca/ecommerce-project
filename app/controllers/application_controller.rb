class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :load_cart

  private

  def initialize_session
    session[:visit_count] ||= 0
    session[:cart] ||= {}
  end

  def load_cart
    session[:cart].transform_keys { |product_id| Product.find(product_id) }
    # Product.find(session[:cart])
  end
end
