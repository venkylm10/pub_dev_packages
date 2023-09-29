class EndPoints {
  static String baseURL = "https://pub.dev/api/";
  static String packageSearchURL(String query) =>
      "${EndPoints.baseURL}search?q=$query";

  static String getPageURL(String query, int pageNumber) =>
      "${EndPoints.packageSearchURL(query)}&page=$pageNumber";
  static String packages = "packages";
  static String packageName = "package";
  static String nextPage = "next";
}
