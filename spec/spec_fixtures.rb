require 'dm-sweatshop'
require 'time'

include DataMapper::Sweatshop::Unique

def rand_date
  Time.at(rand * Time.now.to_i).to_date
end

def rand_date_after(dt)
   dt + rand(100)
end

def rand_date_before(dt)
  dt - rand(100)
end

Product.fixture {{
  :manufacturer => %w(Panasonic Sony Canon Red Nikon)[rand(5)],
  :model_name => unique(:model_name) { /\w+/.gen }
}}

Product.fixture(:panasonic) {{
  :manufacturer => 'Panasonic',
  :model_name => unique(:model_name) { /\w+/.gen }
}}

Product.fixture(:panasonic_gh3) {{
  :manufacturer => 'Panasonic',
  :model_name => 'GH3'
}}

Product.fix(:with_assets) {{
  :manufacturer => /\w+/.gen,
  :model_name => /\w+/.gen,
  :assets => 10.of { Asset.gen }
}}

Asset.fixture {{
  :serial_number => unique(:serial_number) { /\w+/.gen },
  :service_tag => unique(:service_tag) { /\w+/.gen },
  :acquire_date => Time.at(rand * Time.now.to_i).to_date
}}

LineItem.fixture {{
  :notes => /[:sentence:]/.gen,
  :asset => 1.of { Asset.pick },
  :reservation => 1.of { Reservation.pick }
}}

Reservation.fixture {{
  :name => /\w+/.gen,
  :start_date => start_date = rand_date,
  :end_date => start_date + rand(100)
}}
