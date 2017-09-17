module Components
  class RotationComponent
    attr_reader :angle

    def initialize
      @angle = 0
    end

    def set_angle(value)
      @angle = value % 360
    end
  end
end
