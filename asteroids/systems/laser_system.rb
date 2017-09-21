include Components

module Systems
  class LaserSystem < Baku::System
    def initialize
      super([LaserComponent,
             TransformComponent,
             RotationComponent,
             VelocityComponent], :update)
    end

    def process_entity(entity, laser, transform, rotation, velocity)
      if Gosu.button_down?(Gosu::KB_SPACE) && laser.can_shoot_laser?
        spawn_laser(transform, rotation, laser)
        laser.laser_timer = laser.laser_cooldown_ms
      else
        laser.laser_timer = [0, laser.laser_timer - @world.delta_ms].max
      end
    end

    private

    def spawn_laser(transform, rotation, laser)
      angle_radians = rotation.angle * (Math::PI / 180)
      
      entity = @world.create_entity

      spawn_x = transform.x + Math.cos(angle_radians) * laser.laser_spawn_distance
      spawn_y = transform.y + Math.sin(angle_radians) * laser.laser_spawn_distance
      
      entity.add_component(TransformComponent.new(spawn_x, spawn_y, 5))
      entity.add_component(RotationComponent.new(rotation.angle))

      v_x = Math.cos(angle_radians) * laser.laser_velocity
      v_y = Math.sin(angle_radians) * laser.laser_velocity
      entity.add_component(VelocityComponent.new(v_x, v_y, 0))
      
      entity.add_component(SpriteComponent.new(Gosu::Image.new("assets/laser.png")))
      entity.add_component(TimedDestroyComponent.new(laser.laser_lifespan_ms))
    end
  end
end
