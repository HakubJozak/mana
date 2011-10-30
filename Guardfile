# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'livereload', :api_version => '1.6', :port => 4444 do
  # watch(%r{app/.+\.(erb|haml)})
  # watch(%r{app/helpers/.+\.rb})
#  watch(%r{(public/|app/assets).+\.(css|js|html)})

  watch %r{app(/assets/.+scss)} do |m|
    sheet = m[1].gsub('/stylesheets','').gsub('.scss','')
    [ sheet ]
  end

#  watch(%r{(app/assets/.+\.js)\.coffee}) { |m| m[1] }
#  watch(%r{config/locales/.+\.yml})
end
