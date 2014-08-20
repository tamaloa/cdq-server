require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase

  test "unique_links_for_scope should not mutilate urls" do
    text_containing_links = "<a href='http://ipib.ci.***REMOVED***/companies/richter-werdermann-gerbaulet-hofmann'>richter-werdermann-gerbaulet-hofmann</a> failed Company-dq-test_CO-005.<br>"
    text_with_unique_links = unique_links_for_scope(text_containing_links, "bla")

    assert text_with_unique_links.match('http://ipib.ci.***REMOVED***/companies/richter-werdermann-gerbaulet-hofmann')
  end
end
