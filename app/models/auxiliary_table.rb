 class AuxiliaryTable < ApplicationRecord
  has_many :auxiliary_records
  has_many :workflow_tables, dependent: :destroy
  has_many :workflows, through: :workflow_tables
  before_create :add_field_id

  def add_field_id
    for item in self.data_format
      item['field_id'] = SecureRandom.uuid
    end
  end

  def title_field
    for item in self.data_format
      if item['title']
        return item['field_id']
      end
    end
  end

  def field_type(field_id)
    for item in self.data_format
      if item['field_id'] == field_id
        return item['type']
      end
    end
  end

  def field_data
    for item in self.data_format
      case item['type']
      when 'Table'
        auxiliary_table = AuxiliaryTable.find_by_id(item['content'].to_i)
        item['field_data'] = []
        if !auxiliary_table.blank?
          for auxiliary_record in auxiliary_table.auxiliary_records
            h = {}
            h['id'] = auxiliary_record.id
            h['title'] = auxiliary_record.title_field(auxiliary_table.title_field)
            item['field_data'] << h
          end
        end
      end
    end
    return self
  end

  def self.batch_field_data(items)
    results = []
    for item in items
      results << item.field_data
    end
    return results
  end

end
