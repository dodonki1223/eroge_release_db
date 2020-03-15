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
  end
end
