class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    auth_for_oauth(request.env["omniauth.auth"])
  end

  def twitter
    auth_for_oauth(request.env["omniauth.auth"])
  end

  def vkontakte
    auth_for_oauth(request.env["omniauth.auth"])
  end

  def bnet
    auth_for_oauth(request.env["omniauth.auth"])
  end

  def steam
    auth_for_oauth(request.env["omniauth.auth"])
  end

  def wargaming
    oauth = params.merge({
      uid: params[:account_id],
      provider: 'wargaming',
      username: params[:nickname]
    })

    # Should prolongate acceess token here to make sure it is valid.
    # Check: https://ru.wargaming.net/developers/api_reference/wot/auth/prolongate/

    auth_for_oauth(oauth)
  end

  def failure
    redirect_to '/'
  end

  protected

  def auth_for_oauth(oauth)
    # Force reload cookies. FIXME: Get rid of that once we have some time.
    # Without that line Steam OAuth SignIn is broken since RoR do not parse HTTP_COOKIE properly for some reason
    env['action_dispatch.cookies'] = nil

    ext_auth = ExternalAuthentication.find_by uid: oauth['uid'], provider: oauth['provider']

    if ext_auth # Sign in from ExternalAuthentication
      user = ext_auth.user
      data = { authenticator: 'ActiveRecord', user_data: { username: user.username, extra_attributes: user.attributes.with_indifferent_access } }
      ext_auth.update_attributes json: oauth
      sign_in(data)
    elsif current_user # Attach new ExternalAuthentication to current user
      user = User.find_by uuid: current_user.extra_attributes[:uuid]
      ext_auth = user.external_authentications.find_or_create_by uid: oauth['uid'], provider: oauth['provider']
      ext_auth.update_attributes json: oauth
      redirect_to sessions_path
    else # Redirect to register if user not found
      session["devise.oauth_data"] = oauth
      redirect_to new_user_registration_url
    end
  end
end
