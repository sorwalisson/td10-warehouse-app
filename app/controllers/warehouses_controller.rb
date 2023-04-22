class WarehousesController < ApplicationController
  def show
    @warehouse = Warehouse.find_by(id: params[:id])
  end
end