require_relative 'node'
require_relative 'movie'
def find_kevin_bacon(node)
  if node.name == "Kevin Bacon"
    return []
  end

  queue = [node]
  path = {}
  current_actor = node
  path[current_actor.name] = {:distance => 0, 
                              :previous_node => nil, 
                              :encountered_movie => nil}

  while (!queue.empty? and path[current_actor.name][:distance] < 5)
    current_actor = queue.shift
    knows_kevin_bacon = current_actor_knows_kevin_bacon(current_actor, queue, path)
    if knows_kevin_bacon[0]
      return knows_kevin_bacon[1]
    end
  end
  nil
end

def current_actor_knows_kevin_bacon(current_actor, queue, path)
  current_actor.film_actor_hash.each do |current_movie, actors|
    knows_kevin_bacon = current_actor_worked_with_kevin_bacon_in_current_movie(current_movie, current_actor, actors, queue, path)
    if knows_kevin_bacon[0]
      return knows_kevin_bacon
    end
  end
  return [false, false]
end

def current_actor_worked_with_kevin_bacon_in_current_movie(current_movie, current_actor, actors, queue, path)
  for actor in actors
    if actor.name != "Kevin Bacon" and !path.has_key?(actor.name) 
      queue.push(actor)
      path[actor.name] = {:distance => path[current_actor.name][:distance] + 1, 
                          :previous_node => path[current_actor.name], 
                          :encountered_movie => current_movie}
    elsif actor.name == "Kevin Bacon"
      return [true, trace_movies_to_kevin(current_movie, path, current_actor)]
    end
  end
  return [false, false]
end

def trace_movies_to_kevin(current_movie, path, current_actor)
  answer = [current_movie]
  prior_path_step = path[current_actor.name]
  while prior_path_step[:previous_node]
    answer.push(prior_path_step[:encountered_movie])
    prior_path_step = prior_path_step[:previous_node]
  end
  answer.reverse
end
