class BillingsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_billing, only: %i[ show edit update destroy ]

  def index
    @billings = Billing.all
  end

  def show
  end

  def new
    @billing = current_user.billings.build
    @billing.build_address
  end

  def edit
  end

  def create
    @billing = current_user.billings.build(billing_params)
    @billing.complete_address = @billing.address.attributes.values_at(*%w[street barangay city, zipcode]).join(', ')

    respond_to do |format|
      if @billing.save
        format.html { redirect_to billings_url, notice: "Billing was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @billing = current_user.billings.build(billing_params)
    @billing.complete_address = @billing.address.attributes.values_at(*%w[street barangay city, zipcode]).join(', ')
    respond_to do |format|
      if @billing.update(billing_params)
        format.html { redirect_to billing_url(@billing), notice: "Billing was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @billing.destroy

    respond_to do |format|
      format.html { redirect_to billings_url, notice: "Billing was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_billing
      @billing = Billing.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def billing_params
      params.require(:billing).permit(:user_id, :complete_address, address_attributes: %i(street barangay city province zipcode user_id))
    end
end
