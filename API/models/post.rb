class Post < Sequel::Model
  Sequel::Model.plugin :timestamps

  def after_create
    Pusher['posts'].trigger('new-post',  {post: self.values})
  end
end
