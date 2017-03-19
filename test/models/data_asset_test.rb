require 'test_helper'

class DataAssetTest < ActiveSupport::TestCase

  def setup
    @data_asset = DataAsset.new(name: 'a brand new one')
  end

  test "data assets should hold several metrics" do
    data_asset = DataAsset.new(name: 'some name')
    assert data_asset.metrics.empty?
    assert_nothing_raised do
      data_asset.metrics = Metric.all.limit(2)
      data_asset.save
    end
    assert_equal 2, data_asset.reload.metrics.count
  end

  test "data asset should report a current score" do
    assert @data_asset.current_score
  end

  test "current_score should be average of last metric results" do
    data_asset = DataAsset.first
    data_asset.metrics.each{|m| m.record(0.5) }

    assert_equal 0.5, data_asset.current_score
  end

  test "data asset score should not report a value for metrics without values" do
    3.times do
      @data_asset.metrics << Metric.new
    end

    assert_nil @data_asset.score(Time.now)
  end

end
