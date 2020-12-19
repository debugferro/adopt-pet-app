class AddFinishedToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :finished, :boolean, default: false
  end
end
