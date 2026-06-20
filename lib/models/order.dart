enum OrderStatus {
  preparing,
  delivering,
  confirmed
}

class Order {
  final String id;
  final String date;
  final double total;
  final OrderStatus status;

  const Order({
    required this.id,
    required this.date,
    required this.total,
    this.status = OrderStatus.preparing,
  });

  Order copyWith({OrderStatus? status}) {
    return Order(
      id: id,
      date: date,
      total: total,
      status: status ?? this.status,
    );
  }
}
