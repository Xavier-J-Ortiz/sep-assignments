class Movie
  attr_accessor :title
  attr_accessor :actors

  def initialize(title, actors)
    @title = title
    format_actors_array_for_each_actor_node(actors)
  end

  def format_actors_array_for_each_actor_node actors
    @actors = actors
    for actor in @actors
      temp_actors = @actors.clone
      temp_actors.delete(actor)
      actor.film_actor_hash[@title] = temp_actors
    end
  end
end
