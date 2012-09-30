require 'spec_helper'

describe PostsController do

  def valid_attributes
    { title: "Test Post", body: "*Test Body*" }
  end

  def valid_session
    {}
  end

  let(:user) { FactoryGirl.create(:user) }
  before do
    login_user(user)
  end

  describe "GET index" do
    it "assigns all posts as @posts" do
      post = Post.create! valid_attributes
      get :index, {}, valid_session
      assigns(:posts).should eq([post])
    end
  end

  describe "GET show" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :show, {:id => post.to_param}, valid_session
      assigns(:post).should eq(post)
    end
  end

  describe "GET new" do
    it "assigns a new post as @post" do
      get :new, {}, valid_session
      assigns(:post).should be_a_new(Post)
    end
  end

  describe "GET edit" do
    it "assigns the requested post as @post" do
      post = Post.create! valid_attributes
      get :edit, {:id => post.to_param}, valid_session
      assigns(:post).should eq(post)
    end
  end

  describe "POST create" do
    describe "with valid params" do

      context 'user submits a new post' do
        it "creates a new Post" do
          expect {
            post :create, {:post => valid_attributes}, valid_session
          }.to change(Post, :count).by(1)
        end

        it "assigns a newly created post as @post" do
          post :create, {:post => valid_attributes}, valid_session
          assigns(:post).should be_a(Post)
          assigns(:post).should be_persisted
        end

        it "redirects to the created post" do
          post :create, {:post => valid_attributes}, valid_session
          response.should redirect_to(Post.last)
        end

      end

      context 'user previews post' do

        render_views

        it "shows the preview" do
          post :create, {:post => valid_attributes, :preview => true }, valid_session
          response.body.should have_selector('.preview', :content=> '<h2>Test Post</h2 <strong>Test Body</strong>')
        end
      end

    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved post as @post" do
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => {}}, valid_session
        assigns(:post).should be_a_new(Post)
      end

      it "re-renders the 'new' template" do
        Post.any_instance.stub(:save).and_return(false)
        post :create, {:post => {}}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do

      let(:post) { FactoryGirl.create(:post, title: "Test Post", body: "*Test Body*") }

      context 'user updates post' do
        it "updates the requested post" do
          Post.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
          put :update, {:id => post.to_param, :post => {'these' => 'params'}}, valid_session
        end

        it "assigns the requested post as @post" do
          put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
          assigns(:post).should eq(post)
        end

        it "redirects to the post" do
          put :update, {:id => post.to_param, :post => valid_attributes}, valid_session
          response.should redirect_to(post)
        end

      end


      context 'user previews post' do

        render_views

        it "shows the preview" do
          put :update, {:id => post.to_param, :post => valid_attributes, :preview => true }, valid_session
          response.body.should have_selector('.preview', :content=> '<h2>Test Post</h2 <strong>Test Body</strong>')
        end
      end

    end

    describe "with invalid params" do
      it "assigns the post as @post" do
        post = Post.create! valid_attributes
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post.to_param, :post => {}}, valid_session
        assigns(:post).should eq(post)
      end

      it "re-renders the 'edit' template" do
        post = Post.create! valid_attributes
        Post.any_instance.stub(:save).and_return(false)
        put :update, {:id => post.to_param, :post => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested post" do
      post = Post.create! valid_attributes
      expect {
        delete :destroy, {:id => post.to_param}, valid_session
      }.to change(Post, :count).by(-1)
    end

    it "redirects to the posts list" do
      post = Post.create! valid_attributes
      delete :destroy, {:id => post.to_param}, valid_session
      response.should redirect_to(posts_url)
    end
  end

end
