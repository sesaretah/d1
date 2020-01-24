class Workflow < ApplicationRecord
  has_many :workflow_tables, dependent: :destroy
  has_many :auxiliary_table, through: :workflow_tables

  has_many :workflow_states, dependent: :destroy

  after_save :extract_workflow_states


  def start_states
    states = []
    for workflow_state in self.workflow_states
      states << workflow_state if workflow_state.start_point
    end
    return states
  end


  def nodes
    @nodes = self.graph['nodes']
  end

  def extract_workflow_states
    for node in self.nodes
      if !node['title'].blank?
        WorkflowState.create(workflow_id: self.id, title: node['title'], node_id: node['id'], node_attr: node)
      end
    end
  end

  def find_node_index(nodes, node_id)
    for node in nodes
      if node['id'] == node_id
        return nodes.index(node)
      end
    end
  end

  def edges
    nodes = self.nodes
    result = []
    self.graph['edges'].each do |edge|
      source =  find_node_index(nodes, edge['source']['id'])
      target =  find_node_index(nodes, edge['target']['id'])
      result << [source, target]
    end
    return result
  end
end
