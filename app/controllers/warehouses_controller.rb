class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find_by(id: params[:id])
  end


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
    @warehouse = Warehouse.find_by(id: params[:id])
  end

  def update
    @warehouse = Warehouse.find_by(id: params[:id])

    if @warehouse.update(warehouse_params)
      redirect_to warehouse_path(id: @warehouse.id)
      flash[:notice] = "Galpão atualizado com sucesso"
    else
      flash.now[:notice] = "Não foi possível atualizae galpão"
      render 'edit'
    end
  end




  private

  def warehouse_params
    params.require(:warehouse).permit(:name, :code, :city, :description, :address, :cep, :area)
  end
end