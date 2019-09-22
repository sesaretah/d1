class AuxiliaryRecord < ApplicationRecord
  belongs_to :auxiliary_table

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
    self.data_record.each do |key, value|
      if self.auxiliary_table.field_type(key) == 'Table'
        title_field = AuxiliaryRecord.find(value).auxiliary_table.title_field
        self.data_record[key] = AuxiliaryRecord.find(value).data_record[title_field]
      end
    end
    return self
  end

  def title_field(p)
    self.data_record[p]
  end
end
