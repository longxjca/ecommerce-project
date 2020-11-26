class CheckoutController < ApplicationController
  def create
    # loop the cart and produce an array of line items:
    # product = Product.find(params[:id])
    line_items_array = []
    tax_array = []

    load_cart.each do |product, quantity|
      each_product =
        {
          name:        product.name,
          description: product.description,
          amount:      (product.price * 100).to_i,
          currency:    "cad",
          quantity:    quantity.to_i

        }
      # each_tax =
      #   {
      #     name:        "GST",
      #     description: "Goods and Services Tax",
      #     amount:      (product.price * 0.05 * 100).to_i,
      #     currency:    "cad",
      #     quantity:    quantity.to_i

      #   }
      line_items_array << each_product
      # line_items_array << each_tax
    end

    if line_items_array.nil?
      redirect_to root_pah
      return
    end
    # setting up a stripe session for payment
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items:           line_items_array,
      success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
      cancel_url:           checkout_cancel_url
    )

    respond_to do |format|
      format.js
    end
  end

  def cancel; end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)
  end
end
