object @user => false
attributes :readable_token => :authentication_token, :email => :email
node (:message) {|m| @message }
