class MainController < ApplicationController
  def show
    return render if request.get?
    # redirect_to "/douban" unless user_signed_in?
    # current_user.matches.destroy_all
    # current_user.pokereds.destroy_all
    session[:matches] = []
    session[:pokereds] = []
    redirect_to "/main/pre_match"
  end


  def pre_match
    # return redirect_to '/main/match' if current_user.matches.count >= Match::MATCH_COUNT
    return redirect_to '/main/match' if session[:matches].count >= Match::MATCH_COUNT

    if request.post?
      # current_user.matches.create!
      if params[:type]
        session[:matches] << {type: params[:type], id: params[:id]}
      end
    end

    item_class = [Book, Music, Movie].sample
    @item_type = item_class.name.downcase
    @items = item_class.random(2)
    
  end

  def match
    # return redirect_to :root if current_user.matches.count < Match::MATCH_COUNT
    return redirect_to :root if session[:matches].count < Match::MATCH_COUNT

    @pokereds = session[:pokereds].count
    return redirect_to :root if @pokereds >= Pokered::MAX_COUNT
    @has_next = @pokereds < Pokered::MAX_COUNT - 1

    target_gender = 'female'
    @douban_user = Match.match gender: target_gender, excepts: session[:pokereds], matches: session[:matches]
    @event = @douban_user.userevents.first.event
    session[:pokereds] << @douban_user.id
  end

  def result
  end

  def poker
    return unless check_douban_sign_in

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
    redirect_to :root unless user.admin?
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

end
