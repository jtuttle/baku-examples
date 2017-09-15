module Components
  class SpriteComponent
    attr_reader :texture

    def initialize(texture)
      @texture = texture
    end
  end
end
