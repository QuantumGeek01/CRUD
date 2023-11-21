class ProductDetails {
  final String id, productName, productCode, image, unitPrice, qty, totalPrice;

  ProductDetails(this.id, this.productName, this.productCode, this.image,
      this.unitPrice, this.qty, this.totalPrice);

  factory ProductDetails.toAdd(Map<String, dynamic> e) {
    return ProductDetails(e['_id'], e['ProductName'], e['ProductCode'],
        e['Img'], e['UnitPrice'], e['Qty'], e['TotalPrice']);
  }
}
