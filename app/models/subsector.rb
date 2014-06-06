class Subsector < ActiveRecord::Base
  belongs_to :user
  has_many :systems
end
