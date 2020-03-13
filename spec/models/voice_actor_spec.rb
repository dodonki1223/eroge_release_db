# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VoiceActor, type: :model do
  describe 'validations' do
    let(:errors) do
      voice_actor.valid?
      voice_actor.errors
    end

    describe 'name' do
      context 'when nil' do
        let(:voice_actor) { build(:voice_actor, name: nil) }
        let(:nil_error_message) { ['声優名は空で登録できません'] }

        it { expect(voice_actor).to be_invalid }
        it { expect(errors[:name]).to match nil_error_message }
      end
    end
  end
end
