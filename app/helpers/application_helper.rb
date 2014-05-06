module ApplicationHelper
  def expectation_met_icon(thing, stamp)
    return fa_icon("check", class: 'green') if thing.expectation_met?(stamp)
    fa_icon("ban", class: 'red') unless thing.expectation_met?(stamp)
  end
end
