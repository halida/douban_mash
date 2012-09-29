require 'nestful'

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_filter :authenticate_user!

  def github
    result = Nestful.post "https://github.com/login/oauth/access_token", client_id: "fc4fcada7375f0340d00", client_secret: "febe5520977de84f0dbb65196a936d7c76c6d552", code: params[:code]
    render inline: result

    user_info = Nestful.get "https://api.github.com/user", access_token: "xxx"
    return 
    @user = User.create github_token: params[:code]
    sign_in_and_redirect @user
  end

  def douban
    raise "xxx douban"
    # You need to implement the method below in your model
    @user = User.find_for_douban_oauth(request.env["omniauth.auth"], current_user)

    if @user.persisted?
      flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Douban"
      sign_in_and_redirect @user, :event => :authentication
    else
      session["devise.douban_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    raise
    render inline: "#{params}"
  end

  private


end
