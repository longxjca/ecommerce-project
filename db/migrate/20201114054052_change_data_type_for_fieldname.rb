class ChangeDataTypeForFieldname < ActiveRecord::Migration[6.0]
  def change
    change_column(:provinces, :hst, :decimal)
    remove_column(:provinces, :decimal)
  end
end
