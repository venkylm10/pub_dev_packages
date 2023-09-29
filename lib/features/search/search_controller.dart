import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/models/packages_page_model.dart';
import 'package:pub_dev_packages/services/api.dart';

import '../../models/package_model.dart';

final searchControllerProvider =
    StateNotifierProvider<SearchController, bool>((ref) {
  return SearchController(
    apiServices: ref.watch(apiServicesProvider),
    ref: ref,
  );
});

class SearchController extends StateNotifier<bool> {
  final APIServices _apiServices;
  final Ref _ref;

  SearchController({
    required APIServices apiServices,
    required Ref ref,
  })  : _apiServices = apiServices,
        _ref = ref,
        super(false);

  bool nextPageAvailable = true;

  Future<List<Package>> getPage(String packageName, int pageNo) async {
    final pageData = await _apiServices.getQueryPage(
      packageName,
      pageNo,
    );
    final page = PackageList.fromMap(pageData);
    if (page.packages.length < 10) {
      nextPageAvailable = false;
    }

    return page.packages;
  }
}
