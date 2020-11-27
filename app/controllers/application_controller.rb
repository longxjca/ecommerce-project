class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :load_cart

  before_action :add_permitted_parameters, if: :devise_controller?

  protected

  def add_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[default_shipping_address province_id])
  end

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
