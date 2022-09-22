require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Associations" do
    it { should have_many(:posts).without_validating_presence }
    it { should have_many(:comments).without_validating_presence }
    it { should have_many(:friendships).without_validating_presence }
    it { should have_many(:likes).without_validating_presence }
  end
  context "validation tests" do
    subject {
      described_class.new(first_name: "Atul",
                          last_name: "patidar",
                          email: "apatidar@gamil.com",
                          username: "patidar22",
                          password: "122434343")
    }
    let!(:user) {
      User.create!(first_name: 'first', username: 'username22', email: 'tasrrghr@gppsreacro', password: '123456')
     }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without a email " do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password " do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid with less than 3 charcters first_name)  " do
      subject.first_name = "at"
      expect(subject).to_not be_valid
    end

    it 'ensure save succesfully presence' do
      user = User.create(first_name: 'first', username: 'username22', email: 'aptidar@grescsdddby.rsa', password: '123456')
      expect(user).to be_valid
    end

    let(:user1) {
      user1 = User.create!(first_name: 'atul', username: 'username22', email: 'ptidr@grescsdddby.rsa', password: '123456')
    }
    let!(:friendship) {
      Friendship.create!( user_id: user.id, friend_id: user1.id, confirmed: false)
     }
     
    it ' ensure user is friend another user' do
      expect(user.is_friend?(user1)).to eq(false)
    end
  end
end
