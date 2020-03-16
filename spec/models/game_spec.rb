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
        let(:title_nil) { build(:game, title: nil) }
        let(:nil_error_message) do
          title_nil.valid?
          title_nil.errors[:title]
        end

        it { expect(title_nil).to be_invalid }
        it { expect(nil_error_message).to match ['タイトルは空で登録できません'] }
      end

      context 'when the record exists' do
        before { create(:game, title: 'ホゲフガ') }

        context 'when unique' do
          let(:title_unique) { create(:game) }

          it { expect(title_unique).to be_valid }
        end

        context 'when not unique' do
          let(:title_not_unique) { described_class.create(title: 'ホゲフガ') }
          let(:not_unique_error_message) do
            title_not_unique.valid?
            title_not_unique.errors[:title]
          end

          it { expect(title_not_unique).to be_invalid }
          it { expect(not_unique_error_message).to match ['同じタイトルのゲームは登録できません'] }
        end
      end
    end

    describe 'brand_id' do
      context 'when nil' do
        let(:brand_id_nil) { build(:game, brand_id: nil) }
        let(:nil_error_message) do
          brand_id_nil.valid?
          brand_id_nil.errors[:brand_id]
        end

        it { expect(brand_id_nil).to be_invalid }
        it { expect(nil_error_message).to match ['ブランドIDは空で登録できません'] }
      end
    end

    describe 'date' do
      context 'when nil' do
        let(:date_nil) { build(:game, date: nil) }
        let(:nil_error_message) do
          date_nil.valid?
          date_nil.errors[:date]
        end

        it { expect(date_nil).to be_invalid }
        it { expect(nil_error_message).to match ['発売日は空で登録できません'] }
      end
    end
  end

  describe 'destroy' do
    let!(:game) { create(:game_cast).game }

    it { expect { game.destroy } .to change(GameCast, :count).by(-1) }
  end
end
