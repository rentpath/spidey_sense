require 'uri'

class UrlUtility
  include HTTParty

  def self.domain(url)
    uri = URI.parse(url)
    uri.host.split('.').last(2).join('.')
  end

  def self.in_domain(url, domain)
    domain.present? && (url || '').match(/\Ahttp(s)?:\/\/([^\/]*)#{domain}/)
  end

  def self.normalize(url)
	  return url if url.match('\Afile:')
	  url.end_with?('/') ? url : "#{url}/"
  end

  def self.sha1(url)
    DukeOfUrl::SHA1.hexdigest(url)
  end

  def self.status(url)
    begin
      response = get url
      response.code.to_i
    rescue StandardError => e
      500
    end
  end
end
