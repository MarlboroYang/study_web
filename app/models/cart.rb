class Cart
  def initialize(items = [] )
    @items = items
  end
  def add_item(item_id, quantity = 1 )
    # 要加判斷的地方
    found_item = @items.find { |item| item.item_id == item_id }
    if found_item
      #增加數量
      found_item.increment(quantity)
    else
      #給一個新的CartItem
      @items << CartItem.new(item_id, quantity)
    end
  end
  def empty?
    @items.empty?
  end

  def items
    @items
  end
  def total_price
    total = @items.sum { |item| item.total_price }

    if Date.today.month == 12 && Date.today.day == 25
      total = total * 0.9
    end
    total
  end
  def serialize
    # 另外一種可以用的方式
    # items = []
    # @item.each do |item|
    #   items << {"item_id" => item.item_id, "quantity" => item.quantity}
    # end
    items = @items.map { |item| { "item_id" => item.item_id, "quantity" => item.quantity } }

    { "items" => items }
  end
  def self.from_hash(hash)
    if hash && hash["items"]
      #還原
      # items = []
      # items << CartItem.new(item["item_id"], item["quantity"])
        # 另外一種寫法
      items = hash["items"].map { |item| CartItem.new(item["item_id"],item["quantity"]) }
      # 如果前面有買東西，就給一台新車跟前面的物品。
      Cart.new(items)
    else
      # 如果沒有就給一台新車
      Cart.new
    end
  end
end

