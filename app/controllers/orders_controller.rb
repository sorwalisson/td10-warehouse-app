class OrdersController < ApplicationController
  before_action :check_user_set_order, only: [:show, :edit, :update, :delivered, :canceled]
  def index
    @orders = current_user.orders
  end

  def show
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
    @orders = Order.where("code LIKE ?", "%#{@code}%")
  end

  def edit
    @warehouses = Warehouse.all
    @suppliers = Supplier.all
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: I18n.t('order_updated')
    else
      @warehouses = Warehouse.all
      @suppliers = Supplier.all
      notice.now[:notice] = I18n.t('order_not_updated')
      render 'edit'
    end
  end

  def delivered
    @order.delivered!
    redirect_to @order, notice: t(:updated_status)
  end

  def canceled
    @order.canceled!
    redirect_to @order, notice: t(:updated_status)
  end
  private
  
  def order_params
    params.require(:order).permit(:warehouse_id, :supplier_id, :estimated_delivery_date)
  end
  
  def check_user_set_order
    @order = Order.find_by(id: params[:id])
    if @order.user_id != current_user.id
      redirect_to root_path, notice: t('order_denied')
      return
    end
  end
end