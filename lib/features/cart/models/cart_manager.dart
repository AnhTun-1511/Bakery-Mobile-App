// File: lib/features/cart/models/cart_manager.dart
import 'package:bakery_mobile_app/features/home/models/product_model.dart';

// 
class CartItem {
  final ProductModel product; 
  int quantity; // số lượng bánh trong giỏ hàng

  CartItem({required this.product, this.quantity = 1});

  // tính tiền của riêng món này :Giá x Số lượng
  double get totalPrice => product.price * quantity;
}

//  class quản lý giỏ hàng - cái này dùng chung cho toàn bộ ứng dụng
class CartManager {
  // tạo cái  Singleton này để đảm bảo chỉ có 1 giỏ hàng duy nhất trong app
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  // ds các món đã chọn
  final List<CartItem> items = [];

  // Hàm thêm bánh vào giỏ
  void addToCart(ProductModel product, int quantity) {
    // Kiểm tra xem bánh này đã có trong giỏ chưa
    for (var item in items) {
      if (item.product.id == product.id) {
        // Nếu có rồi thì chỉ cần cộng thêm số lượng
        item.quantity += quantity;
        return;
      }
    }
    // Nếu chưa có thì thêm mới vào danh sách
    items.add(CartItem(product: product, quantity: quantity));
  }

  // Hàm xóa bánh khỏi giỏ hàng
  void removeFromCart(String productId) {
    items.removeWhere((item) => item.product.id == productId);
  }

  // tính tổng tiền cả giỏ hàng
  double get grandTotal {
    double total = 0;
    for (var item in items) {
      total += item.totalPrice;
    }
    return total;
  }
  // hàm xoá tất cả sản phẩm sau khi thanh toán xong
  void clearCart(){
    items.clear();
  }
}