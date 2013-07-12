class AddPreviewtextToLinks < ActiveRecord::Migration
  def change
    add_column :links, :previewtext, :string
  end
end
