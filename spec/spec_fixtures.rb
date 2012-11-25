require 'dm-sweatshop'

include DataMapper::Sweatshop::Unique

Product.fixture {{
    :manufacturer => %w(Panasonic Sony Canon Red Nikon)[rand(5)],
    :model_name => unique(:model_name) { /\w+/.gen }
}}