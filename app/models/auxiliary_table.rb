class AuxiliaryTable < ApplicationRecord

  has_many :auxiliary_records

  before_create :add_field_id

  def add_field_id
    for item in self.data_format
      item['field_id'] = SecureRandom.uuid
    end
  end


  def content
    for item in self.data_format
      if item['type'] == 'Table'
         auxiliary_table = AuxiliaryTable.find_by_id(item['content'].to_i)
         item['content'] = AuxiliaryTableSerializer.new(auxiliary_table).as_json if auxiliary_table
      end
    end
  end

  def title_field_id
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

end
