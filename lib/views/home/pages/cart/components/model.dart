class CartResponseModel {
  late final List<CartItemModel> items;
  late final num total;

  CartResponseModel.fromJson(Map<String, dynamic> json) {
    items = List.from(
      json['items'] ?? [],
    ).map((e) => CartItemModel.fromJson(e)).toList();
    total = json['total'] ?? 0;
  }
}

class CartItemModel {
  late final int productId, quantity;
  late final String title, imageUrl;
  late final num price;

  CartItemModel.fromJson(Map<String, dynamic> json) {
    productId = json['productId'] ?? 0;
    title =
        json['productName'] ?? "ARTDECO";
    imageUrl = json['imageUrl'] ?? "";
    price = json['price'] ?? 0;
    quantity = json['quantity'] ?? 1;
  }
}
