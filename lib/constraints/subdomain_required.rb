# frozen_string_literal: true

class SubdomainRequired
  def self.matches?(request)
    request.subdomain.present? && request.subdomain != 'www'
  end
end
