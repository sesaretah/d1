class WorkflowState < ApplicationRecord
  belongs_to :workflow

  def refundable
    self.node_attr['refundable'] == "1" ? true : false
  end

  def commentable
    self.node_attr['commentable'] == "1" ? true : false
  end

  def publishable
    self.node_attr['publishable'] == "1" ? true : false
  end

  def votable
    self.node_attr['votable'] == "1" ? true : false
  end

  def start_point
    self.node_attr['start_point'] == "1" ? true : false
  end

  def end_point
    self.node_attr['end_point'] == "1" ? true : false
  end
end
