class ServicesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :admin_user, except: %i(index show)
  before_action :set_service, only: %i(show edit update destroy)
  def index
    @services = Service.all.includes(:user)
  end

  def show;end

  def new
    @service = current_user.services.build
  end

  def create
    if current_user.admin?
      @service = current_user.services.build(service_params)
      @service.available_slots = set_available_slots
  
      respond_to do |format|
        if @service.save
          format.html { redirect_to services_path, notice: "Service was successfully created." }
        end
          format.html { render :new, status: :unprocessable_entity }
      end
    else
      flash[:error] = "You must be an admin to create a new service."
    end
  end

  def edit; end

  def update
    if current_user.admin?
      @service.user_id = current_user.id

      available_slots = []
      params[:start_time]&.each_with_index do |start_time, index|
        end_time = params[:end_time][index]
        slots = params[:available_slots][index]
        slot = { start_time: start_time, end_time: end_time, slots: slots.to_i }
        available_slots << slot
      end
      @service.available_slots = available_slots

      respond_to do |format|
        if @service.update(service_params)
          format.html { redirect_to @service, notice: "Movie was successfully updated." }
        end
          format.html { render :new, status: :unprocessable_entity }
      end
    else
      flash[:error] = "You must be an admin to update a new service."
    end
  end

  def destroy
    respond_to do |format|
      if @service.destroy
        format.html { redirect_to services_path, notice: "Service deleted successfully!"}
      end
    end
  end

  private 

  def set_service
    @service = Service.friendly.find(params[:id])
  end

  def service_params
      params.require(:service).permit(:name, :description, :image, :price, :available_date, :user_id, available_slots: [])
  end

  def set_available_slots
    available_slots = []
    params[:start_time]&.each_with_index do |start_time, index|
      end_time = params[:end_time][index]
      slots = params[:available_slots][index]
      slot = { start_time: start_time, end_time: end_time, slots: slots.to_i }
      available_slots << slot
    end
    available_slots
  end
end
