include Components

module Systems
  class SpriteRenderSystem < Baku::System
    def initialize
      super([SpriteComponent, TransformComponent, RotationComponent], :draw)
    end

    def process_entity(entity, sprite, transform, rotation)
      sprite.texture.draw_rot(transform.x, transform.y, 0,
                              rotation.angle,
                              sprite.center_x, sprite.center_y,
                              sprite.scale_x, sprite.scale_y)
    end
  end
end
