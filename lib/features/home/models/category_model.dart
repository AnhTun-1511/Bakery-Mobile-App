import 'package:flutter/material.dart';

class CategoryModel {
  final String id;
  final String name;
  final Color color;

  CategoryModel({
    required this.id,
    required this.name,
    required this.color,
  });
  static List<CategoryModel> list = [
    CategoryModel(id: 'bread', name: 'BREAD\nBÁNH MÌ', color: Colors.orange.shade100),
    CategoryModel(id: 'breakfast', name: 'BREAKFAST\nĂN SÁNG', color: Colors.blue.shade100),
    CategoryModel(id: 'mousse', name: 'MOUSSE\nBÁNH KEM', color: Colors.pink.shade100),
    CategoryModel(id: 'cookies', name: 'COOKIES\nBÁNH QUY', color: Colors.brown.shade100),
    CategoryModel(id: 'tart', name: 'TART\nTART NGỌT', color: Colors.purple.shade100),
    CategoryModel(id: 'salty', name: 'SALTY\nBÁNH MẶN', color: Colors.green.shade100),
    CategoryModel(id: 'frozen', name: 'FROZEN\nĐÔNG LẠNH', color: Colors.cyan.shade100),
  ];
}