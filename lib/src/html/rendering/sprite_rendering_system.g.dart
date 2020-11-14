// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite_rendering_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$SpriteRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> positionMapper;
  Mapper<Renderable> renderableMapper;
  TagManager tagManager;
  CameraManager cameraManager;
  _$SpriteRenderingSystem()
      : super(Aspect.empty()..allOf([Position, Renderable]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    renderableMapper = Mapper<Renderable>(world);
    tagManager = world.getManager<TagManager>();
    cameraManager = world.getManager<CameraManager>();
  }
}
