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
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      flash.now[:notice] = I18n.t('order_not_saved')
      render 'new'
    end
  end

  def search
    @code = params[:query]
    @order = Order.find_by(code: @code)
  end

  def edit
    @order = Order.find_by(id: params[:id])
    security_check = check_user_order_edit
    if security_check == false
      redirect_to root_path, notice: I18n.t('order_edit_denied')
    end
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    @order = Order.find_by(id: params[:id])
    security_check = check_user_order_edit
    if security_check == false then 
      redirect_to root_path, notice: I18n.t('order_edit_denied')
      return
    end
    
    if @order.update(order_params)
      redirect_to @order, notice: I18n.t('order_updated')
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      notice.now[:notice] = I18n.t('order_not_updated')
      render 'edit'
    end
  end

  private
  
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
  
  def check_user_order_edit
    current_user.id == @order.user_id
  end
end