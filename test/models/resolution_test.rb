require 'test_helper'

class ResolutionTest < ActiveSupport::TestCase
  test "raise exception for not available resolution" do
    assert_raises ResolutionException do
      Resolution.utc_timestamp_for(:non_existing_resolution)
    end
  end

  test "getting normalized timestamp depending on resolution" do
    assert Resolution.utc_timestamp_for(:year, Time.now)
    assert Resolution.utc_timestamp_for(:hour, Time.now)
  end

  test "timestamp normalization acts as expected" do
    timestamp = Time.parse("2013-12-06 15:36:35 UTC")
    assert_equal "2013-12-06 15:00:00 UTC", Resolution.utc_timestamp_for(:hour, timestamp).to_s
    assert_equal "2013-12-06 00:00:00 UTC", Resolution.utc_timestamp_for(:day, timestamp).to_s
    assert_equal "2013-12-02 00:00:00 UTC", Resolution.utc_timestamp_for(:week, timestamp).to_s
    assert_equal "2013-12-01 00:00:00 UTC", Resolution.utc_timestamp_for(:month, timestamp).to_s
    assert_equal "2013-01-01 00:00:00 UTC", Resolution.utc_timestamp_for(:year, timestamp).to_s
  end

end
