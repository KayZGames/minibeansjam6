// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_loading_system.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$LevelLoadingSystem extends VoidEntitySystem {
  late final TagManager tagManager;
  late final LevelManager levelManager;
  @override
  void initialize() {
    super.initialize();
    tagManager = world.getManager<TagManager>();
    levelManager = world.getManager<LevelManager>();
  }
}
