require 'gosu'
require 'baku'
require 'require_all'

require_relative 'game_config.rb'
require_all "components"
require_all "systems"

class Asteroids < Gosu::Window
  def initialize
    super GameConfig::SCREEN_WIDTH, GameConfig::SCREEN_HEIGHT
    self.caption = "Arena"

    @prev_ms = 0
    
    @world = Baku::World.new
    @world.add_system(Systems::InputSystem.new)
    @world.add_system(Systems::MovementSystem.new)
    @world.add_system(Systems::ScreenWrapSystem.new)
    @world.add_system(Systems::SpriteRenderSystem.new)

    create_player_entity

    create_asteroid_entity
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

  private

  def create_player_entity
    player = @world.create_entity
    player.add_component(PlayerInputComponent.new(0.2, 10, 5, 0.95))
    player.add_component(
      TransformComponent.new(
        GameConfig::SCREEN_WIDTH / 2,
        GameConfig::SCREEN_HEIGHT / 2
      )
    )
    player.add_component(VelocityComponent.new(0, 0))
    player.add_component(AccelerationComponent.new(0, 0))
    player.add_component(RotationComponent.new(-90))
    player.add_component(
      SpriteComponent.new(
        Gosu::Image.new("assets/ship.png"),
        0.5, 0.5,
        0.5, 0.5
      )
    )
  end

  def create_asteroid_entity
    asteroid = @world.create_entity
    asteroid.add_component(TransformComponent.new(100, 100))
    asteroid.add_component(RotationComponent.new(0))
    asteroid.add_component(
      SpriteComponent.new(Gosu::Image.new("assets/asteroid.png"))
    )
  end
end

Asteroids.new.show
