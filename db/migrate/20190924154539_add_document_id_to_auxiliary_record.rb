class AddDocumentIdToAuxiliaryRecord < ActiveRecord::Migration[5.2]
  def change
    add_column :auxiliary_records, :document_id, :integer
  end
end
