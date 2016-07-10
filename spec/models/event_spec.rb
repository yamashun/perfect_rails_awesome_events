require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '#name' do
    # context '空白の時' do
    #   let(:event) {Event.new(name: '')}

    #   it 'valid でないこと' do
    #     event.valid?
    #     expect(event.errors[:name]).to be_present
    #   end
    # end

    it { should validate_presence_of(:name) }
    it { should ensure_length_of(:name).is_at_most(50) }
  end


  describe '#rails?' do
    context '#name が "Rails勉強会" のとき' do
      it 'true を返すこと' do
        event = create(:event, name: "Rails勉強会")
        expect(event.rails?).to eq true
      end
    end

    context '#name が "Ruby勉強会" のとき' do
      it 'false を返すこと' do
        event = create(:event, name: "Ruby勉強会")
        expect(event.rails?).to eq false
      end
    end
  end



  describe '#created_by?' do
    let(:event) { create(:event) }
    subject { event.created_by?(user) }

    context '引数がnillなとき' do
      let(:user) { nil }
      it { should be_falsey }
    end

    context '#owner_id と 引数の#id が同じとき' do
      let(:user) { double('user', id: event.id) }
      it { should be_truthy }
    end
  end

end
