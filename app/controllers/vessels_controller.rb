class VesselsController < ApplicationController
  before_filter :authorize
  before_action :is_admin
  before_action :set_vessel, only: [:show, :edit, :update, :destroy]

  # GET /vessels
  # GET /vessels.json
  def index
    @vessels = Vessel.all
  end

  # GET /vessels/1
  # GET /vessels/1.json
  def show
  end

  # GET /vessels/new
  def new
    @vessel = Vessel.new
  end

  # GET /vessels/1/edit
  def edit
  end

  # POST /vessels
  # POST /vessels.json
  def create
    @vessel = Vessel.new(vessel_params)

    respond_to do |format|
      if @vessel.save
        format.html { redirect_to @vessel, notice: 'Vessel was successfully created.' }
        format.json { render action: 'show', status: :created, location: @vessel }
      else
        format.html { render action: 'new' }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /vessels/1
  # PATCH/PUT /vessels/1.json
  def update
    respond_to do |format|
      if @vessel.update(vessel_params)
        format.html { redirect_to @vessel, notice: 'Vessel was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @vessel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /vessels/1
  # DELETE /vessels/1.json
  def destroy
    @vessel.destroy
    respond_to do |format|
      format.html { redirect_to vessels_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_vessel
    @vessel = Vessel.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def vessel_params
    params.require(:vessel).permit(:shipping_instruction_id, :vessel_name, :etd_no, :etd_city, :etd_date, :eta_no, :eta_city, :eta_date)
  end
end
