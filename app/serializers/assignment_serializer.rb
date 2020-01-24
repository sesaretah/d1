class AssignmentSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id
  belongs_to :user, serializer: UserSerializer
  belongs_to :role, serializer: RoleSerializer

end
