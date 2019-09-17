class AddWorkflowIdToAuxiliarySchema < ActiveRecord::Migration[5.2]
  def change
    add_column :auxiliary_schemas, :workflow_id, :integer
  end
end
