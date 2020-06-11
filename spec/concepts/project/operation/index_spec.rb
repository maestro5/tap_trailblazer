require 'rails_helper'

RSpec.describe Project::Index do
  let(:records_amount) { 2 }

  before { create_list(:project, records_amount) }

  it 'return a list of projects' do
    expect(described_class.({})["model"].count).to eq(records_amount)
  end
end
