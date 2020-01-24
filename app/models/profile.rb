class Profile < ApplicationRecord
  def fullname
    self.name self.surename
  end
end
