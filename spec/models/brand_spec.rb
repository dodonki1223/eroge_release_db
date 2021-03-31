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

      context 'when the record exists' do
        before { create(:brand, name: 'ホゲフガ') }

        context 'when unique' do
          let(:name_unique) { create(:brand) }

          it { expect(name_unique).to be_valid }
        end

        context 'when no unique' do
          let(:name_not_unique) { described_class.create(name: 'ホゲフガ') }
          let(:not_unique_error_message) do
            name_not_unique.valid?
            name_not_unique.errors[:name]
          end

          it { expect(name_not_unique).to be_invalid }
          it { expect(not_unique_error_message).to match ['同じブランド名は登録できません'] }
        end
      end
    end
  end

  describe 'destroy' do
    let!(:brand) { create(:game).brand }

    it { expect { brand.destroy }.to change(Game, :count).by(-1) }
  end
end
