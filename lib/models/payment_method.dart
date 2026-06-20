import 'package:flutter/material.dart';

class PaymentMethod {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isDefault;

  const PaymentMethod({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.isDefault = false,
  });

  PaymentMethod copyWith({bool? isDefault}) {
    return PaymentMethod(
      id: id,
      title: title,
      subtitle: subtitle,
      icon: icon,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
