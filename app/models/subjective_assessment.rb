class SubjectiveAssessment < ActiveRecord::Base
  belongs_to :app
  serialize :dimensions

  validates_presence_of :app

  after_initialize :set_dimensions


  private

  def set_dimensions
    self.dimensions ||= app.dimensions.map{|d| {name: d.name, description: d.description, :assessment => ''} }
  end

end
