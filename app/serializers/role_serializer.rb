class RoleSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title

end
