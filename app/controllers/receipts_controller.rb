class ReceiptsController < ApplicationController
  include Secured

  before_action :set_current_user

  def index
    @receipts = Receipt.all

    # Handle search
    if params[:search].present?
      @receipts = @receipts.where("seller ILIKE ?", "%#{params[:search]}%")
    end

    # Handle date filter
    if params[:date].present?
      @receipts = @receipts.where(date: params[:date].to_date.all_day)
    end

    # Order by date descending
    @receipts = @receipts.order(date: :desc)
  end

  def create
    @receipt = @current_user.receipts.new(receipt_params)
    if @receipt.save
      respond_to do |format|
        format.html { redirect_to receipts_path, notice: "Receipt was successfully uploaded." }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { redirect_to receipts_path, alert: "Failed to upload receipt." }
        format.json { render json: { success: false, errors: @receipt.errors.full_messages } }
      end
    end
  end

  private

  def receipt_params
    params.require(:receipt).permit(:seller, :receipt_number, :total_amount, :date, :note, :image)
  end

  def set_current_user
    @current_user = User.find_by_email(session[:userinfo].email)
  end
end
