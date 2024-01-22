class CreateUsersTable < ActiveRecord::Migration[7.1]
  def change
    create_table :users_tables do |t|

      t.timestamps
    end
  end
end
