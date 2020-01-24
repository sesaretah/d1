class AuxiliaryRecordSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :uuid, :auxiliary_table, :data_record, :title, :auxiliary_table_id
  #belongs_to :auxiliary_table, serializer: AuxiliaryTableSerializer

  def data_record
    object.content
  end

  def auxiliary_table
    object.auxiliary_table
  end
end
