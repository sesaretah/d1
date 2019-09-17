class AuxiliaryRecord < ApplicationRecord
  belongs_to :auxiliary_table

  before_create :set_uuid
  def set_uuid
    self.uuid = SecureRandom.uuid
  end

  def content
    self.data_record.each do |key, value|
      auxiliary_record = AuxiliaryRecord.find_by_uuid(value)
      if auxiliary_record
        self.data_record[key] = auxiliary_record.data_record
      end
    end
  end

  def self.with_content(items)
    for item in items
      item.content
    end
  end
end
