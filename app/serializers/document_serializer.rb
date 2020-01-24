class DocumentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :draft, :content, :abstract, :auxiliary_records, :workflow, :workflow_state


  def auxiliary_records
    ActiveModel::SerializableResource.new(object.auxiliary_records,  each_serializer: AuxiliaryRecordSerializer ).as_json
  end

  def workflow
    WorkflowSerializer.new(object.workflow).as_json if object.workflow
  end

  def workflow_state
    WorkflowStateSerializer.new(object.workflow_state).as_json if object.workflow_state
  end

  def content
    object.send(:content).to_s
  end
end
