import 'package:flutter/material.dart';
import 'package:bakery_mobile_app/core/constants/app_colors.dart';
import 'package:bakery_mobile_app/features/home/models/category_model.dart';
import 'package:bakery_mobile_app/features/home/models/product_model.dart';
import 'package:bakery_mobile_app/features/home/screens/product_list_screen.dart';
import 'package:bakery_mobile_app/features/home/screens/product_detail_screen.dart';
import 'package:bakery_mobile_app/features/cart/screens/cart_screen.dart';

// CHUYỂN THÀNH STATEFULWIDGET ĐỂ CÓ THỂ CẬP NHẬT GIAO DIỆN KHI GÕ
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Tạo 1 ds để hiển thị (lúc đầu sẽ chứa tất cả bánh)
  List<ProductModel> _foundProducts = [];

  @override
  void initState() {
    // khởi tạo: Nạp tất cả bánh vào danh sách hiển thị
    _foundProducts = ProductModel.list;
    super.initState();
  }

  //  Hàm xử lý logic tìm kiếm
  void _runFilter(String enteredKeyword) {
    List<ProductModel> results = [];
    if (enteredKeyword.isEmpty) {
      // Nếu xóa hết chữ thì hiện lại tất cả
      results = ProductModel.list;
    } else {
      // Nếu có chữ thì lọc theo tên
      results = ProductModel.search(enteredKeyword);
    }

    // Cập nhật lại giao diện (setState)
    setState(() {
      _foundProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text("Xin chào,", style: TextStyle(fontSize: 14, color: Colors.grey)),
            Text("Bạn muốn ăn gì?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.textMain)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: Colors.orange.shade50, shape: BoxShape.circle),
            child: IconButton(
              icon: const Icon(Icons.shopping_bag_outlined, color: AppColors.primary),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CartScreen()),
                );
              },
            ),
          )
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // THANH TÌM KIẾM

              TextField(
                onChanged: (value) => _runFilter(value), // hàm lọc khi gõ
                decoration: InputDecoration(
                  hintText: "Tìm kiếm bánh ngọt...",
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: 24),

              // Danh mục
              const Text("Danh mục", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: CategoryModel.list.length,
                  itemBuilder: (context, index) {
                    final category = CategoryModel.list[index];
                    return _buildCategoryItem(context, category);
                  },
                ),
              ),
              const SizedBox(height: 24),

              //DANH SÁCH BÁNH (HIỂN THỊ THEO BIẾN _foundProducts) ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Bánh ngon mỗi ngày", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  // Hiển thị số lượng kết quả tìm được cho chuyên nghiệp
                  Text(
                    "${_foundProducts.length} kết quả", 
                    style: const TextStyle(color: Colors.grey, fontSize: 12)
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              _foundProducts.isEmpty
                  ? const Center(child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Text("Không tìm thấy bánh nào cả :(", style: TextStyle(color: Colors.grey)),
                    ))
                  : GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                      ),
                      itemCount: _foundProducts.length, 
                      itemBuilder: (context, index) {
                        final product = _foundProducts[index];
                        return _buildProductCard(context, product);
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, CategoryModel category) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductListScreen(
              categoryId: category.id,
              categoryName: category.name,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.orange.shade100,
          borderRadius: BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          category.name.split('\n')[0],
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, 5)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                  child: Image.asset(
                    product.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (_,__,___) => const Icon(Icons.cake, size: 40, color: Colors.orangeAccent),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${product.price.toStringAsFixed(0)}đ",
                        style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 14),
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                        child: const Icon(Icons.add, size: 16, color: Colors.white),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}