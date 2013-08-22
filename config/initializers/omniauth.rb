OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do

  if Rails.env.development?
    OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

	provider :facebook, '1417372111822319', '6c92d321b924e46e81d2045c7b2a2177', { :scope => "publish_stream" , :client_options => {:ssl => {:verify => false}}}
  else
     OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
	provider :facebook, '708728955810882', 'd1a3acb461c828ae01a2b6f33951ba8d', { :scope => "publish_stream" , :client_options => {:ssl => {:verify => false}}}
  end

  
end

