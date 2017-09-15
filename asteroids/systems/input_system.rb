include Components

module Systems
  class InputSystem < Baku::System
    def initialize
      super([PlayerInputComponent, AccelerationComponent, RotationComponent], :update)
    end

    def process_entity(entity, player_input, acceleration, rotation)
      

      acceleration.magnitude =
        (Gosu.button_down?(Gosu::KB_UP) ? 1 : 0) +
        (Gosu.button_down?(Gosu::KB_DOWN) ? -1 : 0)

      rotation.angle = rotation.angle +
        (Gosu.button_down?(Gosu::KB_LEFT) ? player_input.rotate_speed : 0) +
        (Gosu.button_down?(Gosu::KB_RIGHT) ? -player_input.rotate_speed : 0)
    end
  end
end
