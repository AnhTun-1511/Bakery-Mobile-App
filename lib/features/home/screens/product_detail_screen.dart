import 'package:flutter/material.dart';
import 'package:bakery_mobile_app/core/constants/app_colors.dart';
import 'package:bakery_mobile_app/features/home/models/product_model.dart';
import 'package:bakery_mobile_app/features/cart/models/cart_manager.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int quantity = 1; // Quản lý số lượng đặt hàng

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // 1. ẢNH BÁNH FULL (Nền phía trên)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45, // Chiếm 45% màn hình
            child: Image.asset(
              widget.product.imagePath,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(color: Colors.orange.shade100),
            ),
          ),

          // 2. NÚT BACK (Quay lại)
          Positioned(
            top: 40,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ),

          // 3. THÔNG TIN CHI TIẾT (Trượt từ dưới lên)
          Positioned.fill(
            top: MediaQuery.of(context).size.height * 0.4,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Tên bánh
                  Text(
                    widget.product.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),

                  // Giá tiền
                  Text(
                    "${widget.product.price.toStringAsFixed(0)} đ",
                    style: const TextStyle(fontSize: 20, color: AppColors.primary, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Mô tả
                  const Text(
                    "Mô tả",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Bánh tươi trong ngày. Vỏ bánh giòn tan kết hợp cùng lớp nhân mềm mịn, mang lại hương vị khó quên.",
                    style: TextStyle(color: Colors.grey[600], height: 1.5),
                  ),

                  const Spacer(), // Đẩy phần dưới xuống đáy

                  // 4. THANH TÁC VỤ (Số lượng + Nút mua)
                  Row(
                    children: [
                      // Nút Giảm
                      _buildQuantityButton(Icons.remove, () {
                        if (quantity > 1) setState(() => quantity--);
                      }),
                      
                      // Số lượng
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "$quantity",
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),

                      // Nút Tăng
                      _buildQuantityButton(Icons.add, () {
                        setState(() => quantity++);
                      }),

                      const SizedBox(width: 20),

                      // Nút THÊM VÀO GIỎ
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Gọi hàm thêm vào giỏ
                            CartManager().addToCart(widget.product, quantity);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green,
                                content: Text("Đã thêm $quantity ${widget.product.name} vào giỏ!"),
                                ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          child: const Text(
                            "Thêm vào giỏ",
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget con: Nút cộng trừ
  Widget _buildQuantityButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(10),
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87),
        onPressed: onPressed,
      ),
    );
  }
}