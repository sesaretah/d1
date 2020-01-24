class AuxiliaryRecord < ApplicationRecord
  belongs_to :auxiliary_table
  belongs_to :document, optional: true
  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.uuid
  end


  def self.with_content(items)
    for item in items
      item.change_data_record
    end
  end

  def change_data_record
    self.data_record.each do |record|
      if self.auxiliary_table.field_type(record['field_id']) == 'Table'
        auxiliary_record = AuxiliaryRecord.find(record['value'])
        title_field = auxiliary_record.auxiliary_table.title_field
        for item in auxiliary_record.data_record
          if item['field_id'] == title_field
            record['value'] = item['value']
          end
        end
      end
    end
    return self
  end

  def title_field(p)
    for item in self.data_record
      if item['field_id'] == p
        return item['value']
      end
    end
  end

  def self.batch_build(items, document_id)
    data_records = AuxiliaryRecord.extract_data_records(items)
    auxiliary_table_ids = AuxiliaryRecord.extract_auxiliary_table_ids(items)
    for auxiliary_table_id in auxiliary_table_ids
      auxiliary_table = AuxiliaryTable.find(auxiliary_table_id)
      AuxiliaryRecord.remove_records(document_id, auxiliary_table_id)
      AuxiliaryRecord.create(document_id: document_id,auxiliary_table_id: auxiliary_table.id, data_record: data_records[auxiliary_table.id])#.inject(:merge!))
    end
  end

  def self.extract_data_records(items)
    data_records = Hash.new{|h,k| h[k] = [] }
    for item in items
      auxiliary_table = AuxiliaryTable.find_by_key(item['field_id'])
      if !auxiliary_table.blank?
        data_records[auxiliary_table.id].push({"field_id" => "#{item['field_id']}", "value" => "#{item['value']}"})
      end
    end
    return data_records
  end

  def self.extract_auxiliary_table_ids(items)
    auxiliary_table_ids = []
    for item in items
      auxiliary_table = AuxiliaryTable.find_by_key(item['field_id'])
      if !auxiliary_table.blank?
        auxiliary_table_ids << auxiliary_table.id
      end
    end
    return auxiliary_table_ids.uniq
  end

  def self.remove_records(document_id, auxiliary_table_id)
    for auxiliary_record in AuxiliaryRecord.all_records(document_id, auxiliary_table_id)
      auxiliary_record.destroy
    end
  end

  def self.all_records(document_id, auxiliary_table_id)
    AuxiliaryRecord.where(document_id: document_id, auxiliary_table_id: auxiliary_table.id)
  end

end
