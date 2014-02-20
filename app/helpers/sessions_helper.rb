module SessionsHelper

  def signed_in?
    !current_user.nil?
  end

  def signed_in_user
    unless signed_in?
      #store_location
      redirect_to venues_url, notice: "Please sign in."
    end
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to root_url, notice: "Please sign in."
    end
  end

  def sign_out
    self.current_user = nil
    session[:user_id] = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url
  end

  def is_authenticated?
     if request.headers["HTTP_AUTHORIZATION"] == 'Bearer '+session['fb_access_token']
       true
      else
       false
      end
  end


end
