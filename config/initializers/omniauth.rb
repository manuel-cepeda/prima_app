OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '708728955810882', 'd1a3acb461c828ae01a2b6f33951ba8d', { :scope => "publish_stream", , :client_options => {:ssl => {:verify => false}}}
end

