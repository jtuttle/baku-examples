include Components

module Systems
  class MovementSystem < Baku::System
    def initialize
      super([PlayerInputComponent,
             TransformComponent,
             VelocityComponent,
             RotationComponent,
             AccelerationComponent], :update)
    end

    def process_entity(entity, player_input, transform, velocity, rotation, acceleration)
      angle = rotation.angle * (Math::PI / 180)

      if Gosu.button_down?(Gosu::KB_UP)
        acceleration.x = Math.cos(angle) * player_input.acceleration_speed
        acceleration.y = Math.sin(angle) * player_input.acceleration_speed
        
        velocity.x = [velocity.x + acceleration.x, player_input.max_velocity].min
        velocity.y = [velocity.y + acceleration.y, player_input.max_velocity].min
      else
        velocity.x *= 0.95
        velocity.y *= 0.95
      end

      transform.x += velocity.x
      transform.y += velocity.y
    end
  end
end
