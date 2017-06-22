require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    @width = width
    @height = height
    @matrix = []

    for j in (0...height)
      row = []
      for i in (0...width)
        row.push(nil)
      end
      @matrix.push(row)
    end
  end

  def insert(pixel, x, y)
    is_within_bounds?(x, y) ? @matrix[y][x] = pixel : nil
  end

  def get_pixel(x, y)
    is_within_bounds?(x, y) ? @matrix[y][x] : nil
  end

  private

  def is_within_bounds?(x, y)
    if x >= @width or x < 0
      return false
    elsif y >= @height or y < 0
      return false
    end
    true
  end
end
