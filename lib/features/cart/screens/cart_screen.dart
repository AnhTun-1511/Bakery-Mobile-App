import 'package:flutter/material.dart';
import 'package:bakery_mobile_app/core/constants/app_colors.dart';
import 'package:bakery_mobile_app/features/cart/models/cart_manager.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartManager _cartManager = CartManager();
  
  // Biến lưu phương thức thanh toán đang chọn
  String _selectedPayment = 'Tiền mặt';
  
  //  Danh sách các phương thức
  final List<String> _paymentMethods = [
    'Tiền mặt',
    'Ví Momo',
    'ZaloPay',
    'Chuyển khoản Ngân hàng',
    'Thẻ tín dụng (Visa/Master)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text("Giỏ hàng", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: _cartManager.items.isEmpty
          ? _buildEmptyCart()
          : Column(
              children: [
                // DANH SÁCH MÓN HÀNG
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _cartManager.items.length,
                    itemBuilder: (context, index) {
                      final item = _cartManager.items[index];
                      return _buildCartItem(item);
                    },
                  ),
                ),
                // PHẦN THANH TOÁN 
                _buildBottomCheckout(),
              ],
            ),
    );
  }

  Widget _buildEmptyCart() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text("Giỏ hàng đang trống trơn!", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildCartItem(CartItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 5)],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              item.product.imagePath,
              width: 70, height: 70, fit: BoxFit.cover,
              errorBuilder: (_,__,___) => Container(width: 70, height: 70, color: Colors.grey[200]),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text("${item.product.price.toStringAsFixed(0)} đ", style: const TextStyle(color: AppColors.primary)),
              ],
            ),
          ),
          Column(
            children: [
              Text("x${item.quantity}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () {
                  setState(() {
                    _cartManager.removeFromCart(item.product.id);
                  });
                },
              )
            ],
          )
        ],
      ),
    );
  }

  // GIAO DIỆN THANH TOÁN
  Widget _buildBottomCheckout() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -5))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Dropdown chọn phương thức thanh toán dạng combo box
          const Text("Phương thức thanh toán:", style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedPayment,
                isExpanded: true, // Để nó dài full chiều ngang
                items: _paymentMethods.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Row(
                      children: [
                        const Icon(Icons.payment, size: 20, color: AppColors.primary),
                        const SizedBox(width: 10),
                        Text(method),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedPayment = newValue!;
                  });
                },
              ),
            ),
          ),
          
          const SizedBox(height: 20),

          //   Tổng tiền
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Tổng cộng:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              Text(
                "${_cartManager.grandTotal.toStringAsFixed(0)} đ",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
            ],
          ),
          
          const SizedBox(height: 16),

          //   Nút Thanh Toán
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                _showSuccessDialog(); // Gọi hàm hiện thông báo
              },
              child: const Text("XÁC NHẬN THANH TOÁN", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // Hàm hiện thông báo thành công
  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, // Bắt buộc bấm nút Đóng mới tắt được
      builder: (context) {
        return AlertDialog(
          title: const Icon(Icons.check_circle, color: Colors.green, size: 60),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Thanh toán thành công!",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text("Bạn đã thanh toán ${_cartManager.grandTotal.toStringAsFixed(0)}đ"),
              Text("Qua cổng: $_selectedPayment"),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                //Đóng dialog
                Navigator.pop(context);
                // giỏ hàng
                setState(() {
                  _cartManager.clearCart(); 
                });
                
                //Quay về trang chủ
                Navigator.pop(context); 
              },
              child: const Text("VỀ TRANG CHỦ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }
}