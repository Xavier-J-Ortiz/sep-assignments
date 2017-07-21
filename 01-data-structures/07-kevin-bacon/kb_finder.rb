require_relative 'node'
require_relative 'movie'
def find_kevin_bacon(node)

  if node.name == "Kevin Bacon"
    return []
  end

  bfs_actor_queue = [node]
  path = {}
  current_actor = node
  max_steps = 5
  path[current_actor.name] = {:distance => 0, 
                              :previous_node => nil, 
                              :encountered_movie => nil}
  while (!bfs_actor_queue.empty? and path[current_actor.name][:distance] < max_steps)
    current_actor = bfs_actor_queue.shift
    knows_kevin_bacon = does_current_actor_know_kevin_bacon?(current_actor, bfs_actor_queue, path)
    if knows_kevin_bacon
      return knows_kevin_bacon
    end
  end
  nil
end

def does_current_actor_know_kevin_bacon?(current_actor, bfs_actor_queue, path)
  current_actor.film_actor_hash.each do |current_movie, actors|
    knows_kevin_bacon = worked_with_kevin_here?(current_movie, current_actor, actors, bfs_actor_queue, path)
    if knows_kevin_bacon
      return knows_kevin_bacon
    end
  end
  return false
end

def worked_with_kevin_here?(current_movie, current_actor, actors, bfs_actor_queue, path)
  for actor in actors
    if (actor.name != "Kevin Bacon" and !path.has_key? actor.name) 
      bfs_actor_queue.push actor 
      path[actor.name] = {:distance => path[current_actor.name][:distance] + 1, 
                          :previous_node => path[current_actor.name], 
                          :encountered_movie => current_movie}
    elsif actor.name == "Kevin Bacon"
      return trace_movies_to_kevin(current_movie, path, current_actor)
    end
  end
  return false
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
