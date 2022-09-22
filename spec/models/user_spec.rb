require 'rails_helper'

RSpec.describe User, type: :model do
  context "validation tests" do
    it 'ensure save succesfully presence' do
      user = User.new(first_name: 'first', username: 'username22', email: 'aptidar@grepruby.rsa', password: '123456').save
      expect(user).to eq(true)
    end
  end 
end
