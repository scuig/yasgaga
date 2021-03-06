class PurchasesController < ApplicationController
  before_action :set_purchase, only: [:show, :edit, :update, :destroy]

  # GET /purchases
  # GET /purchases.json
  def index
    @purchases = Purchase.all
    @nombre = 'Compras'
  end

  # GET /purchases/1
  # GET /purchases/1.json
  def show
    @nombre = 'Detalles de la compra'
  end

  # GET /purchases/new
  def new
    @nombre = 'Nueva compra'
    @purchase = Purchase.new
    @purchase.material_purchases.build
    @purchase.materials.build
  end

  # GET /purchases/1/edit
  def edit
    @nombre = 'Editar compra'
    @purchase= Purchase.find(params[:id])
    @purchase.material_purchases.build
    @purchase.materials.build
  end

  # POST /purchases
  # POST /purchases.json
  def create
    @nombre = 'Nueva compra'
    @purchase = Purchase.new(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to @purchase, notice: 'Purchase was successfully created.' }
        format.json { render :show, status: :created, location: @purchase }
      else
        format.html { render :new }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /purchases/1
  # PATCH/PUT /purchases/1.json
  def update
    @nombre = 'Editar compra'
    respond_to do |format|
      if @purchase.update(purchase_params)
        format.html { redirect_to @purchase, notice: 'Purchase was successfully updated.' }
        format.json { render :show, status: :ok, location: @purchase }
      else
        format.html { render :edit }
        format.json { render json: @purchase.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.json
  def destroy
    @nombre = 'Eliminar compra'
    @purchase.destroy
    respond_to do |format|
      format.html { redirect_to purchases_url, notice: 'Purchase was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_purchase
      @purchase = Purchase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def purchase_params
      params.require(:purchase).permit(
        :id, :purchase_date, :supplier_id, :user_id,
        material_purchases_attributes: [:material_id, :units, :exp_date, :amount,
          materials_attributes: [:available, :unit_id,
            units_attributes: [:name, :abbr]]])
    end
end
