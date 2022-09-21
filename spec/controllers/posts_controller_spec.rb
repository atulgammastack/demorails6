require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:user) {
   User.create!(first_name: 'first', username: 'username22', email: 'tasrrghr@gppsreacro', password: '123456')
  }
  before (:each) do
    sign_in(user)
  end
  describe "GET index" do
    it "assigns @posts" do
      post = Post.create(user_id: user.id,  content: "happy engginers day")
      get :index
      byebug
      # expect(assigns(:posts)).to eq([post])
      # expect(@controller.instance_variable_get(:@posts)).to match([post])
      expect(view).to render_template('posts/index')
    end
  end
end
