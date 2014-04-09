class Value < ActiveRecord::Base
  belongs_to :metric

  validates_presence_of :metric, :value
  validates_numericality_of :value, greater_than_or_equal_to: 0.0, less_than_or_equal_to: 1.0

  # To optimize performance (avoid loading large text column for other stuff than displaying the text) check out
  #https://github.com/willbryant/columns_on_demand
  #https://github.com/choonkeat/binary_column_table
  # and compare performance.
  # Note: text columns in postgres are TOASTED (i.e. compressed by default)

end
