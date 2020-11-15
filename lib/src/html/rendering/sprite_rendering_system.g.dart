// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sprite_rendering_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$SpriteRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> positionMapper;
  Mapper<Renderable> renderableMapper;
  Mapper<Orientation> orientationMapper;
  TagManager tagManager;
  CameraManager cameraManager;
  _$SpriteRenderingSystem()
      : super(Aspect.empty()
          ..allOf([Position, Renderable, Orientation])
          ..exclude([Border, Nebula]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    renderableMapper = Mapper<Renderable>(world);
    orientationMapper = Mapper<Orientation>(world);
    tagManager = world.getManager<TagManager>();
    cameraManager = world.getManager<CameraManager>();
  }
}

abstract class _$CachedSpriteRenderingSystem extends EntitySystem {
  Mapper<Position> positionMapper;
  Mapper<Renderable> renderableMapper;
  LevelManager levelManager;
  CameraManager cameraManager;
  TagManager tagManager;
  _$CachedSpriteRenderingSystem(Aspect aspect)
      : super(aspect..allOf([Position, Renderable]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    renderableMapper = Mapper<Renderable>(world);
    levelManager = world.getManager<LevelManager>();
    cameraManager = world.getManager<CameraManager>();
    tagManager = world.getManager<TagManager>();
  }
}

abstract class _$BorderRenderingSystem extends CachedSpriteRenderingSystem {
  Mapper<Border> borderMapper;
  _$BorderRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet, Aspect.empty()..allOf([Border]));
  @override
  void initialize() {
    super.initialize();
    borderMapper = Mapper<Border>(world);
  }
}

abstract class _$NebulaRenderingSystem extends CachedSpriteRenderingSystem {
  Mapper<Nebula> nebulaMapper;
  _$NebulaRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet, Aspect.empty()..allOf([Nebula]));
  @override
  void initialize() {
    super.initialize();
    nebulaMapper = Mapper<Nebula>(world);
  }
}
