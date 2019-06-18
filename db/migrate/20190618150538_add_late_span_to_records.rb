class AddLateSpanToRecords < ActiveRecord::Migration[5.2]
  def change
    add_column :records, :late_span, :integer
  end
end
