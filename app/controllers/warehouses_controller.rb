class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show
    @stocks = @warehouse.stock_products.where.missing(:stock_product_destination).group(:product_model).count
  end
  
  def new
    @warehouse = Warehouse.new()
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      flash[:notice] = I18n.translate('warehouse_saved')
      redirect_to root_path
    else
      flash.now[:notice] = I18n.translate('warehouse_not_saved')
      render 'new'
    end
  end

  def edit
    set_warehouse
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(id: @warehouse.id)
      flash[:notice] = I18n.translate('warehouse_updated')
    else
      flash.now[:notice] = I18n.translate('warehouse_not_updated')
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: I18n.translate('warehouse_destroyed')
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
  end

  def set_warehouse
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end