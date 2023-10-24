class EndPoints {
  static const String baseURL = "https://pub.dev/api";
  static const String packageBaseUrl = "https://pub.dev/api/packages";
  static String packageSearchURL(String query) => "/search?q=$query";
  static String getPageURL(String query, int pageNumber) =>
      "/${EndPoints.packageSearchURL(query)}&page=$pageNumber";
  static const String packages = "/packages";
  static const String favoritePackages = "/packages?q=is%3Aflutter-favorite";
  static const String popularPackages = "/packages?sort=popularity";
  static const favoritesPageUrl =
      "https://docs.flutter.dev/packages-and-plugins/favorites";
  static String scores(String packageName) => "/$packageName/score";
}
