class Public::DeriveriesController < ApplicationController
  before_action :authenticate_customer!

  def index
     @delivery = Delivery.new
     @deliveries =Delivery.where(customer_id: current_customer.id)
  end

   def create
   @delivery = Delivery.new(delivery_params)
   @delivery.customer_id = current_customer.id
    if @delivery.save
      flash[:notice] = "新規配送先を登録しました"
      redirect_to deriveries_path
    end
   end

  def edit
    @delivery = Delivery.find(params[:id])
  end

  def update
    @delivery = Delivery.find(params[:id])
    if @delivery.update(delivery_params)
      flash[:notice] = "配送先を変更しました"
      redirect_to deriveries_path
    end
  end

  def destroy
    @delivery = Delivery.find(params[:id])
    @delivery.destroy
    flash[:notice] = "配送先を１件削除しました"
    redirect_to deriveries_path
  end

private

  def delivery_params
    params.require(:delivery).permit(:postcode,:address, :destination)
  end

end