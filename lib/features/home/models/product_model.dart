// File: lib/features/home/models/product_model.dart
class ProductModel {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final String categoryId; // khóa để liên kết với danh mục từng sản phẩm

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    required this.categoryId,
  });
  static List<ProductModel> list = [
    //  1. MỤC BÁNH MÌ (bread) 
    ProductModel(
      id: 'bread_1',
      name: 'Bánh Mì Tròn',
      price: 15000,
      imagePath: 'assets/images/products/bread/banh_mi_tron.jpg',
      categoryId: 'bread',
    ),
    ProductModel(
      id: 'bread_2',
      name: 'Bánh Mì Pita',
      price: 25000,
      imagePath: 'assets/images/products/bread/banh_mi_pita.jpg',
      categoryId: 'bread',
    ),
    ProductModel(
      id: 'bread_3',
      name: 'Bánh Mì Xoắn Đức',
      price: 30000,
      imagePath: 'assets/images/products/bread/banh_mi_xoan_duc.jpg',
      categoryId: 'bread'
    ),
    ProductModel(
      id: 'bread_4',
      name:  'Bánh Chua Oliu',
      price: 90000,
      imagePath: 'assets/images/products/bread/banh_chua_oliu.jpg',
      categoryId: 'bread'
    ),
    ProductModel(
      id: 'bread_5',
      name:  'Hamburger',
      price: 30000,
      imagePath: 'assets/images/products/bread/hambuger.jpg',
      categoryId: 'bread'
    ),
    ProductModel(
      id: 'bread_6',
      name:  'White Sandwich',
      price: 90000,
      imagePath: 'assets/images/products/bread/sandwich_white.jpg',
      categoryId: 'bread'
    ),
    ProductModel(
      id: 'bread_7',
      name:  'White Sandwich',
      price: 90000,
      imagePath: 'assets/images/products/bread/sandwich_black.jpg',
      categoryId: 'bread'
    ),
    ProductModel(
      id: 'bread_8',
      name:  'Norlander',
      price: 90000,
      imagePath: 'assets/images/products/bread/norlander.jpg',
      categoryId: 'bread'
    ),

    //       2. MỤC ĂN SÁNG(BREAKFAST) 
    ProductModel(
      id: 'breakfast_1',
      name: 'Bánh Sừng Bò - Croissant',
      price: 45000,
      imagePath: 'assets/images/products/breakfast/croissant.jpg',
      categoryId: 'breakfast',
    ),
    ProductModel(
      id: 'breakfast_2',
      name: 'Chocolate Donut',
      price: 45000,
      imagePath: 'assets/images/products/breakfast/donut_chocolate.jpg',
      categoryId: 'breakfast',
    ),
    ProductModel(
      id: 'breakfast_3',
      name: 'Sugar Donut',
      price: 45000,
      imagePath: 'assets/images/products/breakfast/donut_sugar.jpg',
      categoryId: 'breakfast',
    ),
    
    // --- 3. MỤC ĐÔNG LẠNH (frozen) ---
    ProductModel(
      id: 'frozen_1',
      name: 'Croissant Đông Lạnh',
      price: 90000,
      imagePath: 'assets/images/products/frozen/croissant_frozen.jpg',
      categoryId: 'frozen',
    ),
    ProductModel(
      id: 'frozen_2',
      name: 'Frozen Donut',
      price: 50000,
      imagePath: 'assets/images/products/frozen/donut_frozen.jpg',
      categoryId: 'frozen',
    ),
    ProductModel(
      id: 'frozen_3',
      name: 'Pate Choux Frozen',
      price: 60000,
      imagePath: 'assets/images/products/frozen/pate_choux_frozen.jpg',
      categoryId: 'frozen',
    ),
    // 4. MỤC COOKIES
      ProductModel(
      id: 'cookies_1',
      name: 'Bánh Chuối',
      price: 60000,
      imagePath: 'assets/images/products/cookies/banh_chuoi.jpg',
      categoryId: 'cookies',
    ),
    ProductModel(
      id: 'cookies_2',
      name: 'Brownie',
      price: 20000,
      imagePath: 'assets/images/products/cookies/brownie.jpg',
      categoryId: 'cookies',
    ),
    ProductModel(
      id: 'cookies_3',
      name: 'Bánh Cà Rốt',
      price: 50000,
      imagePath: 'assets/images/products/cookies/carrot_cake.jpg',
      categoryId: 'cookies',
    ),
    ProductModel(
      id: 'cookies_4',
      name: 'Chocolate Cookies',
      price: 60000,
      imagePath: 'assets/images/products/cookies/choco_cookies.jpg',
      categoryId: 'cookies',
    ),
    // MỤC 5: BÁNH MOUSSE
    ProductModel(
      id: 'mousse_1',
      name: 'Tiramisu',
      price: 50000,
      imagePath: 'assets/images/products/mousse/tiramisu.jpg',
      categoryId: 'mousse',
    ),
    ProductModel(
      id: 'mousse_2',
      name: 'Passion Mousse',
      price: 55000,
      imagePath: 'assets/images/products/mousse/passion_mousse.jpg',
      categoryId: 'mousse',
    ),
    ProductModel(
      id: 'mousse_3',
      name: 'Chocolate Mousse',
      price: 50000,
      imagePath: 'assets/images/products/mousse/chocolate_mousse.jpg',
      categoryId: 'mousse',
    ),
    // MỤC 6: BÁNH TART
    ProductModel(
      id: 'tart_1',
      name: 'Lemon Tart',
      price: 40000,
      imagePath: 'assets/images/products/tart/lemon_tart.jpg',
      categoryId: 'tart',
    ),
    ProductModel(
      id: 'tart_2',
      name: 'Passion Tart',
      price: 40000,
      imagePath: 'assets/images/products/tart/passion_tart.jpg',
      categoryId: 'tart',
    ),
    ProductModel(
      id: 'tart_3',
      name: 'Strawberry Tart',
      price: 40000,
      imagePath: 'assets/images/products/tart/strawberry_tart.jpg',
      categoryId: 'tart',
    ),

  ];

  // Hàm tiện ích: Lọc danh sách bánh theo ID danh mục
  static List<ProductModel> getByCategoryId(String categoryId) {
    return list.where((product) => product.categoryId == categoryId).toList();
  }
  // HÀM TÌM KIẾM : NHẬP CÁC TỪ KHOÁ RỒI TRẢ VỀ DANH SÁCH BÁNH CÓ TRÙNG TÊN
  static List<ProductModel> search(String query) {
    if (query.isEmpty) {
      return list; // nếu ko gõ gì thì trả về tất cả các sp
    }
    return list.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
      // chuyển về chữ thường
    }).toList();
  }
}