module API
  module V1
    autoload :Projects, 'v1/resources/projects'

    class Engine < ::Grape::API
      format :json
      default_format :json
      default_error_formatter :json
      content_type :json, "application/json"
      version 'v1', using: :path

      mount API::V1::Projects

      get "/" do
        { timenow: Time.zone.now.to_i }
      end
    end
  end
end
