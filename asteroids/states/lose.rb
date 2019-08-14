class Lose < Obake::State
  def initialize
    super(:lose)
  end

  def on_enter(data)
    world = data[:world]
    world.dispose
    
    exit(:load)
  end
end
