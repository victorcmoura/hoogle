class AddWebsiteToEdges < ActiveRecord::Migration[5.1]
  def change
    add_reference :edges, :website, foreign_key: true
  end
end
