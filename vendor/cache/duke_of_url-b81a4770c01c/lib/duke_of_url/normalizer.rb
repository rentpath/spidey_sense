require 'hashie'
require 'postrank-uri'

module DukeOfUrl
  class Normalizer
    AMPERSAND        = '&'
    DEFAULT_OPTIONS  = { }
    EQUAL_SIGN       = '='
    PARAMS_SEPARATOR = /\/?\?/
    QUESTION_MARK    = '?'

    attr_reader :normalized_url, :options, :url

    def self.normalize(url)
      new(url).normalize
    end

    def initialize(url, options = {})
      @url     = url
      @options = DEFAULT_OPTIONS.merge options
    end

    def normalize
      return url if url.blank?

      modified_url           = ::PostRank::URI.clean url
      (modified_url, params) = modified_url.split(PARAMS_SEPARATOR)
      alphabetized_params    = alphabetize_params(params) if params
      [modified_url, alphabetized_params].compact.join(QUESTION_MARK)
    end

    private

      def alphabetize_params(params)
        params = params
          .split(AMPERSAND)
          .inject(Hashie::Mash.new) do |result, param|
            (key, value) = param.split(EQUAL_SIGN)
            result[key] = value
            result
          end

        params
          .keys
          .sort
          .map { |key| "#{key}=#{params[key]}" }
          .join(AMPERSAND)
      end
  end
end
