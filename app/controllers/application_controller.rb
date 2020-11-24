class ApplicationController < ActionController::Base
  before_action :initialize_session
  helper_method :load_cart

  private

  def initialize_session
    session[:visit_count] ||= 0
    session[:cart] ||= []
  end

  def load_cart
    Product.find(session[:cart])
  end
end
