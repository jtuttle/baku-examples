class Play < GameState
  def initialize
    super(:play)
  end

  def on_enter(data)
    @prev_ms = Gosu::milliseconds()
    @player = data[:player]
    @world = data[:world]
  end

  def on_exit
    @player = nil
    @world = nil
  end
  
  def update
    current_ms = Gosu::milliseconds()
    delta_ms = current_ms - @prev_ms
    @prev_ms = current_ms
    
    @world.update(delta_ms)

    if @player.get_component(Components::PlayerStateComponent).dead
      exit(:lose, { world: @world })
    end
  end

  def draw
    @world.draw
  end
end
