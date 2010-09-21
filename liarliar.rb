#!/usr/bin/env ruby 

class LiarLiar

  def self.partition_sizes(graph)
    n = graph.length
    current_level = []
    next_level = []
    grp_a = []
    grp_b = []
    visited = {}
    current_level << graph.keys[0]
    visited[current_level[0]] = true
    done = false
    a = true
    while(grp_a.length + grp_b.length < n)
      next_level = []
      current_level.each {|p|
        if a
          grp_a << p
        else 
          grp_b << p
        end
        graph[p].each_key{|k|
          next_level << k unless visited[k]
          visited[k] = true
        }
        visited[p] = true
      }
      current_level = next_level
      a = !a
    end
    [grp_a.length, grp_b.length]
#    next_level = graph[current_level[0]].keys
  end
  
  def self.graph_for(filename)
    
    graph = {}
  
    unless filename && File.exist?(filename)
      puts "error: must specify a valid input file"
      exit
    end
    
    input = File.open(filename)
    n = input.gets.to_i
    
    n.times { |n|
      accuser = input.gets.split
      graph[accuser[0]] = {} unless graph[accuser[0]]
      accused = graph[accuser[0]]
      accuser[1].to_i.times{|m|
        accusee = input.gets.strip
        accused[accusee] = true
        if (graph[accusee])
          graph[accusee][accuser[0]] = true
        else
          graph[accusee] = {accuser[0] => true}
        end
      }
    }
    graph
    #...
  end
end
