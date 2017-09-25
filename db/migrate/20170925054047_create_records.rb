class CreateRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :records do |t|
      t.references :user, foreign_key: true
      t.datetime :started_at
      t.datetime :finished_at
      t.integer :regular_span
      t.integer :early_span

      t.timestamps
    end
  end
end
