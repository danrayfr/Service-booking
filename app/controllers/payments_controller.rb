class PaymentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :admin_user

  def index
    @payments = Payment.all.order(:name)
  end

  def new; end
end
