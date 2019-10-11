class AddDarftToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :draft, :json
  end
end
