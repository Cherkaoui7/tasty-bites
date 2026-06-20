import 'package:flutter/material.dart';

class Address {
  final String id;
  final String title;
  final String address;
  final bool isDefault;
  final IconData icon;

  const Address({
    required this.id,
    required this.title,
    required this.address,
    required this.icon,
    this.isDefault = false,
  });

  Address copyWith({bool? isDefault}) {
    return Address(
      id: id,
      title: title,
      address: address,
      icon: icon,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}
