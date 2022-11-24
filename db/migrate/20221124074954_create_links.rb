class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links do |t|
      t.string :original_url, null: false
      t.string :shortened_url, null: false
      t.string :domain_name # just for Analytic purpose

      t.timestamps
    end
    add_index :links, :shortened_url, unique: true
  end
end
