class StockProductDestinationsController < ApplicationController
  def create
    @warehouse = Warehouse.find_by(id: params[:warehouse_id])
    @product_model = ProductModel.find_by(id: params[:product_model_id])

    @stock_product = StockProduct.find_by(warehouse_id: @warehouse.id, product_model_id: @product_model.id)

    if @stock_product != nil
      @stock_product.create_stock_product_destination(recipient: params[:recipient], address: params[:address])
      redirect_to @warehouse, notice: t(:item_has_been_withdraw)
    end
  end
end