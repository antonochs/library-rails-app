class AddAvailabilityToBooks < ActiveRecord::Migration[6.0]
  def change
    add_column :books, :availability, :boolean
  end
end
