class App < ActiveRecord::Base
  has_many :dimensions

  def to_s
    name
  end
end
