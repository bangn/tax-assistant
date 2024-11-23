class ApplicationController < ActionController::Base
  include Pagy::Backend

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  # https://discuss.rubyonrails.org/t/help-rails-hello-world-complains-of-your-browser-is-not-supported-please-upgrade-your-browser-to-continue-when-displaying-simple-html/86744
  # allow_browser versions: :modern
  protect_from_forgery with: :exception
end
