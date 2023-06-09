class SuppliersController < ApplicationController
  before_action :set_supplier, only: [:show, :edit, :destroy, :update]
  def index
    @suppliers = Supplier.all
  end

  def show; end

  def new
    @supplier = Supplier.new()
  end

  def create
    @supplier = Supplier.new(supplier_params)

    if @supplier.save()
      flash[:notice] = I18n.t('supplier_saved')
      redirect_to suppliers_path
    else
      flash.now[:notice] = I18n.t('supplier_not_saved')
      render "new"
    end
  end

  def edit
    set_supplier
  end

  def update
    set_supplier
    
    if @supplier.update(supplier_params)
      flash[:notice] = I18n.t('supplier_updated')
      redirect_to supplier_path(id: @supplier.id)
    else
      flash.now[:notice] = I18n.t('supplier_not_updated')
      render "edit"
    end
  end

  def destroy
    set_supplier

    @supplier.destroy
    flash[:notice] = I18n.t('supplier_destroyed')
    redirect_to suppliers_path
  end

  private

  def supplier_params
    params.require(:supplier).permit(:corporate_name, :brand_name, :registration_number, :full_address, :city, :state, :email)
  end

  def set_supplier
    @supplier = Supplier.find_by(id: params[:id])
  end
end