class Urls {
  static final String _baseUrl =
      "http://app.almarsa-gourmet.com/public/api/v1/";

  static String loginUrl() => "${_baseUrl}login";

  static String signUpUrl() => "${_baseUrl}register";

  static String contactUrl() => "${_baseUrl}contact";

  static String myProfileInfoUrl() => "${_baseUrl}auth/me";

  static String updateProfileUrl() => "${_baseUrl}auth/update-profile";
}
