class ResourceUpdatesController < ApplicationController
  before_action :set_resource_update, only: [:show, :edit, :update, :destroy]
  add_crumb('Resource updates'){|instance| instance.resource_updates_path}

  # GET /resource_updates
  # GET /resource_updates.json
  def index
    @resource_updates = ResourceUpdate.all
  end

  # GET /resource_updates/1
  # GET /resource_updates/1.json
  def show
    add_crumb "Show('#{@resource_update.name}##{@resource_update.id}')", resource_update_path
  end

  # GET /resource_updates/new
  def new
    add_crumb "New", new_resource_update_path
    @resource_update = ResourceUpdate.new
  end

  # GET /resource_updates/1/edit
  def edit
    add_crumb "Edit('#{@resource_update.name}##{resource_update.id}')", edit_resource_update_path
  end

  # POST /resource_updates
  # POST /resource_updates.json
  def create
    @resource_update = ResourceUpdate.new(resource_update_params)

    respond_to do |format|
      if @resource_update.save
        format.html { redirect_to @resource_update, notice: 'Resource update was successfully created.' }
        format.json { render :show, status: :created, location: @resource_update }
      else
        format.html { render :new }
        format.json { render json: @resource_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_updates/1
  # PATCH/PUT /resource_updates/1.json
  def update
    respond_to do |format|
      if @resource_update.update(resource_update_params)
        format.html { redirect_to @resource_update, notice: 'Resource update was successfully updated.' }
        format.json { render :show, status: :ok, location: @resource_update }
      else
        format.html { render :edit }
        format.json { render json: @resource_update.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_updates/1
  # DELETE /resource_updates/1.json
  def destroy
    @resource_update.destroy
    respond_to do |format|
      format.html { redirect_to resource_updates_url, notice: 'Resource update was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resource_update
      @resource_update = ResourceUpdate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def resource_update_params
      params.require(:resource_update).permit(:name, :updated, :source_uri, :user_id)
    end
end
