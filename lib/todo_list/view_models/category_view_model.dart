import 'package:flutter/material.dart';

class CategoryViewModel extends ChangeNotifier {
  String _selectedCategory = '';
  bool _categoryFieldSelected = false;
  bool _addCategory = false;


  // getters
  String get selectedCategory => _selectedCategory;
  bool get categoryFieldSelected => _categoryFieldSelected;
  bool get addCategory => _addCategory;


  // setters
  void setSelectedCategory(String name) {
    _selectedCategory = name;
    _addCategory = false;
    notifyListeners();
  }

  void setAddCategory() {
    _addCategory = !_addCategory;
    notifyListeners();
  }

  void toggleCategoryFieldSelected() {
    _categoryFieldSelected = !_categoryFieldSelected;
    notifyListeners();
  }

  void setCategoryFieldSelected() {
    _categoryFieldSelected = false;
    notifyListeners();
  }
}