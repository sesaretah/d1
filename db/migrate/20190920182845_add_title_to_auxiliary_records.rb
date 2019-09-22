class AddTitleToAuxiliaryRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :auxiliary_records, :title, :string
  end
end
