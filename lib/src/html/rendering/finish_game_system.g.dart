// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finish_game_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$FinishGameSystem extends VoidEntitySystem {
  GameTimeSystem gameTimeSystem;
  GameStateManager gameStateManager;
  CameraManager cameraManager;
  @override
  void initialize() {
    super.initialize();
    gameTimeSystem = world.getSystem<GameTimeSystem>();
    gameStateManager = world.getManager<GameStateManager>();
    cameraManager = world.getManager<CameraManager>();
  }
}
