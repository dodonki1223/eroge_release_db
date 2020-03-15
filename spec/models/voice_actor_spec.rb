# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VoiceActor, type: :model do
  describe 'validations' do
    describe 'name' do
      context 'when nil' do
        let(:name_nil) { build(:voice_actor, name: nil) }
        let(:nil_error_message) do
          name_nil.valid?
          name_nil.errors[:name]
        end

        it { expect(name_nil).to be_invalid }
        it { expect(nil_error_message).to match ['声優名は空で登録できません'] }
      end
    end
  end
end
