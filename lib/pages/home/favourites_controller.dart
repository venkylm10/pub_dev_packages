import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';
import 'package:pub_dev_packages/services/api.dart';

final favPackagesProvider = Provider((ref) => FavPackageController(ref: ref));

class FavPackageController {
  final Ref _ref;
  FavPackageController({required Ref ref}) : _ref = ref;
  var favScores = <Score>[];
  var favoritePackages = <Package>[];

  Future<void> getFavorites() async {
    favoritePackages = await _ref.read(apiServicesProvider).getFavourites();
    for (var i in favoritePackages) {
      favScores.add(Score.fromJson(dummyScore));
    }
  }

  Future<void> getScores() async {
    for (int i = 0; i < favoritePackages.length; i++) {
      final score = await _ref
          .read(apiServicesProvider)
          .getScore(favoritePackages[i].name);
      favScores[i] = score;
    }
  }
}
