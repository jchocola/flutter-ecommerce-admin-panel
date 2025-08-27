

enum OrderStatus { placed , processing, shipped, delivered, cancelled}
OrderStatus orderStatusFromString(String status) {
  return OrderStatus.values.firstWhere(
    (e) => e.name == status,
    orElse: () => OrderStatus.placed,
  );
}

// 1. Define enum

// 2. Extension to show user-friendly names

enum MediaCategory {
  folders,
  banners,
  brands,
  categories,
  products,
  users
}

enum TransactionType {
  buy, sell
}

enum ProductType {
  single,
  variable
}

enum ProductVisibilty {
  publsihed,
  hidden
}
