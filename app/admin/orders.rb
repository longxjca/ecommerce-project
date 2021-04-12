ActiveAdmin.register Order do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :subtotal, :status, :shipping_address, :stripe_intent_id, :user_id, :purchased_pst, :purchased_gst, :purchased_hst
  #
  # or
  #
  # permit_params do
  #   permitted = [:subtotal, :status, :shipping_address, :stripe_intent_id, :user_id, :purchased_pst, :purchased_gst, :purchased_hst]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
