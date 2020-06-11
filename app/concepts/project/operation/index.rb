class Project::Index < Trailblazer::Operation
  step :model

  def model(options, *)
    options["model"] = Project::Poro.(Project.all, options[:params] || {})
  end
end
