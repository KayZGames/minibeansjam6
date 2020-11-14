// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'next_level_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$NextLevelSystem extends EntityProcessingSystem {
  Mapper<Controller> controllerMapper;
  LevelManager levelManager;
  _$NextLevelSystem() : super(Aspect.empty()..allOf([Controller]));
  @override
  void initialize() {
    super.initialize();
    controllerMapper = Mapper<Controller>(world);
    levelManager = world.getManager<LevelManager>();
  }
}
