enum ItemCategory {
  food,
  product,
  service,
  item;

  String get name {
    switch (this) {
      case food:
        return 'Comida';
      case product:
        return 'Produto';
      case service:
        return 'Serviço';
      default:
        return 'Item';
    }
  }
}
