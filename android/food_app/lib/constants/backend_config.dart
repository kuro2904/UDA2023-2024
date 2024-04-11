class BackEndConfig {
  static const String serverAddr = "192.168.1.141:8080";

  // static const String serverAddr = "192.168.43.1:8081";
  static const String fetchImageString = "http://$serverAddr/api/images/name/";
  static const String fetchAllProductString = "http://$serverAddr/api/products";
  static const String insertProductString = "http://$serverAddr/api/products";
  static const String updateProductString =
      "http://$serverAddr/api/products/product/";
  static const String getProductString =
      "http://$serverAddr/api/products/product/";
  static const String getProductByCategory =
      "http://$serverAddr/api/products/category/";
  static const String fetchAllCategoryString =
      "http://$serverAddr/api/categories";
  static const String insertCategoryString =
      "http://$serverAddr/api/categories";
  static const String deleteCategoryString =
      "http://$serverAddr/api/categories/category/";
  static const String updateCategoryString =
      "http://$serverAddr/api/categories/category/";
  static const String getCategoryString =
      "http://$serverAddr/api/categories/category/";
  static const String fetchAllDiscountString =
      "http://$serverAddr/api/discounts";
  static const String insertDiscountString = "http://$serverAddr/api/discounts";
  static const String fetchAllDeliveryMenString =
      "http://$serverAddr/api/deliverymen";
  static const String insertDeliveryManString =
      "http://$serverAddr/api/deliverymen";
  static const String updateDeliveryManString =
      "http://$serverAddr/api/deliverymen/man/";
  static const String deleteDeliveryManString =
      "http://$serverAddr/api/deliverymen/man/";
  static const String getDeliveryManString =
      "http://$serverAddr/api/deliverymen/man/";
  static const String signUpString = "http://$serverAddr/api/auth/register";
  static const String loginString = "http://$serverAddr/api/auth/login";
  static const String signUpAdminString =
      "http://$serverAddr/api/auth/super-user/register";
  static const String placeOrderString = "http://$serverAddr/api/orders";
  static const String fetchHistoryOrder = "http://$serverAddr/api/orders/user/";
}
