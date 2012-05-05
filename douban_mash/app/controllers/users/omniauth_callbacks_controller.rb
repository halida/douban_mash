class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_filter :authenticate_user!

  def douban
    puts "ok?"
    raise
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

  private


end
