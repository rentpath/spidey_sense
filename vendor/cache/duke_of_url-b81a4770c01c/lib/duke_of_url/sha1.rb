require 'digest'

module DukeOfUrl
  class SHA1
    def self.hexdigest(url)
      Digest::SHA1.hexdigest url
    end
  end
end
