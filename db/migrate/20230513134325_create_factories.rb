class CreateFactories < ActiveRecord::Migration[7.0]
  def change
    create_table :factories do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :fax
      t.string :email
      t.string :website
      t.string :contact_person
      t.string :contact_person_phone
      t.string :contact_person_email

      t.timestamps
    end
  end
end
