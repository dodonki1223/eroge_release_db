# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'validations' do
    let(:brand) { build(:brand, name: brand_name) }
    let(:errors) do
      brand.valid?
      brand.errors
    end

    context 'when name' do
      context 'when nil is not present' do
        let(:brand_name) { nil }
        let(:nil_error_message) { ['ブランド名は空で登録できません'] }

        it { expect(brand).to be_invalid }
        it { expect(errors[:name]).to match nil_error_message }
      end
    end
  end
end
