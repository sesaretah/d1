class AddTableTypeToAuxiliaryTables < ActiveRecord::Migration[5.2]
  def change
    add_column :auxiliary_tables, :table_type, :string
  end
end
