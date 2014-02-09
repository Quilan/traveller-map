class Base < ActiveRecord::Base

  has_many :base_systems
  has_many :systems, through: :base_systems
end
