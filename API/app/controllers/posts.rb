require 'json'

Api::App.controllers :posts, map: "api/v1/posts", conditions: {:protect => true} do

  def self.protect(protected)
    condition do
      unless User.authenticate request.env
        halt 403, "No secrets for you!"
      end
    end if protected
  end

  get :index, map: "", protect: false do
    @posts = Post.order(Sequel.desc(:id))
    render "posts/index"
  end

  post :create, map: "" do
    parameters = post_params
    if parameters["post"].nil?
      return '{}'
    end
    @post = Post.create parameters["post"].except("socket_id")

    Pusher['posts'].trigger('new-post',  {post: @post.values}, parameters["post"]["socket_id"])

    render "posts/show"
  end

  get :show, map: ":id", protect: false do
    @post = Post[params[:id]]
    render "posts/show"
  end

  put :update, map: ":id" do
    @post = Post[params[:id]]

    if @post.nil?
      return '{}'
    end

    parameters = post_params
    @post.update parameters["post"].except("socket_id")
    render "posts/show"

  end

  delete :destroy, map: ":id" do
    @post = Post[params[:id]]
    @post.delete unless @post.nil?
    return '{}'
  end

end

def post_params
  JSON.parse(request.body.read)
end

