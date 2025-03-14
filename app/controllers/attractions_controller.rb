class AttractionsController < ApplicationController
  before_action :set_attraction, only: %i[ show edit update destroy ]

  # GET /attractions or /attractions.json
  def index
    @attractions = Attraction.all
  end

  # GET /attractions/1 or /attractions/1.json
  def show
    @attraction = Attraction.find(params[:id])
    @ride = Ride.new(user_id: session[:user_id], attraction_id: @attraction.id)
  end

  # GET /attractions/new
  def new
    @attraction = Attraction.new
  end

  # GET /attractions/1/edit
  def edit
  end

  # POST /attractions or /attractions.json
  def create
    @attraction = Attraction.create(attraction_params)
    if @attraction.save
      redirect_to attraction_path(@attraction)
    else
      redirect_to new_attraction_path
    end
  end

  # PATCH/PUT /attractions/1 or /attractions/1.json
  def update
    respond_to do |format|
      if @attraction.update(attraction_params)
        format.html { redirect_to @attraction, notice: "Attraction was successfully updated." }
        format.json { render :show, status: :ok, location: @attraction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attraction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attractions/1 or /attractions/1.json
  def destroy
    @attraction.destroy
    respond_to do |format|
      format.html { redirect_to attractions_url, notice: "Attraction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attraction
      @attraction = Attraction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def attraction_params
      params.require(:attraction).permit(:name, :tickets, :nausea_rating, :happiness_rating, :min_height)
    end
end
