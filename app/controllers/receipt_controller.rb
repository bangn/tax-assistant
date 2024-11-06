class ReceiptsController < ApplicationController
  def index
    @receipts = Receipt.all

    # Handle search
    if params[:search].present?
      @receipts = @receipts.where("vendor ILIKE ? OR category ILIKE ?",
                                 "%#{params[:search]}%",
                                 "%#{params[:search]}%")
    end

    # Handle date filter
    if params[:date].present?
      @receipts = @receipts.where(date: params[:date].to_date.all_day)
    end

    # Order by date descending
    @receipts = @receipts.order(date: :desc)
  end

  def create
    @receipt = Receipt.new(receipt_params)

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

  def export
    @receipts = Receipt.order(date: :desc)

    respond_to do |format|
      format.csv do
        headers["Content-Disposition"] = 'attachment; filename="receipts.csv"'
        headers["Content-Type"] ||= "text/csv"
      end
    end
  end

  def capture
    # Redirect to a camera capture page or handle mobile camera functionality
    render :capture
  end

  private

  def receipt_params
    params.require(:receipt).permit(:image, :seller, :amount, :date)
  end
end
