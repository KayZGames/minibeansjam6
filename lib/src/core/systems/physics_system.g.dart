// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'physics_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$CanFallPhysicsSystem extends EntityProcessingSystem {
  Mapper<Position> positionMapper;
  Mapper<CanFall> canFallMapper;
  LevelManager levelManager;
  _$CanFallPhysicsSystem() : super(Aspect.empty()..allOf([Position, CanFall]));
  @override
  void initialize() {
    super.initialize();
    positionMapper = Mapper<Position>(world);
    canFallMapper = Mapper<CanFall>(world);
    levelManager = world.getManager<LevelManager>();
  }
}
