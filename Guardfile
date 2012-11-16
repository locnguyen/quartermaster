guard 'bundler' do
  watch('Gemfile')
end

guard 'rspec', :spec_paths => 'app/spec', :cli => '--color --format nested --fail-fast'  do
  watch(%r{^app/spec/.+_spec\.rb$})
  watch(%r{^app/models/(.+)\.rb$})     { |m| 'app/specs/#{m[1]}_spec.rb' }
  watch('^app/spec/spec_helper.rb')  { 'spec' }
end