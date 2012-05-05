class MainController < ApplicationController
  def show
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
    return redirect_to 'main/match' if current_user.matchs.count >= 6

    if request.post?
      # current_user.matches.create params.slice(:user_id, :item_id, :item_type, :doubanuser_id)
      current_user.matches.create!
    end

    # @users = Doubanuser.where("data != ''").where(gender: current_user.select_gender).sample(2)
    # @items = @users.map{|u| u.books.sample(1).last}
    @items = Book.first(10).sample(2)
    
  end

  def match
    target_gender = params[:commit] || 'female'
    @douban_user = Doubanuser.where("data != ''").where(gender: target_gender).sample(1).first
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
