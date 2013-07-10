class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :user
      t.references :link
      t.text :message

      t.timestamps
    end
  end
end