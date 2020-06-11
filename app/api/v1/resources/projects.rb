module API
  module V1
    class Projects < ::Grape::API
      version 'v1', using: :path

      resource :projects do
        desc "Create a project"
        params do
          requires :name, type: String, desc: 'Name'
          optional :tags, type: Hash,   desc: 'Tags'
          optional :type, type: String, desc: 'Type'
        end
        post do
          res = Project::Create.(params: params)

          fail ::Grape::Exceptions::Validation, params: res['result.contract.default'].errors.to_h unless res.success?

          res['model']
        end
      end
    end
  end
end
