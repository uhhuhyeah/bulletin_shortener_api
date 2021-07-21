class AddIndexToLinks < ActiveRecord::Migration[6.1]
  def change
    add_index :links, :slug
  end
end
