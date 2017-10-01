require 'gosu'
require 'baku'
require 'pry'
require 'require_all'

require_relative 'game_config.rb'
require_all "components"
require_all "systems"

class Asteroids < Gosu::Window
  def initialize
    super GameConfig::SCREEN_WIDTH, GameConfig::SCREEN_HEIGHT
    self.caption = "Asteroids"

    @prev_ms = 0

    @world = Baku::World.new
    @world.add_system(Systems::InputSystem.new)
    @world.add_system(Systems::LaserSystem.new)
    @world.add_system(Systems::MovementSystem.new)
    @world.add_system(Systems::ScreenWrapSystem.new)
    @world.add_system(Systems::TimedDestroySystem.new)

    @world.add_system(Systems::SpriteRenderSystem.new)
    @world.add_system(Systems::ColliderRenderSystem.new)

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
    player.add_component(
      PlayerInputComponent.new(
        acceleration_speed: 0.2,
        max_velocity: 10,
        rotation_speed: 5,
        friction: 0.95
      )
    )
    player.add_component(
      TransformComponent.new(
        GameConfig::SCREEN_WIDTH / 2,
        GameConfig::SCREEN_HEIGHT / 2,
        10
      )
    )
    player.add_component(RotationComponent.new(-90))
    player.add_component(VelocityComponent.new(0, 0, 0))
    player.add_component(
      SpriteComponent.new(
        Gosu::Image.new("assets/ship.png"),
        scale_x: 0.5, scale_y: 0.5
      )
    )
    player.add_component(
      LaserComponent.new(
        laser_spawn_distance: 10,
        laser_velocity: 10,
        laser_lifespan_ms: 500
      )
    )
    player.add_component(ColliderComponent.new(25))
  end

  def create_asteroid_entity
    asteroid = @world.create_entity
    asteroid.add_component(TransformComponent.new(100, 100, 10))
    asteroid.add_component(RotationComponent.new(0))
    asteroid.add_component(
      VelocityComponent.new(
        rand(-2.0...2.0),
        rand(-2.0...2.0),
        rand(-1.0...1.0)
      )
    )
    asteroid.add_component(
      SpriteComponent.new(
        Gosu::Image.new("assets/asteroid.png"),
        scale_x: 0.8, scale_y: 0.8
      )
    )
    asteroid.add_component(ColliderComponent.new(50))
  end
end

Asteroids.new.show
