import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../globals/endpoints.dart';

final apiServicesProvider = Provider((ref) {
  return APIServices();
});

class APIServices {
  final dio = Dio(BaseOptions(baseUrl: EndPoints.baseURL));

  Future<Map<String, dynamic>> getQueryPage(
      String packageName, int index) async {
    final response = await dio.get(EndPoints.getPageURL(packageName, index));
    if (response.statusCode == 200) {
      return response.data;
    } else {
      return {};
    }
  }
}
