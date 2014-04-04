module ApplicationHelper
  def expectation_met_icon(thing)
    return fa_icon("check", class: 'green') if thing.expectation_met?
    fa_icon("ban", class: 'red') unless thing.expectation_met?
  end
end
