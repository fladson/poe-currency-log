# frozen_string_literal: true

module POE
  class Error
    class InvalidSession < RuntimeError; end
    class InvalidParams < RuntimeError; end
    class ServiceUnavailable < RuntimeError; end
    class StashParser < RuntimeError; end
    class RateLimit < RuntimeError; end
  end
end
