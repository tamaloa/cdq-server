class Value < ActiveRecord::Base
  belongs_to :metric
  has_and_belongs_to_many :rollups
end
