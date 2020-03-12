# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'validations' do
    let(:errors) do
      game.valid?
      game.errors
    end

    describe 'title' do
      context 'when nil' do
        let(:game) { build(:game, title: nil) }
        let(:nil_error_message) { ['タイトルは空で登録できません'] }

        it { expect(game).to be_invalid }
        it { expect(errors[:title]).to match nil_error_message }
      end

      context 'when the record exists' do
        before { create(:game, title: 'ホゲフガ') }

        context 'when not same title' do
          let(:game) { create(:game) }

          it { expect(game).to be_valid }
        end

        context 'when same title' do
          let(:game) { described_class.create(title: 'ホゲフガ') }
          let(:uniqueness_error_message) { ['同じタイトルのゲームは登録できません'] }

          it { expect(game).to be_invalid }
          it { expect(errors[:title]).to match uniqueness_error_message }
        end
      end
    end

    describe 'brand_id' do
      context 'when nil' do
        let(:game) { build(:game, brand_id: nil) }
        let(:nil_error_message) { ['ブランドIDは空で登録できません'] }

        it { expect(game).to be_invalid }
        it { expect(errors[:brand_id]).to match nil_error_message }
      end
    end

    describe 'date' do
      context 'when nil' do
        let(:game) { build(:game, date: nil) }
        let(:nil_error_message) { ['発売日は空で登録できません'] }

        it { expect(game).to be_invalid }
        it { expect(errors[:date]).to match nil_error_message }
      end
    end
  end
end
