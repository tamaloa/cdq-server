module ApplicationHelper
  def expectation_met_icon(dimension)
    return fa_icon("check", class: 'green') if dimension.expectation_met?
    fa_icon("ban", class: 'red') unless dimension.expectation_met?
  end
end
