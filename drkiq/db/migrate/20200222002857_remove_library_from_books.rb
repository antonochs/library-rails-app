class RemoveLibraryFromBooks < ActiveRecord::Migration[6.0]
  def change
    remove_reference :books, :libraries
    add_reference :books, :library, foreign_key: true
  end
end
