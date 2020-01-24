class AuxiliaryTableSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :data_format
  has_many :auxiliary_records, serializer: AuxiliaryRecordSerializer
  #has_many :content, serializer: AuxiliaryTableSerializer
  def data_format
    object.content
  end
end
