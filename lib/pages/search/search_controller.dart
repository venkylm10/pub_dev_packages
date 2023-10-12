import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/models/package_model/query_packages_page_model.dart';
import 'package:pub_dev_packages/services/api.dart';

import '../../models/package_model/query_package_model.dart';

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

  Future<List<QueryPackage>> getPage(String packageName, int pageNo) async {
    var page = QueryPackageList(packages: []);
    try {
      final pageData = await _apiServices.getQueryPage(
        packageName,
        pageNo,
      );
      page = QueryPackageList.fromMap(pageData);
      if (page.packages.length < 10) {
        nextPageAvailable = false;
      }
    } catch (e) {
      print(e.toString());
    }
    return page.packages;
  }
}
