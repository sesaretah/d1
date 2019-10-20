class CreateWorkflowStates < ActiveRecord::Migration[5.2]
  def change
    create_table :workflow_states do |t|
      t.string :title
      t.integer :workflow_id
      t.integer :node_id
      t.json :node_attr

      t.timestamps
    end
  end
end
