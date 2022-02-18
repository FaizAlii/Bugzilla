class CreateBugs < ActiveRecord::Migration[5.2]
  def change
    create_table :bugs do |t|
      t.string :title
      t.text :description
      t.datetime :deadline
      t.integer :type
      t.integer :status
      t.string :screenshot

      t.timestamps
    end
  end
end
