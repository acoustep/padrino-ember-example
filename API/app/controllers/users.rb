Api::App.controllers "api/v1/users" do
  
  post :sign_in do

    user = User.sign_in params.fetch("user", {})

    if user
      @status = 201
    else
      @message = "Invalid login credentials" unless user
      @status = 401
    end

    @user = user
    status @status
    render "users/sign_in"
  end

end
