class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items
  # 這是狀態機的模組，要套用的話，要整組搬過去。
  include AASM
  aasm(column: 'state', no_direct_assignment: true) do
    state :pending, initial: true
    state :paid, :delivered, :cancelled
    event :pay do
      transitions from: :pending, to: :paid
    end
    event :deliver do
      transitions from: :paid, to: :delivered
    end
    event :cancel do
      transitions from: [:paid, :deliver, :panding], to: :cancelled
    end
  end
  # ===========這是狀態機的模組================
end
