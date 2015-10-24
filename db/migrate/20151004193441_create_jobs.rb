class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.string :location
      t.string :url
      t.string :company_name
      t.boolean :saved, default: false
      t.string :saved_by
      t.timestamps null: false
    end
  end
end
