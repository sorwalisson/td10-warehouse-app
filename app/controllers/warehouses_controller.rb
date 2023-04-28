class WarehousesController < ApplicationController
  before_action :set_warehouse, only: [:show, :edit, :update, :destroy]

  def show; end


  def new
    @warehouse = Warehouse.new()
  end

  def create
    @warehouse = Warehouse.new(warehouse_params)
    if @warehouse.save()
      flash[:notice] = "Galpão cadastrado com sucesso"
      redirect_to root_path
    else
      flash.now[:notice] = "Galpão não cadastrado"
      render 'new'
    end
  end

  def edit
    set_warehouse
  end

  def update
    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(id: @warehouse.id)
      flash[:notice] = "Galpão atualizado com sucesso"
    else
      flash.now[:notice] = "Não foi possível atualizar galpão"
      render 'edit'
    end
  end

  def destroy
    @warehouse.destroy
    redirect_to root_path, notice: 'Galpão removido com sucesso.'
  end

  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
  end

  def set_warehouse
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end