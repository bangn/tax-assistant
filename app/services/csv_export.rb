require "csv"

class CsvExport
  def initialize(receipts)
    @receipts = receipts
  end

  def call
    CSV.generate do |csv|
      csv << attributes
      @receipts.each do |receipt|
        csv << attributes.map { |attr| receipt.public_send(attr) }
      end
    end
  end

  private

  def attributes
    %w[seller description total_amount date note category]
  end
end
