class EndPoints {
  static String baseURL = "https://pub.dev/api/";
  static String packageSearchURL(String query) => "search?q=$query";
  static String getPageURL(String query, int pageNumber) =>
      "${EndPoints.packageSearchURL(query)}&page=$pageNumber";
  static String packages = "packages";
  static String favoritePackages = "packages?q=is%3Aflutter-favorite";
  static String popularPackages = "packages?sort=popularity";
  static String packageNameInSearchPage = "package";
  static String nextPage = "next";
}
