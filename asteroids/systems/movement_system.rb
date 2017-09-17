include Components

module Systems
  class MovementSystem < Baku::System
    def initialize
      super([PlayerInputComponent,
             TransformComponent,
             VelocityComponent,
             RotationComponent], :update)
    end

    def process_entity(entity, player_input, transform, velocity, rotation)
      rotation.set_angle(rotation.angle + velocity.rotational)
      
      angle = rotation.angle * (Math::PI / 180)

      if player_input.accelerating
        v_x = Math.cos(angle) * player_input.acceleration_speed
        v_y = Math.sin(angle) * player_input.acceleration_speed

        velocity.x = [velocity.x + v_x, player_input.max_velocity].min
        velocity.y = [velocity.y + v_y, player_input.max_velocity].min
      else
        velocity.x *= player_input.friction
        velocity.y *= player_input.friction
      end

      transform.x += velocity.x
      transform.y += velocity.y
    end
  end
end
