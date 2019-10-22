class ApplicationController < ActionController::API

  # before_action :restrict_remote_ip
  #
  # PERMIT_ADDRESSES = ['127.0.0.1', '::1', '000.000.00.00'].freeze
  #
  # def restrict_remote_ip
  #   unless PERMIT_ADDRESSES.include?(request.remote_ip)
  #     render text: 'Service Unavailable', status: 503
  #   end
  # end
end
