class MainController < ApplicationController
  def show
    return render if request.get?
    current_user.matches.destroy_all
    redirect_to "/main/pre_match"
  end

  def gender
    return render if request.get?
    current_user.gender = params[:commit]
    current_user.save
    redirect_to "/main/select_gender"
  end

  def select_gender
    return render if request.get?
    current_user.select_gender = params[:commit]
    current_user.save
    redirect_to "/main/pre_match"
  end

  def pre_match
    return redirect_to '/main/match' if current_user.matches.count >= 4

    if request.post?
      # current_user.matches.create params.slice(:user_id, :item_id, :item_type, :doubanuser_id)
      current_user.matches.create!
    end

    @item_type = "book"
    @items = Book.random(2)
    
  end

  def match
    # target_gender = params[:commit] || 'female'
    target_gender = 'female'
    @douban_user = Doubanuser.where("data != ''").where(gender: target_gender).random
  end

  def result
    # douban = Doubanapi.get current_user.douban_token
    # render inline: douban.get_people.inspect
  end

  def poker
    @douban_user = Doubanuser.find params[:to_id]
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
