class BackEndConfig {
  static const String serverAddr = "192.168.1.3:8080";
  static const String fetchImageString = "http://$serverAddr/api/images/name/";
  static const String fetchAllCategoryString = "http://$serverAddr/api/categories";
  static const String fetchAllProductString = "http://$serverAddr/api/products";
  static const String deleteCategoryString = "http://$serverAddr/api/categories/category/";
  static const String fetchAllDiscountString = "http://$serverAddr/api/discounts";
  static const String fetchAllDeliveryMen = "http://$serverAddr/api/deliverymen";
  static const String insertDeliveryMan = "http://$serverAddr/api/deliverymen";
}