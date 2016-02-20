require 'http_accept_language'

class ApplicationController < ActionController::Base
  include CASino::SessionsHelper

  protect_from_forgery

  before_action :set_locale
  before_action :memoize_service_in_session

  private
  def memoize_service_in_session
    session[:latest_service] ||= params[:service]
    params[:service] ||= session[:latest_service]
  end

  def set_locale
    I18n.locale = extract_locale_from_accept_language_header || I18n.default_locale
  end

  def extract_locale_from_accept_language_header
    if request.env['HTTP_ACCEPT_LANGUAGE']
      http_accept_language.compatible_language_from(I18n.available_locales)
    end
  end

  def http_accept_language
    HttpAcceptLanguage::Parser.new request.env['HTTP_ACCEPT_LANGUAGE']
  end
end
