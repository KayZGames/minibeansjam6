// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_status_rendering_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$LevelStatusRenderingSystem extends VoidEntitySystem {
  LevelManager levelManager;
  CameraManager cameraManager;
  @override
  void initialize() {
    super.initialize();
    levelManager = world.getManager<LevelManager>();
    cameraManager = world.getManager<CameraManager>();
  }
}
