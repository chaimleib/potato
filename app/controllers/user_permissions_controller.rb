require 'byebug' if Rails.env.development?

class UserPermissionsController < ApplicationController
  before_action :set_user_permission, only: [:show, :edit, :update]
  add_crumb controller_display_name, controller_base_path

  self.shown_to = [:administrators]
  self.model = UserPermission

  # GET /user_permissions
  # GET /user_permissions.json
  def index
    @user_permissions = UserPermission.all
  end

  # GET /user_permissions/1
  # GET /user_permissions/1.json
  def show
    autocrumb_with_email @user_permission.user.email
  end

  # # GET /user_permissions/new
  # def new
  #   add_crumb "New", new_user_permission_path
  #   @user_permission = UserPermission.new
  # end

  # GET /user_permissions/1/edit
  def edit
    autocrumb_with_email @user_permission.user.email
  end

  # # POST /user_permissions
  # # POST /user_permissions.json
  # def create
  #   @user_permission = UserPermission.new(user_permission_params)

  #   respond_to do |format|
  #     if @user_permission.save
  #       format.html { redirect_to @user_permission, notice: 'User permission was successfully created.' }
  #       format.json { render :show, status: :created, location: @user_permission }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @user_permission.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /user_permissions/1
  # PATCH/PUT /user_permissions/1.json
  def update
    respond_to do |format|
      if @user_permission.update(user_permission_params)
        format.html { redirect_to @user_permission, notice: 'User permission was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_permission }
      else
        format.html { render :edit }
        format.json { render json: @user_permission.errors, status: :unprocessable_entity }
      end
    end
  end

  # # DELETE /user_permissions/1
  # # DELETE /user_permissions/1.json
  # def destroy
  #   @user_permission.destroy
  #   respond_to do |format|
  #     format.html { redirect_to user_permissions_url, notice: 'User permission was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_permission
      @user_permission = UserPermission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_permission_params
      if params.require(:user_id) != @user_permission.user_id.to_s
        raise "Read-only attribute: user_id"
      end
      params.require(:user_permission).permit(:is_admin)
    end
end
