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
      case item['type']
      when 'Table'
        auxiliary_records = AuxiliaryRecord.where(auxiliary_table_id: item['content'].to_i)
        item['content'] = auxiliary_records
      end
    end
  end
  # def extract_content
  #   if self.format
  #     case self.format['type']
  #     when 'Select' || 'MultiSelect'
  #       self.content ? format['content'] = self.content :
  #       errors.add(:invalid_content, "Invalid Content Error")
  #       raise ActiveRecord::RecordInvalid.new(self)
  #     end
  #   end
  # end
  #
  # def content
  #   self.format['content'].split(',') if self.format && self.format['content']
  # end
end
