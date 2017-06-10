# Pixels require three color values: red, green, and blue.
# Pixel colors red, green, and blue values must be greater than zero and less than 255.
# If  a value less than zero is specified, default to zero. If a value greater than 255 is specified, default to 255.
# Pixels also require a coordinate location: x and y.

class Pixel
  attr_accessor :red
  attr_accessor :green
  attr_accessor :blue

  def initialize(red, green, blue)
    @red = validate_color(red)
    @green = validate_color(green)
    @blue = validate_color(blue)
  end

  def dominant_primary_color
    if @red > @green && @red > @blue
      return "red"
    elsif @green > @red && @green > @blue
      return "green"
    elsif @blue > @green && @blue > @red
      return "blue"
    else
      return "there is no single dominant primary color"
    end
  end

  private

  def validate_color(color)

    if color > 255
      return color = 255
    elsif color < 0
      return color = 0
    end
    color

  end
end
