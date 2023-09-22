class ProductModel {
  final String name;
  final String imageUrl;
  final int availableQuantity;
  final double cost;

  ProductModel({
    required this.name,
    required this.imageUrl,
    required this.availableQuantity,
    required this.cost,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      name: json['name'],
      imageUrl: json['imageUrl'],
      availableQuantity: json['availableQuantity'],
      cost: json['cost'].toDouble(),
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'availableQuantity': availableQuantity,
      'cost': cost,
    };
  }
}
