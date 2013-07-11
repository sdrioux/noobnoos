class AddThumbnailToLinks < ActiveRecord::Migration
  def change
    add_column :links, :thumbnail, :string
  end
end
