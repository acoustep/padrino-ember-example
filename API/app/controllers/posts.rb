require 'json'
Api::App.controllers :posts, map: "api/v1/posts" do
  
  get :index, map: "" do
    @posts = Post.all
    render "posts/index"
  end

  post :create, map: "" do
    parameters = post_params
    if parameters["post"].nil?
      return '{}'
    end
    @post = Post.create parameters["post"]
    render "posts/show"
  end

  get :show, map: ":id" do
    @post = Post[params[:id]]
    render "posts/show"
  end

  put :update, map: ":id" do
    @post = Post[params[:id]]

    if @post.nil?
      return '{}'
    end

    parameters = post_params
    @post.update parameters["post"]
    render "posts/show"

  end

  delete :destroy, map: ":id" do
    @post = Post[params[:id]]
    @post.delete unless @post.nil?
  end

end

def post_params
  JSON.parse(request.body.read)
end
