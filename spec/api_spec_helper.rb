require 'ostruct'

module ApiSpecHelper
	def json_to_struct(str)
		OpenStruct.new(JSON.parse(str))
	end
end