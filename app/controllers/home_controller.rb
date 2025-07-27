class HomeController < ApplicationController
  def show
    if session[:userinfo] && request.path == root_path
      redirect_to "/receipts"
    end
  end
end
