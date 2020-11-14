ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :name, :price, :developer_id, :publisher_id, :release_date, :status, :avatar

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do
      f.input :avatar, as: :file
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  #
  # or
  #
  # permit_params do
  #   permitted = [:description, :name, :price, :developer_id, :publisher_id, :release_date, :status]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
end
