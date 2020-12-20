class OrdersController < ApplicationController
  def create
    # 建立訂單
    order = current_user.orders.new(order_params)
    current_cart.items.each do |item|
      order.order_items << OrderItem.new(product: item.product, quantity: item.quantity)
    end
    order.save
    
    # 付錢
    nonce = params[:payment_method_nonce]
    result = gateway.transaction.sale(
      amount: current_cart.total_price,
      payment_method_nonce: nonce
    )
    if result.success?
      # 清空車子
      session[:cart9527] = nil
      # 狀態改變
      order.pay!
      # 離開
      redirect_to root_path, notice: '感謝消費'
    else
      redirect_to root_path, notice: '刷卡未成功'
    end
    # render json: result
  end
  private
  def order_params
    params.require(:order).permit(:name, :tel, :address)
  end
  def gateway
    # 下面這邊是假刷卡用的，從網頁上copy過來的。
    Braintree::Gateway.new(
      environment: :sandbox,
      merchant_id: ENV['braintree_merchant_id'],
      public_key: ENV['braintree_public_key'],
      private_key: ENV['braintree_private_key'],
    )
    # ==========假刷卡========
  end
end


