require 'yaml'
require './build_script'

def generate_html()
  puts "generating"
  build_script = BuildScript.new
  
  content_yml = YAML::load(open('content.yml'))
  sections = content_yml.keys

  sections.each do |content|
   build_script.title = content_yml[content]["title"]
   build_script.links = content_yml[content]["links"]
   
   begin
        open(File.join("files", "#{content}.html"), "w") { |s| s.write build_script.generate }
       rescue Exception => ex
         puts "An error occurred: #{ex.message}"
       end
  end
end

generate_html()