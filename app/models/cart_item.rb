class CartItem
  # 帶入商品名及數量
  attr_reader :item_id, :quantity
  # 初始化購物車
  def initialize(item_id, quantity = 1)
    # 車內的商品及數量
    @item_id = item_id
    @quantity = quantity
  end
  def increment(n = 1)
    # 放到車裡的物品增加
    @quantity = @quantity + n
  end
  def product
    # 回傳指定商品
    Product.find(@item_id)
  end
  def total_price
    # 商品的價格乘以價格
    @quantity * product.price
  end
end