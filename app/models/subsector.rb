class Subsector < ActiveRecord::Base
  belongs_to :user
  has_many :systems

  def gmed_by?(user)
    user == self.user
  end
end
