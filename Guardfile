guard 'bundler' do
  watch('Gemfile')
end

guard 'rspec', :cli => '--color --format nested --fail-fast'  do
  watch(%r{app/specs/.+_spec\.rb$})
  watch(%r{app/models/(.+)\.rb$})     { |m| 'app/specs/#{m[1]}_spec.rb' }
  watch('app/specs/spec_helper.rb')  { 'spec' }
end