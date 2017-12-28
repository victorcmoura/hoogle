class AddTokenToEdges < ActiveRecord::Migration[5.1]
  def change
    add_reference :edges, :token, foreign_key: true
  end
end
