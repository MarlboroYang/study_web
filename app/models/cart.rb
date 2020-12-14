class Cart
  def items
    @items
  end
  # 初始化商品括號內定義商品是空的，用來接放進來的商品。
  def initialize(items = [] )
    # 全部的商品變數等於商品實體
    @items = items
  end
  # 被選購的商品括號內定義商品名稱及數量。
  def add_item(item_id, quantity = 1 )
    # 要加判斷的地方，尋找商品。
    found_item = @items.find { |item| item.item_id == item_id }
    if found_item
      #增加數量，如果有在車裡了。
      found_item.increment(quantity)
    else
      #給一個新的CartItem，如果沒有在車裡。
      @items << CartItem.new(item_id, quantity)
    end
  end
  def empty?
    @items.empty?
  end
  def total_price
    # 總價等於商品加總，用迴圈一個一個加。
    total = @items.sum { |item| item.total_price }
    # 定義有特別需求的日期
    if Date.today.month == 12 && Date.today.day == 25
      # 價格打折
      total = total * 0.9
    end
    total
  end
  # 序列化，把車裡的物品轉成hash的方式，以利存在session裡面，方便轉頁。
  def serialize
    # 另外一種可以用的方式
    # items = []
    # @item.each do |item|
    #   items << {"item_id" => item.item_id, "quantity" => item.quantity}
    # end
    # 把商品hash的方法
    items = @items.map { |item| { "item_id" => item.item_id, "quantity" => item.quantity } }

    { "items" => items }
  end
  # 當轉頁後，從hash轉回車裡的方法。
  def self.from_hash(hash)
    if hash && hash["items"]
      #還原
      # items = []
      # items << CartItem.new(item["item_id"], item["quantity"])
        # 另外一種寫法
        # 把hash裡的東西轉換出來
      items = hash["items"].map { |item| CartItem.new(item["item_id"],item["quantity"]) }
      # 如果前面有買東西，就給一台新車跟前面的物品。
      Cart.new(items)
    else
      # 如果沒有就給一台新車
      Cart.new
    end
  end
end

