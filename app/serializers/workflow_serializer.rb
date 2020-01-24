class WorkflowSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :details, :graph, :start_states, :nodes, :edges

  def start_states
    ActiveModel::SerializableResource.new(object.start_states,  each_serializer: WorkflowStateSerializer ).as_json
  end

  def nodes
    object.nodes
  end

  def edges
    object.edges
  end
end
