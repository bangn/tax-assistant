class ReceiptsController < ApplicationController
  include Secured

  before_action :set_current_user

  def index
    @receipts = @current_user.receipts

    # Handle search
    if params[:search].present?
      @receipts = @receipts.where("seller ILIKE ? OR description ILIKE ?", "%#{params[:search]}%", "%#{params[:search]}%")
    end

    # Handle date filter
    if params[:date].present?
      begin
        date = Date.parse(params[:date])
        @receipts = @receipts.where(date: date.all_day)
      rescue ArgumentError
        flash[:error] = "Invalid date format"
      end
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
        format.html { redirect_to receipts_path, alert: "Failed to upload receipt. #{@receipt.errors.full_messages}" }
        format.json { render json: { success: false, errors: @receipt.errors.full_messages } }
      end
    end
  end

  def edit
    @receipt = @current_user.receipts.find(params[:id])
  end

  def update
    @receipt = @current_user.receipts.find(params[:id])
    if @receipt.update(receipt_params)
      respond_to do |format|
        format.html { redirect_to receipts_path, notice: "Receipt was successfully updated." }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render :edit, alert: "Failed to update receipt. #{@receipt.errors.full_messages}" }
        format.json { render json: { success: false, errors: @receipt.errors.full_messages } }
      end
    end
  end

  private

  def receipt_params
    params.require(:receipt).permit(:seller, :description, :total_amount, :date, :note, :image)
  end

  def set_current_user
    @current_user = User.find_by_email(session[:userinfo].email)
  end
end
