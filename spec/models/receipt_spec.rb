# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Receipt, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:seller) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:total_amount) }
    it { should validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:image) }
    it { should validate_inclusion_of(:category).in_array(%w[deduction income]) }
  end

  describe 'associations' do
    it { should have_one_attached(:image) }
  end
end
