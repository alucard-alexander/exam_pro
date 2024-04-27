class UserModelRemoveIndexForAllColumnsAndAddPhoneNumberIndex < ActiveRecord::Migration[7.1]
  def change
    remove_index :users, %i[first_name last_name phone_number]
    add_index :users, :phone_number
  end
end
