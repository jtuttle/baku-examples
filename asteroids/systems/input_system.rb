include Components

module Systems
  class InputSystem < Baku::System
    def initialize
      super([PlayerInputComponent, AccelerationComponent, RotationComponent], :update)
    end

    def process_entity(entity, player_input, acceleration, rotation)
      rotation.set_angle(
        rotation.angle +
        (Gosu.button_down?(Gosu::KB_LEFT) ? -player_input.rotation_speed : 0) +
        (Gosu.button_down?(Gosu::KB_RIGHT) ? player_input.rotation_speed : 0)
      )

      angle = rotation.angle * (Math::PI / 180)

      if Gosu.button_down?(Gosu::KB_UP)
        acceleration.x = Math.cos(angle) * player_input.acceleration_speed
        acceleration.y = Math.sin(angle) * player_input.acceleration_speed
      else
        acceleration.x = 0
        acceleration.y = 0
      end
    end
  end
end
