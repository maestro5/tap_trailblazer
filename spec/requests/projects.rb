require 'rails_helper'

RSpec.describe API::V1::Projects do
  context 'POST /api/v1/projects' do
    let(:name)         { "Test Project" }
    let(:tags)         { { 'tag1' => 'tag test'} }
    let(:project_type) { Project.project_types.keys.first }

    let(:params) do
      {
        name:         name,
        tags:         tags,
        project_type: project_type
      }
    end

    before { post '/api/v1/projects', params: params }

    context 'with invalid params' do
      let(:name) { '' }
      let(:error_message) { "can't be blank" }

      it 'returns 422 status' do
        expect(response.status).to eq(422)
      end

      it 'returns an validation error' do
        response_data = JSON.parse(response.body)

        expect(response_data['errors']).to be_present
        expect(response_data['errors']['name']).to eq(error_message)
      end
    end

    context 'with valid params' do
      it 'returns 201 status' do
        expect(response.status).to eq(201)
      end

      it 'creates a project' do
        response_data = JSON.parse(response.body)

        expect(response_data['id']).to be_present
        expect(response_data['name']).to eq(name)
        expect(response_data['tags']).to eq(tags)
        expect(response_data['project_type']).to eq(project_type)
      end
    end
  end
end
