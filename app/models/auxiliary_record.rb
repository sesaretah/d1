class AuxiliaryRecord < ApplicationRecord
  belongs_to :auxiliary_table
  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def title
    title_field_id = self.auxiliary_table.title_field_id
    for item in self.data_record
      return item['value'] if item['field_id'] == title_field_id
    end
  end

  def content
    auxiliary_table = self.auxiliary_table
    for item in self.data_record
      auxiliary_record = AuxiliaryRecord.find_by_id(item['value'])
      item['value'] = auxiliary_record.title if auxiliary_record && auxiliary_table.field_type(item['field_id']) == 'Table'
    end
  end

  def self.batch_save(items, document_id)
    for item in items
      item.permit!
      auxiliary_record = AuxiliaryRecord.new(auxiliary_table_id: item['auxiliary_table_id'], data_record: item['data_record'])
      auxiliary_record.document_id = document_id
      auxiliary_record.save!
    end
  end
end
