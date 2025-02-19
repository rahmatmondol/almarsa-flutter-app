class Urls {
  static final String _baseUrl = "http://app.almarsa-gourmet.com/public/api/v1";

  static String loginUrl = "$_baseUrl/login";

  static String signUpUrl = "$_baseUrl/register";

  static String contactUrl = "$_baseUrl/contact";

  static String myProfileInfoUrl = "$_baseUrl/auth/me";

  static String updateProfileUrl = "$_baseUrl/auth/update-profile";

  static String drawerList = "$_baseUrl/categories";

  static String homeCategory = "$_baseUrl/home";

  static String mainShop = "$_baseUrl/shop";

  static String wishListUrl = "$_baseUrl/auth/wishlist";

  // static String wishListRemoveUrl = "$_baseUrl/auth/wishlist/1";

  static String addToBasketUrl = "$_baseUrl/auth/cart";

  static String productsListUnderCategory(int id) => "$_baseUrl/category/$id";

  static String productsDetails(String id) => "$_baseUrl/product/$id";

  static String search() => "$_baseUrl/product-search";

  static String removeFromCart({required id}) => "$_baseUrl/auth/cart/$id";

  static String removeFromWishList({required id}) =>
      "$_baseUrl/auth/wishlist/$id";

  static String getWishListUrl = "$_baseUrl/auth/wishlists";

  static String getCartListUrl = "$_baseUrl/auth/carts";

  static String forgetPasswordUrl = "$_baseUrl/forget-password";

  static String resetPasswordUrl = "$_baseUrl/reset-password";

  static String changePasswordUrl = "$_baseUrl/auth/change-password";
}
