class WorkflowTable < ApplicationRecord
  belongs_to :workflow
  belongs_to :auxiliary_table
  def self.grouped
    a = []
     WorkflowTable.all.group_by(&:workflow).each do |workflow, workflow_tables|
       a << { "#{workflow.id}" => workflow_tables}
     end
     return a
  end
end
