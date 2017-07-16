class Movie
  attr_accessor :title
  attr_accessor :actors

  def initialize(title, actors)
    @title = title
    assign_to_actors(actors)
  end

  def assign_to_actors actors
    @actors = actors
    for actor in @actors
      temp_actors = @actors.clone
      temp_actors.delete(actor)
      actor.film_actor_hash[@title] = temp_actors
    end
  end
end
