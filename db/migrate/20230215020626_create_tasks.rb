class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :description
      t.datetime :completed_at
      t.references :user
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
