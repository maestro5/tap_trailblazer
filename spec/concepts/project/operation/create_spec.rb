require 'rails_helper'

RSpec.describe Project::Create do
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

  subject { described_class.(params: params) }

  shared_examples 'with invalid params' do |attribute, error_message|
    it 'returns non success result' do
      expect(subject.success?).to be false
    end

    it 'does not create a record' do
      expect(subject['model'].persisted?).to be false
    end

    it 'has validation error' do
      expect(subject["contract.default"].errors.messages[attribute]).to eq([error_message])
    end
  end

  context 'when valid' do
    it 'returns success result' do
      expect(subject.success?).to be true
    end

    it 'creates a record' do
      expect(subject['model'].persisted?).to be true
    end

    it 'assigns attributes' do
      record = subject['model']

      expect(record.name).to eq(name)
      expect(record.tags).to eq(tags)
      expect(record.project_type).to eq(project_type)
    end
  end

  context 'when invalid' do
    context 'without name' do
      let(:name) { '' }

      it_behaves_like 'with invalid params', :name, "can't be blank"
    end

    context 'with already existing name' do
      let!(:project) { create(:project, name: name) }

      it_behaves_like 'with invalid params', :name, 'has already been taken'
    end

    context 'with a non-existent project type' do
      let(:project_type) { 'f' }

      it_behaves_like 'with invalid params', :project_type, 'is not included in the list'
    end
  end
end
