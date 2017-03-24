class FibsController < ApplicationController
  before_action :set_fib, only: [:show, :edit, :update, :destroy]

  # GET /fibs
  # GET /fibs.json
  def index
    @fibs = Fib.all

    respond_to do |format|
      format.html
      format.json { render json: @fibs }
    end
  end

  # GET /fibs/1
  # GET /fibs/1.json
  def show
  end

  # GET /fibs/new
  def new
    @fib = Fib.new
  end

  # GET /fibs/1/edit
  def edit
  end

  # POST /fibs
  # POST /fibs.json
  def create
    @fib = Fib.new(params.require(:fib).permit(:name, :sequence_length))

    respond_to do |format|
      if @fib.save
        format.html { redirect_to @fib, notice: 'Fib was successfully created.' }
        format.json { render json: @fib, status: :created, location: @fib }
      else
        format.html { render :new }
        format.json { render json: @fib.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fibs/1
  # PATCH/PUT /fibs/1.json
  def update
    respond_to do |format|
      if @fib.update(params.require(:fib).permit(:name, :sequence_length))
        format.html { redirect_to @fib, notice: 'Fib was successfully updated.' }
        format.json { render json: @fib, status: :ok, location: @fib }
      else
        format.html { render :edit }
        format.json do
          render json: { errors: @fib.errors.messages }, status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /fibs/1
  # DELETE /fibs/1.json
  def destroy
    @fib.destroy
    respond_to do |format|
      format.html { redirect_to fibs_url, notice: 'Fib was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fib
      @fib = Fib.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fib_params
      params.fetch(:fib, {})
    end
end
