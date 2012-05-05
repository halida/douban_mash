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
  end

  def poker
  end
end
