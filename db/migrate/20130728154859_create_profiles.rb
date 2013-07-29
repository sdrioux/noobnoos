class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :facebook
      t.string :github
      t.string :twitter
      t.references :user
      t.timestamps
    end
  end
end
