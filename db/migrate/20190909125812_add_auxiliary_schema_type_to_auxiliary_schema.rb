class AddAuxiliarySchemaTypeToAuxiliarySchema < ActiveRecord::Migration[5.2]
  def change
    add_column :auxiliary_schemas, :auxiliary_schema_type, :string
  end
end
