require 'yaml'
require './build_script'
require 'net/http'
require 'uri'


def generate_html()
  puts "generating"
  build_script = BuildScript.new
  
  content_yml = YAML::load(open('content.yml'))
  sections = content_yml.keys

  sections.each do |content|
   build_script.title = content_yml[content]["title"]
   
   content_yml[content]["links"].each do |link|
     uri = URI.parse("http://api.bit.ly/v3/shorten?login=nickfloyd&apiKey=R_51cb492a2200dd82b2c738ade4825bea&longUrl=#{link["link"]["uri"]}%2F&format=txt")
     response = Net::HTTP.get_response(uri)
     link["link"]["uri"] = response.body.strip #Net::HTTP.get_print(uri)
     # puts Net::HTTP.get_print(uri)
   end
   
   build_script.links = content_yml[content]["links"]
   
   begin
        open(File.join("files", "#{content}.html"), "w") { |s| s.write build_script.generate }
       rescue Exception => ex
         puts "An error occurred: #{ex.message}"
       end
  end
end


generate_html()