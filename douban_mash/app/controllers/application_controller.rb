class ApplicationController < ActionController::Base
  protect_from_forgery

  def check_douban_sign_in
    return true if user_signed_in?
    session[:pre] = request.fullpath
    redirect_to "/douban"
    return 
  end
end
