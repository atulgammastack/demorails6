require 'rails_helper'

RSpec.describe Post, type: :model do
  
  let!(:user) {
    User.create!(first_name: 'first', username: 'username22', email: 'aptidaedr@gddryff.acro', password: '123456')
   }
  describe "Associations" do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
  end
  it "is create a post" do
    post = Post.create!(content: 'Anything fdssg ',
                 user_id: user.id)
    expect(post).to be_valid
  end
end
