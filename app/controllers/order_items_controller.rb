class OrderItemsController < ApplicationController
  
  def new
    @order = Order.find_by(id: params[:order_id])
    @order_item = OrderItem.new()
    @products = ProductModel.where(supplier_id: @order.supplier_id)
  end

  def create
    @order = Order.find_by(id: params[:order_id])
    @order_item = OrderItem.new(order_item_params)
    @order_item.order_id = @order.id

    if @order_item.save
      redirect_to @order, notice: t(:itens_saved)
    else
      redirect_to root_path, notice: t(:itens_not_saved)
    end
  end






  private

  def order_item_params
    params.require(:order_item).permit(:product_model_id, :quantity)
  end

end