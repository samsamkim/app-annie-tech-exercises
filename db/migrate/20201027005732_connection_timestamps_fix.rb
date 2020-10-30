class ConnectionTimestampsFix < ActiveRecord::Migration[6.0]
  def change
    change_column_default :connections, :created_at, -> { 'CURRENT_TIMESTAMP' }
    change_column_default :connections, :updated_at, -> { 'CURRENT_TIMESTAMP' }
  end
end
