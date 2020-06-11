require 'rails_helper'

RSpec.describe Project::Poro do
  let(:records) { Project.all }
  let(:options) { {} }

  subject { described_class.call(records, options) }

  before { create_list(:project, 3) }

  context 'pagination' do
    context 'with default options' do
      it 'returns all records' do
        expect(subject.count).to eq(records.count)
      end
    end

    context 'with page and per options' do
      let(:page) { 1 }
      let(:per)  { 2 }

      let(:options) do
        {
          'page' => page,
          'per'  => per
        }
      end

      context 'on first page' do
        it 'returns per records' do
          expect(subject.count).to eq(per)
        end
      end

      context 'on second page' do
        let(:page) { 2 }

        it 'returns rest of records' do
          expect(subject.count).to eq(records.count - per)
        end
      end

      context 'with invalid page' do
        let(:page) { -3 }

        it 'returns a first page' do
          expect(subject.count).to eq(per)
        end
      end

      context 'with invalid per' do
        let(:per) { -20 }

        it 'returns all records' do
          expect(subject.count).to eq(records.count)
        end
      end
    end
  end

  context 'sorting' do
    context 'with default options' do
      let(:options) { {} }

      it 'returns all records ordered by id asc' do
        expect(subject.ids).to eq(records.ids.sort)
      end
    end

    context 'with custom options' do
      let(:sort_attr) { 'name' }
      let(:order)     { 'desc' }

      let(:options) do
        {
          'sort_attr' => sort_attr,
          'order'     => order,
        }
      end

      it 'returns records ordered by name desc' do
        expect(subject.ids).to eq(records.ids.sort.reverse)
      end

      context 'with invalid attribute' do
        let(:sort_attr) { 'nonexistent' }

        it 'returns all records ordered by default attribute' do
          expect(subject.ids).to eq(records.ids.sort.reverse)
        end
      end

      context 'with invalid order direction' do
        let(:order) { 'descending' }

        it 'returns all records ordered by default direction' do
          expect(subject.ids).to eq(records.ids.sort)
        end
      end
    end
  end
end
