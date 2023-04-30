class ProductModelsController < ApplicationController
  
  def index
    @product_models = ProductModel.all
  end

  def show
    @product_model = ProductModel.find_by(id: params[:id])
  end

  def new
    @product_model = ProductModel.new()
    @suppliers = Supplier.all
  end

  def create
    @product_model = ProductModel.new(product_model_params)

    if @product_model.save
      flash[:notice] = I18n.t('product_model_saved')
      redirect_to product_model_path(id: @product_model.id)
    else
      @suppliers = Supplier.all
      flash.now[:notice] = I18n.t('product_model_not_saved')
      render 'new'
    end
  end

  private

  def product_model_params
    params.require(:product_model).permit(:name, :weight, :width, :height, :depth, :sku, :supplier_id)
  end
end