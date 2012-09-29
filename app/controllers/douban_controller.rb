class DoubanController < ApplicationController
  # DOUBAN_APIKEY = "0f89b8bc396423112e9d2a34ac2c6933"
  # DOUBAN_SECRET = "4e0d52e13eb41484"

  def index
    unless params[:oauth_token]
      unless session[:access_token]
        # step 1, initial state, store request_token to session
        callback_url = url_for :action => :index
        redirect_url = douban.get_authorize_url(callback_url)
        session[:request_token] = douban.request_token :as_hash
        redirect_to redirect_url
      else
        # step 3, have access_token, now you can use douban API
        douban.access_token = session[:access_token]
        create_user session[:access_token]
      end
    else
      if session[:request_token]
        # step 2, return from douban, store access_token to session
        douban.request_token = session[:request_token]
        douban.auth
        reset_session
        session[:access_token] = douban.access_token :as_hash
        redirect_to :action => :index
      else
        # error branch, you return from douban, but no request_token in session
        logger.info "return from oauth but no request_token"
        redirect_to :action => :index
      end
    end
  end

  private

  def douban
    @douban ||= Doubanapi.get
  end

  def create_user token
    pre = cookies[:pre]
    cookies[:pre] = ""

    people = douban.get_people
    id = people.id.split('/')[-1].to_i
    user = User.find_or_create_by_douban_id id
    user.name = people.title
    user.douban_token = token
    user.email = "douban-#{id}@douban.com"
    user.password = people.title
    user.save
    sign_in user
    redirect_to pre || "/"
  end
end
