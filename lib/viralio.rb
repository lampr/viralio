require 'rubygems'
require 'rest_client'
require 'json'

module Viralio
	API_URL_subscription  = 'http://viralio.herokuapp.com/api/subscribe'
	API_URL_progress  = 'http://viralio.herokuapp.com/api/progress'
 	API_VERSION = '0.0.1'

 	def self.new(api_key)
 		Viralio::Client.new(api_key)
 	end
 	
 	class Client 		
 		def initialize(api_key)
	    	@api_key = api_key
	    end

	    def subscribe(mail, from)
	    	subscription = RestClient.post API_URL_subscription, {:key => @api_key, :mail => mail, :from => from}
	    	results = JSON.parse(subscription.to_str)
	    	if results['status'] == 200 || results['status'] == 400
	    		share = results['share']
	    	else
	    		error = results['status']	#401, 406
	    	end	
	    end

	    def progress(share)
	    	progress = RestClient.post API_URL_progress, { :api_key => @api_key, :share => share }
	    	results = JSON.parse(progress.to_str)
	    	progress = results['progress']
	    end
 	end
end