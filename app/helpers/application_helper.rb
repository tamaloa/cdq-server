module ApplicationHelper
  def expectation_met_icon(thing, stamp)
    return fa_icon("check", class: 'green') if thing.expectation_met?(stamp)
    fa_icon("ban", class: 'red') unless thing.expectation_met?(stamp)
  end

  def unique_links_for_scope(links, scope)
    links.gsub(/(<a href=')(\S*)('>)/, "\\1\\2##{scope}\\3" )
  end
end
