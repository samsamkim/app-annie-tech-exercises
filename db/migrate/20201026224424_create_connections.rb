class CreateConnections < ActiveRecord::Migration[6.0]
  def change
    create_table :connections do |t|
      t.string :country
      t.string :app
      t.string :platform
      t.string :connection
      t.float :impressions
      t.float :ad_revenue
      t.date :date

      t.timestamps
    end
  end
end
