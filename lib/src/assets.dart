import 'package:asset_data/asset_data.dart';

part 'assets.g.dart';

@Asset('asset:minibeansjam6/assets/level')
const levels = DirAsset<TextAsset, Levels>(_levels$asset);

@Asset('asset:minibeansjam6/assets/sfx')
const sfx = DirAsset<BinaryAsset, Sfx>(_sfx$asset);

@Asset('asset:minibeansjam6/assets/img/assets.png')
const spriteSheetImg = BinaryAsset(_spriteSheetImg$asset);

@Asset('asset:minibeansjam6/assets/img/assets.json')
const spriteSheetJson = JsonAsset(_spriteSheetJson$asset);