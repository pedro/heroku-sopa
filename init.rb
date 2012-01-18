require "heroku/command/base"

class Heroku::Command::Sopa < Heroku::Command::BaseWithApp
  def index
    display "usage: heroku sopa:on/off"
  end

  def on
    ensure_custom_error_pages
    heroku.add_config_vars(app, { "MAINTENANCE_PAGE_URL" => "https://www.google.com/landing/takeaction/" })
    heroku.maintenance(app, :on)
    display "SOPA protest is now enabled"
  end

  def off
    heroku.remove_config_var(app, "MAINTENANCE_PAGE_URL")
    heroku.maintenance(app, :off)
    display "SOPA protest disabled"
  end

  private
    def ensure_custom_error_pages
      return if heroku.installed_addons(app).any? { |a| a["name"] == "custom_error_pages" }
      heroku.install_addon(app, "custom_error_pages")
    rescue RestClient::UnprocessableEntity => e
      raise e unless e.http_body.include?("You can already use custom error pages")
    end
end
