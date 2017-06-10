# A line of people at an amusement park ride
# There is a front to the line, as well as a back.
# People may leave the line whenever they see fit and those behind them take their place.
class Line
  attr_accessor :members
  attr_accessor :line_length

  def initialize
    @members = []
    @line_length = @members.length
  end

  def join person 
    @members.push(person)
    @line_length = @members.length
  end

  def leave person 
    @members.delete(person)
    @line_length = @members.length
  end

  def front
    @members[0]
  end

  def middle
    @members[(@line_length / 2)]
  end

  def back
    @members[-1]
  end

  def search person 
    # represents the location of the person in the line
    index(person) + 1 
  end

  private

  def index person 

    @members.index(person)
  end

end
