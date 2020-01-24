class AddWorkflowStateIdToDocuments < ActiveRecord::Migration[5.2]
  def change
    add_column :documents, :workflow_state_id, :integer
  end
end
