class AddLocationToBooks < ActiveRecord::Migration[6.0]
  def change
    add_reference :books, :libraries, foreign_key: true
  end
end
