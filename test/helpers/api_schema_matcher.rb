module ApiSchemaMatcher
  def match_response_schema(schema, list=false)
    schema_directory = "#{ Rails.root }/test/fixtures/api/schemas"
    schema_path = "#{ schema_directory }/#{ schema }.json"
    JSON::Validator.validate!(schema_path, response.body, list: list)
  end
end