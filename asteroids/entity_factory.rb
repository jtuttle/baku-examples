class EntityFactory
  class << self
    def create_player(world)
      player = world.create_entity
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
    
    def create_asteroid(world, size, x, y)
      asteroid = world.create_entity
      asteroid.add_component(TransformComponent.new(x, y, 10))
      asteroid.add_component(RotationComponent.new(0))
      asteroid.add_component(
        VelocityComponent.new(
          rand(-2.0...2.0),
          rand(-2.0...2.0),
          rand(-1.0...1.0)
        )
      )

      asteroid.add_component(AsteroidComponent.new(size))

      scale =
        case size
        when 1
          0.2
        when 2
          0.5
        when 3
          0.8
        end
      
      asteroid.add_component(
        SpriteComponent.new(
          Gosu::Image.new("assets/asteroid.png"),
          scale_x: scale, scale_y: scale
        )
      )

      radius =
        case size
        when 1
          12.5
        when 2
          31.25
        when 3
          50
        end
      
      asteroid.add_component(ColliderComponent.new(radius))
    end

    def create_laser(world, transform, rotation, laser)
      angle_radians = rotation.angle * (Math::PI / 180)
      
      entity = world.create_entity([:laser])

      spawn_x = transform.x + Math.cos(angle_radians) * laser.laser_spawn_distance
      spawn_y = transform.y + Math.sin(angle_radians) * laser.laser_spawn_distance
      
      entity.add_component(TransformComponent.new(spawn_x, spawn_y, 5))
      entity.add_component(RotationComponent.new(rotation.angle))

      v_x = Math.cos(angle_radians) * laser.laser_velocity
      v_y = Math.sin(angle_radians) * laser.laser_velocity
      entity.add_component(VelocityComponent.new(v_x, v_y, 0))
      
      entity.add_component(SpriteComponent.new(Gosu::Image.new("assets/laser.png")))
      entity.add_component(TimedDestroyComponent.new(laser.laser_lifespan_ms))

      entity.add_component(ColliderComponent.new(10))
    end
  end
end
