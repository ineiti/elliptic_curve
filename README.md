# EllipticCurve

Just the bare implementation for doing some exercises with elliptic curves. See below for usage.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'elliptic_curve'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install elliptic_curve

## Usage

You can define elliptic curves using the EllitpicCurve::EC-class:

```
ec = EllipticCurve::EC.new( 1, 2, 11 )
```

which would create an elliptic curve in F_11 of the following form:

```
y^2 = x^3 + 1 * x + 2
```

Then you can define a point on this curve:

```
p = EllitpicCurve::P( ec, 4, 2 )
```

And do some calculations:

```
psum = p + p
psum2 = psum + p
if psum2 == p * 3
  puts "is equal, x-axis is: #{psum2.x}"
else
  puts 'some error'
end
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/elliptic_curve/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
