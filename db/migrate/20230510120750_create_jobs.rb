class CreateJobs < ActiveRecord::Migration[7.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :local
      t.string :salary
      t.string :contractor
      t.string :phone
      t.string :type_job

      t.timestamps
    end
  end
end
