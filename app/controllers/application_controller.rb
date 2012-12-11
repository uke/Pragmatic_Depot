class ApplicationController < ActionController::Base
	protect_from_forgery

 before_filter :dateTimeStamp_function

 def dateTimeStamp_function
 	@dateTime = "#{Time.now.strftime('%d %b %Y')} #{Time.now.strftime('%H:%M:%S')}"
 end
end
