require_relative 'node'
require_relative 'movie'
def find_kevin_bacon(node)
  if node.name == "Kevin Bacon"
    return []
  end

  queue = [node]
  path = {}
  current_node = node
  path[current_node.name] = {:distance => 0, 
                             :previous_node => nil, 
                             :encountered_movie => nil}

  while (!queue.empty? and path[current_node.name][:distance] < 5)
    current_node = queue.shift
    current_node.film_actor_hash.each do |movie_title, actors|
      for actor in actors
        if actor.name == "Kevin Bacon"
          return trace_path(movie_title, path, current_node)
        elsif !path.has_key?(actor.name)
          queue.push(actor)
          path[actor.name] = {:distance => path[current_node.name][:distance] + 1, 
                              :previous_node => path[current_node.name], 
                              :encountered_movie => movie_title}
        end
      end
    end
  end
  nil
end

def trace_path(movie_title, path, current_node)
  answer = [movie_title]
  prior_path_step = path[current_node.name]
  while prior_path_step[:previous_node]
    answer.push(prior_path_step[:encountered_movie])
    prior_path_step = prior_path_step[:previous_node]
  end
  answer.reverse
end
