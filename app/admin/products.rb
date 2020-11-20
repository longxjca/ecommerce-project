ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :description, :name, :price, :developer_id, :publisher_id, :release_date, :status, :avatar, genre_products_attributes: %i[id product_id genre_id _destroy]

  # show do |product|
  #   attributes_table do
  #     row :name
  #     row :price
  #     row :genres do |product|
  #       product.genres.map { |bg| bg.name }.join(", ").html_safe
  #     end
  #   end
  # end

  form do |f|
    f.semantic_errors # shows errors on :base

    f.inputs "Product" do
      f.input :developer, as: :select
      f.input :publisher, as: :select
      f.input :description
      f.input :name
      f.input :price
      f.input :release_date
      f.input :status
      f.input :image
      f.input :avatar
      # f.input :image
      f.has_many :genre_products, allow_destroy: true do |n_f|
        n_f.input :genre
      end
    end

    f.inputs do
      f.input :avatar, as: :file, hint: f.object.avatar.present? ? image_tag(f.object.avatar) : ""
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
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
