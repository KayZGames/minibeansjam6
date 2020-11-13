// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_rendering_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$PositionRenderingSystem extends EntityProcessingSystem {
  Mapper<Position> positionMapper;
  CameraManager cameraManager;
  _$PositionRenderingSystem() : super(Aspect.empty()..allOf([Position]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    cameraManager = world.getManager<CameraManager>();
  }
}
