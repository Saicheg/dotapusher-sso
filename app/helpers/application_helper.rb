module ApplicationHelper
  def wargaming_openid_url
    uri = URI('https://api.worldoftanks.eu/wot/auth/login/')
    params = URI.encode_www_form({
      application_id: Rails.application.secrets.wargaming_app_id,
      redirect_uri: "#{Rails.application.secrets.current_domain}/users/auth/wargaming/callback"
    })
    "#{uri}?#{params}"
  end
end
