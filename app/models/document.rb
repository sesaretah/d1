class Document < ApplicationRecord
  has_many :auxiliary_records
  belongs_to :workflow_state, optional: true
  accepts_nested_attributes_for :auxiliary_records

  def workflow
    self.workflow_state.workflow if self.workflow_state
  end

  def auxiliaries
    #result = self.as_json
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
    #result['auxiliaries'] = a
    return a
  end
end
