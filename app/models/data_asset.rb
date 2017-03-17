class DataAsset < ActiveRecord::Base
  belongs_to :app
  has_and_belongs_to_many :metrics
end
