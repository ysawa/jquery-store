# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'coffeescript' do
  watch(%r{.+\.coffee})
end

# guard 'sprockets', destination: "build", minify: true do
#   watch 'jquery.store.js'
# end

guard 'process', name: 'Copy to min', command: 'cp jquery.store.js jquery.store.min.js' do
  watch 'jquery.store.js'
end

guard 'uglify', destination_file: "jquery.store.min.js" do
  watch 'jquery.store.min.js'
end
