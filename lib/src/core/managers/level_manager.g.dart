// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_manager.dart';

// **************************************************************************
// SystemGenerator
// **************************************************************************

abstract class _$LevelManager extends Manager {
  Mapper<CanBeRolledOn> canBeRolledOnMapper;
  Mapper<CanRoll> canRollMapper;
  Mapper<CanFall> canFallMapper;
  @override
  void initialize() {
    super.initialize();
    canBeRolledOnMapper = Mapper<CanBeRolledOn>(world);
    canRollMapper = Mapper<CanRoll>(world);
    canFallMapper = Mapper<CanFall>(world);
  }
}
