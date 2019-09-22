class CreateWorkflowTables < ActiveRecord::Migration[5.2]
  def change
    create_table :workflow_tables do |t|
      t.integer :workflow_id
      t.integer :auxiliary_table_id
      t.integer :rank, default: 0

      t.timestamps
    end
  end
end
