class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.json :tags, default: '{}'
      t.integer :project_type

      t.timestamps
    end
  end
end
