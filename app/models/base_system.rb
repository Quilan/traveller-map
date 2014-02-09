class BaseSystem < ActiveRecord::Base
  belongs_to :system
  belongs_to :base
end
