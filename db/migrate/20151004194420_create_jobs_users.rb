class CreateJobsUsers < ActiveRecord::Migration
  def change
    create_table :jobs_users do |t|
      t.belongs_to :job, index: true
      t.belongs_to :user, index: true
      t.timestamps null: false
    end
  end
end
