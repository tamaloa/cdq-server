require 'test_helper'

class Dummy; include Calculations; end

class CalculationsTest < ActiveSupport::TestCase

  def setup
    @dummy = Dummy.new
  end

  test "calculation should return 0.0 for no input" do
    assert 0.0, @dummy.weighted_average
  end

  test "calculation should return 0.0 for input of 0.0" do
    input = [{value: 0.0, weight: 1}]
    assert 0.0, @dummy.weighted_average(input)
  end

  test "calculation should return weighed average" do
    input = [{value: 0.5, weight: 1}, {value: 0.5, weight: 1}, {value: 0.0, weight: 2}]
    assert 0.25, @dummy.weighted_average(input)
  end

end