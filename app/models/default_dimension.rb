class DefaultDimension < OpenStruct

  def self.all
    @dimensions ||= load_dimensions
  end

  def self.find(name)
    all.select{|d| (d.name.downcase == name.downcase) }.first
  end

  private

  def self.load_dimensions
    dimensions_definition_file = Rails.root.join('config', 'data_quality_dimensions.yml')
    dimensions_hash = YAML.load_file(dimensions_definition_file)
    dimension_list = dimensions_hash[:dimensions]
    dimension_list.map{|d| DefaultDimension.new(d)}
  end

end