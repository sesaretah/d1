class Document < ApplicationRecord
  has_many :auxiliary_records
  accepts_nested_attributes_for :auxiliary_records

  def record
    result = self.as_json
    a = []
    records = []
    self.auxiliary_records.group_by(&:auxiliary_table_id).each do |auxiliary_table_id, auxiliary_records|
      auxiliary_table = AuxiliaryTable.find_by_id(auxiliary_table_id)
      if !auxiliary_table.blank?
        for auxiliary_record in auxiliary_records
          records << auxiliary_record.change_data_record
        end
        a <<  {auxiliary_table: auxiliary_table, records: records}
      end
    end
    result['auxiliaries'] = a
    return result
  end

  def self.records(items)
    results = []
    for item in items
      results << item.record
    end
    return results
  end
end
