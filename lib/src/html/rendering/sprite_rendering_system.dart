import 'dart:html';

import 'package:dartemis/dartemis.dart';
import 'package:gamedev_helpers/gamedev_helpers.dart';

import '../../components/components.dart';
import '../../core/config.dart';
import '../../core/managers/level_manager.dart';

part 'sprite_rendering_system.g.dart';

@Generate(
  EntityProcessingSystem,
  allOf: [
    Position,
    Renderable,
    Orientation,
  ],
  manager: [
    TagManager,
    CameraManager,
  ],
  exclude: [
    Border,
    Nebula,
  ],
)
class SpriteRenderingSystem extends _$SpriteRenderingSystem {
  double _cameraX = 0, _cameraY = 0;
  CanvasRenderingContext2D ctx;
  SpriteSheet sheet;
  SpriteRenderingSystem(this.ctx, this.sheet);

  @override
  void begin() {
    final camera = tagManager.getEntity(cameraTag);
    if (camera != null) {
      final cameraPosition = positionMapper[camera];
      _cameraX = cameraPosition.x;
      _cameraY = cameraPosition.y;
    }
  }

  @override
  void processEntity(int entity, Position position, Renderable renderable,
      Orientation orientation) {
    final name = renderable.name;
    assert(sheet.sprites.containsKey(name),
        'sprite $name does not exist in ${sheet.sprites.keys.join(', ')}');
    final sprite = sheet.sprites[name]!;

    ctx
      ..save()
      ..translate(
          position.x * tileSize -
              _cameraX * tileSize +
              cameraManager.clientWidth ~/ 2 +
              tileSize / 2,
          position.y * tileSize -
              _cameraY * tileSize +
              cameraManager.clientHeight ~/ 2 +
              tileSize / 2)
      ..rotate(orientation.angle)
      ..drawImageScaledFromSource(
          sheet.image,
          sprite.src.left,
          sprite.src.top,
          sprite.src.width,
          sprite.src.height,
          sprite.dst.left,
          sprite.dst.top,
          sprite.dst.width,
          sprite.dst.height)
      ..restore();
  }
}

@Generate(
  EntitySystem,
  allOf: [
    Position,
    Renderable,
  ],
  manager: [
    LevelManager,
    CameraManager,
    TagManager,
  ],
)
abstract class CachedSpriteRenderingSystem
    extends _$CachedSpriteRenderingSystem {
  late double _cameraX, _cameraY;
  Set<int> _cachedEntities = <int>{};
  late CanvasElement _overlayCanvas;
  CanvasElement? _maskCanvas;

  final CanvasRenderingContext2D ctx;
  final SpriteSheet sheet;
  CachedSpriteRenderingSystem(this.ctx, this.sheet, Aspect aspect)
      : super(aspect);

  @override
  void begin() {
    final camera = tagManager.getEntity(cameraTag);
    if (camera != null) {
      final cameraPosition = positionMapper[camera];
      _cameraX = cameraPosition.x;
      _cameraY = cameraPosition.y;
    }
  }

  void cacheAndprocessEntities(Iterable<int> entities, Sprite sprite) {
    final entitiesSet = entities.toSet();
    if (_cachedEntities.length != entitiesSet.length ||
        !_cachedEntities.containsAll(entitiesSet)) {
      _cachedEntities = entitiesSet;
      final width = levelManager.levelWidth;
      final height = levelManager.levelHeight;
      if (_maskCanvas != null &&
          _maskCanvas!.width == width &&
          _maskCanvas!.height == height) {
        _maskCanvas!.context2D.clearRect(0, 0, width, height);
        _overlayCanvas.context2D
            .clearRect(0, 0, width * tileSize, height * tileSize);
      } else {
        _maskCanvas = CanvasElement(width: width, height: height);
        _overlayCanvas =
            CanvasElement(width: width * tileSize, height: height * tileSize);
      }
      final maskCtx = _maskCanvas!.context2D..fillStyle = 'white';
      final overlayCtx = _overlayCanvas.context2D;
      for (final entity in entitiesSet) {
        final position = positionMapper[entity];
        maskCtx.fillRect(position.x, position.y, 1, 1);

        overlayCtx
          ..save()
          ..translate(position.x * tileSize + tileSize / 2,
              position.y * tileSize + tileSize / 2)
          ..drawImageScaledFromSource(
              sheet.image,
              sprite.src.left,
              sprite.src.top,
              sprite.src.width,
              sprite.src.height,
              sprite.dst.left,
              sprite.dst.top,
              sprite.dst.width,
              sprite.dst.height)
          ..restore();
      }

      _overlayCanvas.context2D
        ..globalCompositeOperation = 'destination-in'
        ..drawImageScaled(
            _maskCanvas!, 0, 0, _overlayCanvas.width!, _overlayCanvas.height!)
        ..globalCompositeOperation = 'source-over';
    }

    ctx
      ..save()
      ..translate(-_cameraX * tileSize + cameraManager.clientWidth ~/ 2,
          -_cameraY * tileSize + cameraManager.clientHeight ~/ 2)
      ..drawImage(_overlayCanvas, 0, 0)
      ..restore();
  }

  @override
  bool checkProcessing() => true;
}

@Generate(
  CachedSpriteRenderingSystem,
  allOf: [
    Border,
  ],
)
class BorderRenderingSystem extends _$BorderRenderingSystem {
  BorderRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet);

  @override
  void processEntities(Iterable<int> entities) {
    cacheAndprocessEntities(entities, sheet['border']);
  }
}

@Generate(
  CachedSpriteRenderingSystem,
  allOf: [
    Nebula,
  ],
)
class NebulaRenderingSystem extends _$NebulaRenderingSystem {
  NebulaRenderingSystem(CanvasRenderingContext2D ctx, SpriteSheet sheet)
      : super(ctx, sheet);

  @override
  void processEntities(Iterable<int> entities) {
    cacheAndprocessEntities(entities, sheet['nebula']);
  }
}
