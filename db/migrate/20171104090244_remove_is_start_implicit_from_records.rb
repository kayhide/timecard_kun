class RemoveIsStartImplicitFromRecords < ActiveRecord::Migration[5.1]
  def change
    remove_column :records, :is_start_implicit, :boolean
  end
end
