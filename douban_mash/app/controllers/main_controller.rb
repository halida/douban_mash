class MainController < ApplicationController
  def show
  end

  def gender
  end

  def select_gender
  end

  def match
    target_gender = params[:commit]
    @douban_user = Doubanuser.all.sample(1).first
  end

  def result
    douban = Doubanapi.get current_user.douban_token
    render inline: douban.get_people.inspect
  end

  def poker
    if request.post?
      douban = Doubanapi.get current_user.douban_token
      douban.send_mail params[:to_id], params[:title], params[:desc]
      render "result"
    else
      render
    end
  end

  def users
    @users = Doubanuser.where("data != ''").order('id asc').paginate(page: params[:page])
  end

  def control_user
    doubanuser = Doubanuser.find params[:id]
    if ['male', 'female'].include? params['cmd']
      doubanuser.update_attributes gender: params['cmd']
    elsif params['cmd'] == 'kill'
      doubanuser.update_attributes enabled: false
    end
    render inline: "alert('ok')", content_type: "application/javascript"
  end
end
