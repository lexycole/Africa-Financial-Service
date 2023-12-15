class CreateProductModel {
  final String label;
  final int price;
  final String description;
  final int quantity;
  final String link;
  final String seller_uid;

  CreateProductModel({
    required this.label,
    required this.price,
    required this.description,
    required this.quantity,
    required this.link,
    required this.seller_uid,
  });
}
