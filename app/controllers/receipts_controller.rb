class ReceiptsController < ApplicationController
  include Secured

  before_action :set_current_user
  before_action :set_receipt, only: [ :edit, :update, :destroy ]

  def index
    @receipts = @current_user.receipts

    @receipts = handle_search(
      receipts: @receipts,
      search_text: params[:search],
      start_date: params[:start_date],
      end_date: params[:end_date],
    )

    @pagy, @receipts = pagy(@receipts.order(date: :desc))
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
  end

  def update
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

  def destroy
    if @receipt.destroy
      respond_to do |format|
        format.html { redirect_to receipts_path, notice: "Receipt was successfully deleted." }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        format.html { render :edit, alert: "Failed to delete receipt. #{@receipt.errors.full_messages}" }
        format.json { render json: { success: false, errors: @receipt.errors.full_messages } }
      end
    end
  end

  private

  def receipt_params
    params.require(:receipt).permit(:seller, :description, :total_amount, :date, :note, :image, :category)
  end

  def set_current_user
    @current_user = User.find_by_email(session[:userinfo].email)
  end

  def set_receipt
    @receipt = @current_user.receipts.find(params[:id])
  end

  def handle_search(receipts:, search_text:, start_date:, end_date:)
    # Filter by date first if it is present to reduce the query time
    receipts = filter_by_date(
      receipts: receipts,
      start_date: start_date,
      end_date: end_date,
    )

    # Then filter by search text
    if search_text.present?
      receipts = receipts.fuzzy_search(search_text)
    end

    receipts
  end

  def filter_by_date(receipts:, start_date:, end_date:)
    if start_date.present?
      begin
        start_date = Date.parse(start_date)
        receipts = receipts.where("date >= ?", start_date)
      rescue ArgumentError
        flash[:error] = "Invalid start date format"
      end
    end

    if end_date.present?
      begin
        end_date = Date.parse(end_date)
        receipts = receipts.where("date <= ?", end_date)
      rescue ArgumentError
        flash[:error] = "Invalid end date format"
      end
    end

    receipts
  end
end
