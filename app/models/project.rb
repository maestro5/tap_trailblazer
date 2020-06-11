class Project < ApplicationRecord
  enum project_type: [:a, :b, :c]
end
