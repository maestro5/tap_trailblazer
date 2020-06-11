module API
  module V1
    class Projects < ::Grape::API
      version 'v1', using: :path

      resource :projects do
        desc "Returns projects"
        params do
          optional :page,      type: Integer, desc: 'Current Page'
          optional :per,       type: Integer, desc: 'Records On A Page'
          optional :sort_attr, type: String,  desc: 'Sort Attribute'
          optional :order,     type: String,  desc: 'Order Direction'
        end
        get "/" do
          Project::Index.(params: params)["model"]
        end

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
