# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brand, type: :model do
  describe 'validations' do
    context 'when name' do
      context 'when nil' do
        let(:name_nil) { build(:brand, name: nil) }
        let(:nil_error_message) do
          name_nil.valid?
          name_nil.errors[:name]
        end

        it { expect(name_nil).to be_invalid }
        it { expect(nil_error_message).to match ['ブランド名は空で登録できません'] }
      end
    end
  end
end
