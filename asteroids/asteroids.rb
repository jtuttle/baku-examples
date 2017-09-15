require 'gosu'
require 'baku'
require 'require_all'

require_all "components"
require_all "systems"

class Asteroids < Gosu::Window
  def initialize
    super 800, 600
    self.caption = "Arena"

    @prev_ms = 0
    
    @world = Baku::World.new
    @world.add_system(Systems::InputSystem.new)
    @world.add_system(Systems::MovementSystem.new)
    @world.add_system(Systems::SpriteRenderSystem.new)

    player = @world.create_entity
    player.add_component(PlayerInputComponent.new(10, 5))
    player.add_component(TransformComponent.new(100, 100))
    player.add_component(VelocityComponent.new(0, 0))
    player.add_component(AccelerationComponent.new(0))
    player.add_component(RotationComponent.new(0))
    player.add_component(SpriteComponent.new(Gosu::Image.new("assets/ship.png")))
    
  end

  def update
    current_ms = Gosu::milliseconds()
    delta_ms = current_ms - @prev_ms
    @prev_ms = current_ms

    @world.update(delta_ms)
  end

  def draw
    @world.draw
  end
end

Asteroids.new.show
