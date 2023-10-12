import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pub_dev_packages/constants/model_constants.dart';
import 'package:pub_dev_packages/models/package_model/package_model.dart';
import '../globals/endpoints.dart';

final apiServicesProvider = Provider((ref) {
  return APIServices();
});

class APIServices {
  final dio = Dio(BaseOptions(baseUrl: EndPoints.baseURL));

  Future<Map<String, dynamic>> getQueryPage(
      String packageName, int index) async {
    try {
      final response = await dio.get(EndPoints.getPageURL(packageName, index));
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return {};
      }
    } on PlatformException catch (e) {
      if (e.code == 'SOCKET_EXCEPTION') {
        print("Host lookup error: ${e.message}");
      } else {
        print("Platform exception: $e");
      }
      return {};
    } catch (e) {
      print(e.toString());
      return {};
    }
  }

  Future<List<Package>> getFavourites() async {
    try {
      final response = await dio.get(EndPoints.favoritePackages);
      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final packagesJson = data['packages'] as List<dynamic>;
        final popularPackages = packagesJson.map((packageJson) {
          return Package.fromJson(packageJson as Map<String, dynamic>);
        }).toList();

        return popularPackages;
      } else {
        return <Package>[];
      }
    } on PlatformException catch (e) {
      if (e.code == 'SOCKET_EXCEPTION') {
        print("Host lookup error: ${e.message}");
      } else {
        print("Platform exception: $e");
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  Map<String, dynamic> formatMetricJson(Map<String, dynamic> json) {
    Map<String, dynamic> formattedJson = finalMetricJson;
    print((json['score'] as Map<String, dynamic>).keys);
    for (var key in (json['score'] as Map<String, dynamic>).keys) {
      if (key == 'tags') {
        formattedJson['tags'] = json['score'][key] as List<String>;
        continue;
      }
      formattedJson['score'][key] = json['score'][key];
    }

    formattedJson['packageVersion'] =
        json['scorecard']['packageVersion'] as String;
    formattedJson['runtimeVersion'] =
        json['scorecard']['runtimeVersion'] as String;
    formattedJson['sdkVersion'] = json['scorecard']['panaReport']
        ['panaRuntimeInfo']['sdkVersion'] as String;
    formattedJson['flutterVersions'] = json['scorecard']['panaReport']
        ['panaRuntimeInfo']['flutterVersions'] as Map<String, dynamic>;
    formattedJson['result'] =
        json['scorecard']['panaReport']['result'] as Map<String, dynamic>;

    formattedJson['report'] =
        json['scorecard']['panaReport']['report']['sections'] as List<dynamic>;

    return formattedJson;
  }
}
