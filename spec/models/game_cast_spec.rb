# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GameCast, type: :model do
  describe 'validations' do
    describe 'game_id' do
      context 'when nil' do
        let(:game_id_nil) { build(:game_cast, game_id: nil) }
        let(:nil_error_message) do
          game_id_nil.valid?
          game_id_nil.errors[:game_id]
        end

        it { expect(game_id_nil).to be_invalid }
        it { expect(nil_error_message).to match ['ゲームIDは空で登録できません'] }
      end
    end

    describe 'voice_actor_id' do
      context 'when nil' do
        let(:voice_actor_id_nil) { build(:game_cast, voice_actor_id: nil) }
        let(:nil_error_message) do
          voice_actor_id_nil.valid?
          voice_actor_id_nil.errors[:voice_actor_id]
        end

        it { expect(voice_actor_id_nil).to be_invalid }
        it { expect(nil_error_message).to match ['声優IDは空で登録できません'] }
      end
    end

    describe 'game_id and voice_actor_id' do
      let!(:game_cast) { create(:game_cast) }

      context 'when unique' do
        let(:unique_data) { create(:game_cast) }

        it { expect(unique_data).to be_valid }
      end

      context 'when not unique' do
        let(:not_unique_data) { described_class.create(game_id: game_cast.game_id, voice_actor_id: game_cast.voice_actor_id) }
        let(:not_unique_error_message) do
          not_unique_data.valid?
          not_unique_data.errors[:game_id]
        end

        it { expect(not_unique_data).to be_invalid }
        it { expect(not_unique_error_message).to match ['既にゲームIDと声優IDの組み合わせが存在しています'] }
      end
    end
  end
end
