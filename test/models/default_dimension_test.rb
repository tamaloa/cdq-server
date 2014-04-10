require 'test_helper'

class DefaultDimensionTest < ActiveSupport::TestCase

  test "DimensionDefault should load dimensions specified in file" do
    assert DefaultDimension.all.is_a?(Array)
    assert DefaultDimension.all.first.is_a?(DefaultDimension)
    assert DefaultDimension.all.first.name.is_a?(String)
    assert DefaultDimension.all.first.description.is_a?(String)
  end

  test "DimensionDefault should find Dimension if given name" do
    availability = DefaultDimension.find('Availability')

    assert availability.is_a?(DefaultDimension)
    assert_equal 'The degree to which system availability and response times can be guaranteed.', availability.description
  end

  test "finding dimension should be case insensitive" do
    availability = DefaultDimension.find('availAbility')
    assert availability.is_a?(DefaultDimension)
    assert_equal 'The degree to which system availability and response times can be guaranteed.', availability.description
  end

  test "We should have 23 default dimensions to choose from" do
    assert_equal 23, DefaultDimension.all.count
  end

end
