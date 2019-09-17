class CreateWorkfolwTables < ActiveRecord::Migration[5.2]
  def change
    create_table :workfolw_tables do |t|
      t.integer :workflow_d
      t.integer :auxiliary_table_id
      t.integer :rank, default: 0

      t.timestamps
    end
  end
end
