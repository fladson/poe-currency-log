module POE
  class Error
    class InvalidSession < RuntimeError; end
    class InvalidParams < RuntimeError; end
    class ServiceUnavailable < RuntimeError; end
    class StashParser < RuntimeError; end
  end
end
