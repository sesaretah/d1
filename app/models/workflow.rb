class Workflow < ApplicationRecord
  has_many :workflow_tables, dependent: :destroy
  has_many :auxiliary_table, through: :workflow_tables

  def nodes
    @nodes = self.graph['nodes']
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
