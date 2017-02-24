require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "unique_links_for_scope should not mutilate urls" do
    text_containing_links = Metric.find(2).improvement_advice
    text_with_unique_links = unique_links_for_scope(text_containing_links, "bla")

    assert text_with_unique_links.match('http://my-application.example.org/some_url/big-company')
  end
end
