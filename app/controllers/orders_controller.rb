class OrdersController < ApplicationController
  
  def show
    @order = Order.find_by(id: params[:id])
  end

  def new
    @order = Order.new()
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user

    if @order.save
      redirect_to @order, notice: I18n.t('order_saved')
    else
      flash.now[:notice] = I18n.t('order_not_saved')
      render 'new'
    end
  end


  private
  
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
end