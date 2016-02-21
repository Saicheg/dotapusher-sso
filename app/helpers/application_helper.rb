module ApplicationHelper
  def wargaming_openid_url
    uri = URI('https://api.worldoftanks.eu/wot/auth/login/')
    params = URI.encode_www_form({
      application_id: Rails.application.secrets.wargaming_app_id,
      redirect_uri: 'http://127.0.0.1:3001/users/auth/wargaming/callback'
    })
    "#{uri}?#{params}"
  end
end
