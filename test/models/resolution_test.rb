require 'test_helper'

class ResolutionTest < ActiveSupport::TestCase
  test "raise exception for not available resolution" do
    assert_raises ResolutionException do
      Resolution.utc_timestamp_for(:non_existing_resolution)
    end
  end


end
