require 'json'
Api::App.controllers :posts do
  
  get :index, map: "api/v1/posts" do
    @posts = Post.all
    render "posts/index"
  end

  post :create, map: "api/v1/posts" do
    parameters = post_params
    if parameters["post"].nil?
      return '{}'
    end
    @post = Post.create parameters["post"]
    render "posts/show"
  end

  get :show, map: "api/v1/posts/:id" do
    @post = Post[params[:id]]
    render "posts/show"
  end

  put :update, map: "api/v1/posts/:id" do
    @post = Post[params[:id]]

    if @post.nil?
      return '{}'
    end

    parameters = post_params
    @post.update parameters["post"]
    render "posts/show"

  end

  delete :destroy, map: "api/v1/posts/:id" do
    @post = Post[params[:id]]
    @post.delete unless @post.nil?
  end

end


def post_params
  JSON.parse(request.body.read)
end
