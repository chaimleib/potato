require 'due_dates_helper'
include DueDatesHelper

require 'potato_helper'
include PotatoHelper
require 'byebug' if Rails.env.development?

class DueDatesController < ApplicationController
  before_action :set_due_date, only: [:show, :edit, :update, :destroy]
  add_crumb controller_display_name, controller_base_path

  self.model = DueDate

  # GET /due_dates
  # GET /due_dates.json
  def index
    @due_dates = DueDate.all.reorder('branch_name')
  end

  # GET /due_dates/1
  # GET /due_dates/1.json
  def show
    add_crumb "Show #{@due_date.branch_name.inspect}", due_date_path
  end

  # GET /due_dates/new
  def new
    add_crumb "New", new_due_date_path
    @due_date = DueDate.new
  end

  # GET /due_dates/1/edit
  def edit
    add_crumb "Edit #{@due_date.branch_name.inspect}", edit_due_date_path
  end

  def mass_update
    pj = ensure_potato_jira session
    user = User.find_by(email: params[:user]) || User.first

    add_crumb "Wiki update", due_dates_mass_update_path
    @context = {messages: []}

    if params[:update].present?
      @context = try_update_from_wiki user, session, pj
    end
  end

  # POST /due_dates
  # POST /due_dates.json
  def create
    @due_date = DueDate.new(due_date_params)

    respond_to do |format|
      if @due_date.save
        format.html { redirect_to @due_date, notice: 'Due date was successfully created.' }
        format.json { render :show, status: :created, location: @due_date }
      else
        format.html { render :new }
        format.json { render json: @due_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /due_dates/1
  # PATCH/PUT /due_dates/1.json
  def update
    respond_to do |format|
      if @due_date.update(due_date_params)
        format.html { redirect_to @due_date, notice: 'Due date was successfully updated.' }
        format.json { render :show, status: :ok, location: @due_date }
      else
        format.html { render :edit }
        format.json { render json: @due_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /due_dates/1
  # DELETE /due_dates/1.json
  def destroy
    @due_date.destroy
    respond_to do |format|
      format.html { redirect_to due_dates_url, notice: 'Due date was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_due_date
      @due_date = DueDate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def due_date_params
      params.require(:due_date).permit(:branch_name, :target_version, :due)
    end
end
