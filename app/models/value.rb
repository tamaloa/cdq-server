class Value < ActiveRecord::Base
  belongs_to :metric
  has_and_belongs_to_many :rollups

  validates_presence_of :metric

  after_create :add_rollup

  # To optimize performance (avoid loading large text column for other stuff than displaying the text) check out
  #https://github.com/willbryant/columns_on_demand
  #https://github.com/choonkeat/binary_column_table
  # and compare performance.
  # Note: text columns in postgres are TOASTED (i.e. compressed by default)

  private

  def add_rollup
      Rollup.add(self)
  end

end
