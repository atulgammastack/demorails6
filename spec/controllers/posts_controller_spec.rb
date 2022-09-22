require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  render_views
  
  let!(:user) {
   User.create!(first_name: 'first', username: 'username22', email: 'tasrrghr@gppsreacro', password: '123456')
  }
  before (:each) do
    sign_in(user)
  end

  describe "GET index" do
    let!(:post) { Post.create(user_id: user.id,  content: "happy engginers day") }
    let!(:post1) { Post.create(user_id: user.id,  content: "Lorem Ispum") }
    subject { get :index }

    it 'is successful' do
      subject
      expect(response).to be_successful
    end
    
    it 'assigns the posts correctly' do
      subject
      expect(assigns(:posts)).to eq([ post1, post])
    end
end
