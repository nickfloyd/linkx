require 'erb'

class BuildScript
  attr_accessor :title, :links
 
def generate
    erb = File.open "layout.erb"
    return_config = ERB.new erb.read
    erb.close
    return_config.result binding
  end

end