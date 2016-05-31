class OrganizesController < ApplicationController
  before_action :set_organize, only: [:show, :edit, :update, :destroy]

  # GET /organizes
  # GET /organizes.json
  def index
    @org = Organize.new

    @org = Organize.find(params[:id]) if params[:id].present?
    @parents = @org.ancestors
    pp @org.name
    respond_to do |format|
      format.html
      format.json { render json: OrganizesDatatable.new(view_context) }
    end
  end

  # GET /organizes/1
  # GET /organizes/1.json
  def show
  end

  # GET /organizes/new
  def new
    @organize = Organize.new
  end

  # GET /organizes/1/edit
  def edit
  end

  # POST /organizes
  # POST /organizes.json
  def create
    @organize = Organize.new(organize_params)

    respond_to do |format|
      if @organize.save
        format.html { redirect_to @organize, notice: 'Organize was successfully created.' }
        format.json { render :show, status: :created, location: @organize }
      else
        format.html { render :new }
        format.json { render json: @organize.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizes/1
  # PATCH/PUT /organizes/1.json
  def update
    respond_to do |format|
      if @organize.update(organize_params)
        format.html { redirect_to @organize, notice: 'Organize was successfully updated.' }
        format.json { render :show, status: :ok, location: @organize }
      else
        format.html { render :edit }
        format.json { render json: @organize.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /organizes/1
  # DELETE /organizes/1.json
  def destroy
    @organize.destroy
    respond_to do |format|
      format.html { redirect_to organizes_url, notice: 'Organize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organize
      @organize = Organize.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organize_params
      params.fetch(:organize, {})
    end
end
