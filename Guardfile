guard 'bundler' do
  watch('Gemfile')
end

guard 'rspec', :cli => '--color --format nested --fail-fast'  do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/models/(.+)\.rb$})     { |m| '^spec/#{m[1]}_spec.rb' }
  watch('^spec/spec_helper.rb')  { 'spec' }
end
