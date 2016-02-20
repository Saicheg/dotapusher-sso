class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    oauth = request.env["omniauth.auth"]
    ext_auth = ExternalAuthentication.find_by uid: oauth['uid'], provider: oauth['provider']

    if ext_auth # Sign in from ExternalAuthentication
      user = ext_auth.user
      data = { authenticator: 'ActiveRecord', user_data: { username: user.username, extra_attributes: user.attributes.with_indifferent_access } }
      sign_in(data)
    elsif current_user # Attach new ExternalAuthentication to current user
      user = User.find_by uuid: current_user.extra_attributes[:uuid]
      user.external_authentications.find_or_create_by uid: oauth['uid'], provider: oauth['provider']
      redirect_to sessions_path
    else # Redirect to register if user not found
      session["devise.facebook_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    # redirect_to '/'
  end
end
