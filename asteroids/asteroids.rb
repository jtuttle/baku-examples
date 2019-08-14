require 'gosu'
require 'baku'
require 'obake'
require 'pry'
require 'require_all'

require_relative 'game_config.rb'
require_relative 'entity_factory.rb'
require_all 'components'
require_all 'systems'
require_all 'states'

class Asteroids < Gosu::Window
  def initialize
    super GameConfig::SCREEN_WIDTH, GameConfig::SCREEN_HEIGHT
    self.caption = "Asteroids"
    
    @fsm = Obake::FiniteStateMachine.new
    @fsm.add_state(Load.new)
    @fsm.add_state(Play.new)
    @fsm.add_state(Lose.new)
    
    @fsm.change_state(Obake::Transition.new(:load))
  end
  
  def update
    @fsm.current_state.update
  end

  def draw
    @fsm.current_state.draw
  end
end

Asteroids.new.show
