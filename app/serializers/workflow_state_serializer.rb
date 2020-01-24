class WorkflowStateSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :workflow_id, :refundable, :commentable, :publishable, :votable, :start_point, :end_point

end
