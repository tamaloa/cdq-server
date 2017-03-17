require 'test_helper'

class DataAssetTest < ActiveSupport::TestCase

  test "data assets should hold several metrics" do
    data_asset = DataAsset.new(name: 'some name')
    assert data_asset.metrics.empty?
    assert_nothing_raised do
      data_asset.metrics = Metric.all.limit(2)
      data_asset.save
    end
    assert_equal 2, data_asset.reload.metrics.count
  end
end
