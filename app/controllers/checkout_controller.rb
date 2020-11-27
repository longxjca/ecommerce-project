class CheckoutController < ApplicationController
  def create
    # loop the cart and produce an array of line items:
    # product = Product.find(params[:id])
    line_items_array = []
    subtotal = 0

    load_cart.each do |product, quantity|
      each_product =
        {
          name:        product.name,
          description: product.description,
          amount:      (product.price * 100).to_i,
          currency:    "cad",
          quantity:    quantity.to_i

        }

      line_items_array << each_product
      # line_items_array << each_tax
      subtotal += (product.price * 100).to_i * quantity.to_i
    end

    if line_items_array.blank?
      redirect_to root_pah
      return
    end

    # calculate tax
    tax = []
    grand_total = subtotal
    if current_user.province.hst
      hst_amount = (subtotal * current_user.province.hst).to_i
      tax << {
        name:     "HST",
        amount:   hst_amount,
        currency: "cad",
        quantity: 1
      }
      grand_total += hst_amount
    else
      if current_user.province.pst
        pst_amount = (subtotal * current_user.province.pst).to_i
        tax << {
          name:     "PST",
          amount:   pst_amount,
          currency: "cad",
          quantity: 1
        }
        grand_total += pst_amount
      end

      if current_user.province.gst
        gst_amount = (subtotal * current_user.province.gst).to_i
        tax << {
          name:     "GST",
          amount:   gst_amount,
          currency: "cad",
          quantity: 1
        }
        grand_total += gst_amount
      end
    end
    # instert order
    order_entry = current_user.orders.find_or_create_by(
      shipping_address: current_user.default_shipping_address,
      status:           "new",
      purchased_pst:    current_user.province.pst,
      purchased_gst:    current_user.province.gst,
      purchased_hst:    current_user.province.hst,
      subtotal:         grand_total.to_f / 100
    )
    load_cart.each do |product, quantity|
      ProductOrder.find_or_create_by(
        product:            product,
        order:              order_entry,
        purchased_price:    product.price,
        purchased_quantity: quantity
      )
    end
    # setting up a stripe session for payment
    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      line_items:           line_items_array + tax,
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
