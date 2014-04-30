module Calculations
  extend ActiveSupport::Concern

  def weighted_average(input = [])
    return nil if input.empty?
    weighted_values = input.map{|i| i[:value] * i[:weight]}
    weighted_values.sum / input.map{|i| i[:weight]}.sum
  end

end