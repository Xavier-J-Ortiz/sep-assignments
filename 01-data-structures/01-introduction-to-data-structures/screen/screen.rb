require_relative 'pixel'

class Screen
  attr_accessor :width
  attr_accessor :height
  attr_accessor :matrix

  def initialize(width, height)
    self.width = width
    self.height = height
    matrix = []

    for j in (0...height)
      row = []
      for i in (0...width)
        row.push(nil)
      end
      matrix.push(row)
    end

    self.matrix = matrix

  end

  # Insert a Pixel at x, y
  def insert(pixel, x, y)
    inbounds(x, y) ? self.matrix[y][x] = pixel : nil
  end

  def at(x, y)
    inbounds(x, y) ? self.matrix[y][x] : nil
  end

  private

  def inbounds(x, y)

    if x >= self.width or x < 0
      return false
    elsif y >= self.height or y < 0
      return false
    end

    true

  end

end
