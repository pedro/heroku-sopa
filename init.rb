require "heroku/command/base"

class Heroku::Command::Sopa < Heroku::Command::BaseWithApp
  def index
    display "usage: heroku sopa:on/off"
  end

  def on
    ensure_custom_error_pages
    url = protest_url(args.first)
    heroku.add_config_vars(app, { "MAINTENANCE_PAGE_URL" => url })
    heroku.maintenance(app, :on)
    display "SOPA protest is now enabled"
    display "Redirecting to: #{url}"
  end

  def off
    heroku.remove_config_var(app, "MAINTENANCE_PAGE_URL")
    heroku.maintenance(app, :off)
    display "SOPA protest disabled"
  end

  private
    def protest_url(url_or_name)
      (protest_pages[url_or_name] || url_or_name || protest_pages["zachstronaut"]).tap do |url|
        raise Heroku::Command::CommandFailed, "Invalid URL: #{url}" unless url =~ /\Ahttp:\/\//
      end
    end

    def protest_pages
      {
        "eff"          => "http://blacklists.eff.org",
        "protestsopa"  => "http://protestsopa.org",
        "sopasoup"     => "http://sopasoup.heroku.com",
        "zachstronaut" => "http://www.zachstronaut.com/lab/text-shadow-box/stop-sopa.html",
      }
    end

    def ensure_custom_error_pages
      return if heroku.installed_addons(app).any? { |a| a["name"] == "custom_error_pages" }
      heroku.install_addon(app, "custom_error_pages")
    rescue RestClient::UnprocessableEntity => e
      raise e unless e.http_body.include?("You can already use custom error pages")
    end
end
