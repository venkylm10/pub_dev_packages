import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/models/package_model/matrics/score.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';
import 'package:pub_dev_packages/services/api.dart';

final favPackagesProvider = StateNotifierProvider<FavPackageController, bool>(
    (ref) => FavPackageController(ref: ref));

class FavPackageController extends StateNotifier<bool> {
  final Ref _ref;
  FavPackageController({required Ref ref})
      : _ref = ref,
        super(true);
  var favScores = <Score>[];
  var favoritePackages = <Package>[];

  Future<void> getFavorites() async {
    favoritePackages = await _ref.read(apiServicesProvider).getFavourites();
    favScores = favoritePackages.map((package) {
      return Score.fromJson(dummyScore);
    }).toList();
  }

  Future<void> getScores() async {
    for (int i = 0; i < favoritePackages.length; i++) {
      if (favScores.length > 3 && i == 3) {
        state = false;
      } else if (i == favScores.length - 1) {
        state = false;
      }
      final score = await _ref
          .read(apiServicesProvider)
          .getScore(favoritePackages[i].name);
      favScores[i] = score;
    }
  }
}
