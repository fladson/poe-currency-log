# frozen_string_literal: true

require 'faraday'

module POE
  class ErrorHandling < Faraday::Response::Middleware
    def on_complete(env)
      case env[:status]
      when 400
        raise POE::Error::InvalidParams, '400: Invalid params'
      when 401
        raise POE::Error::InvalidSession, '401: Session invalid'
      when 403
        raise POE::Error::InvalidSession, '403: Session invalid'
      when 302
        raise POE::Error::InvalidSession, '403: Session invalid'
      when 503
        raise POE::Error::ServiceUnavailable, '503: Service Unavailable'
      when 429
        raise POE::Error::RateLimit, '492: Rate limit exceeded'
      end
    end
  end
end
