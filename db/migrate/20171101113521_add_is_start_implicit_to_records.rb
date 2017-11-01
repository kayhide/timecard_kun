class AddIsStartImplicitToRecords < ActiveRecord::Migration[5.1]
  def change
    add_column :records, :is_start_implicit, :boolean

    reversible do |dir|
      dir.up do
        Record.where(started_at: nil).find_each do |record|
          record.update started_at: record.computed_started_at, is_start_implicit: true
        end
      end
    end
  end
end
