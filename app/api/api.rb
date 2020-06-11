module API
  module V1
    autoload :Engine, 'v1/engine'
  end

  class Engine < ::Grape::API
    rescue_from Grape::Exceptions::Validation do |e|
      Rack::Response.new({'errors' => e.params}.to_json, 422, {"Content-Type" => "application/json"})
    end

    mount API::V1::Engine
  end
end
