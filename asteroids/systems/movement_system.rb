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

      if acceleration.x != 0 || acceleration.y != 0
        velocity.x = [velocity.x + acceleration.x, player_input.max_velocity].min
        velocity.y = [velocity.y + acceleration.y, player_input.max_velocity].min
      else
        velocity.x *= player_input.friction
        velocity.y *= player_input.friction
      end

      transform.x += velocity.x
      transform.y += velocity.y
    end
  end
end
