class CreateAuxiliaryTables < ActiveRecord::Migration[5.2]
  def change
    create_table :auxiliary_tables do |t|
      t.string :title
      t.json :data_format

      t.timestamps
    end
  end
end
