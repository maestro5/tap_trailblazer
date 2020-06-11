# require "reform/form/dry"

module Project::Contract
  class Create < Reform::Form
    # feature Reform::Form::Dry

    property :name
    property :tags
    property :project_type

    validates :name, presence: true
    validates_uniqueness_of :name
    validates :project_type, inclusion: { in: %w(a b c) }
  end
end
