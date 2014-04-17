json.array!(@subjective_assessment_surveys) do |subjective_assessment|
  json.extract! subjective_assessment, :id, :dimensions, :app
  json.url subjective_assessment_url(subjective_assessment, format: :json)
end
