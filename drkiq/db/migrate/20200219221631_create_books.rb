class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :name
      t.string :author
      t.datetime :return_by
      t.string :description

      t.timestamps
    end
  end
end
