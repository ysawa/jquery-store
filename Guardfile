# A sample Guardfile
# More info at https://github.com/guard/guard#readme

compiler_jar = './compiler.jar'

guard 'coffeescript' do
  watch(%r{.+\.coffee})
end

# guard 'sprockets', destination: "build", minify: true do
#   watch 'jquery.store.js'
# end

# guard 'process', name: 'Copy to min', command: 'cp jquery.store.js jquery.store.min.js' do
#   watch 'jquery.store.js'
# end

# guard 'uglify', destination_file: "jquery.store.min.js" do
#   watch 'jquery.store.min.js'
# end

guard 'shell' do
  watch 'jquery.store.js' do
    begin
      raise unless system('cp jquery.store.js jquery.store.min.js')
      command = "java -jar #{compiler_jar}"
      command += " --js jquery.store.js"
      command += " --js_output_file jquery.store.min.js"
      raise unless system(command)
      n "javascript is successfully minified", 'minifying javascript', :success
    rescue
      n "javascript failed to be minified", 'minifying javascript', :failed
    end
  end
end
