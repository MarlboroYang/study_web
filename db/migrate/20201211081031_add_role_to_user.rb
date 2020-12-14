class AddRoleToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :boards, :user
  end
end
#  寫錯了！跟board的要交換