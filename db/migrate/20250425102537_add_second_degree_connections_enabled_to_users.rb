class AddSecondDegreeConnectionsEnabledToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :second_degree_connections_enabled, :boolean, default: true, null: false
    User.update_all(second_degree_connections_enabled: true)
  end
end
