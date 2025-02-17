// class Urls {
//   static final String _baseUrl =
//       "http://app.almarsa-gourmet.com/public/api/v1/";
//
//   static String loginUrl() => "${_baseUrl}login";
//
//   static String signUpUrl() => "${_baseUrl}register";
//
//   static String contactUrl() => "${_baseUrl}contact";
//
//   static String myProfileInfoUrl() => "${_baseUrl}auth/me";
//
//
// }

class Urls {
  static final String _baseUrl = "http://app.almarsa-gourmet.com/public/api/v1";

  static String loginUrl = "$_baseUrl/login";

  static String signUpUrl = "$_baseUrl/register";

  static String contactUrl = "$_baseUrl/contact";

  static String myProfileInfoUrl = "$_baseUrl/auth/me";

  static String updateProfileUrl = "$_baseUrl/auth/update-profile";

  static String drawerList = "$_baseUrl/categories";

  static String homeCategory = "$_baseUrl/home";

  static String wishListUrl = "$_baseUrl/auth/wishlist";

  // static String wishListRemoveUrl = "$_baseUrl/auth/wishlist/1";

  static String addToBasketUrl = "$_baseUrl/auth/cart";

  static String productsListUnderCategory(int id) => "$_baseUrl/category/$id";

  static String productsDetails(String id) => "$_baseUrl/product/$id";
}
