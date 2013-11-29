class Dimension < ActiveRecord::Base
  belongs_to :app
  has_many :metrics

  def to_s
    name
  end
end
