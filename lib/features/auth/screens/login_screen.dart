import 'package:flutter/material.dart';
import 'package:bakery_mobile_app/core/constants/app_colors.dart';
import 'package:bakery_mobile_app/features/auth/services/auth_service.dart';
import 'package:bakery_mobile_app/features/home/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  
  // Biến để kiểm soát việc hiện/ẩn mật khẩu
  bool _isObscure = true; 

  void _handleLogin() async {
    // Kiểm tra xem đã nhập chưa
    if (_userController.text.isEmpty || _passController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    setState(() => _isLoading = true);

    // Gọi cái API bên kia
    bool success = await _authService.login(
      _userController.text, // Lấy chữ người dùng nhập
      _passController.text,
    );

    setState(() => _isLoading = false);

    if (success) {
      if (!mounted) return;
      // Chuyển sang trang chủ
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng nhập thành công!"), backgroundColor: Colors.green),
      );
    } else {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Sai tài khoản hoặc mật khẩu!"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center( 
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LOGO
              SizedBox(
                height: 150, // Chiều cao logo
                width: 150,  // Chiều rộng logo
                child: Image.asset(
                  'assets/images/logo/logo.jpg',
                  fit: BoxFit.contain,
                  // ảnh hình cái bánh tạm lỡ lỗi không có tải được ảnh
                  errorBuilder: (_, __, ___) => const Icon(Icons.cake, size: 100, color: AppColors.primary),
                ),
              ),
              const SizedBox(height: 10),
              
              const Text(
                "BAKERY APP",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppColors.primary),
              ),
              const SizedBox(height: 40),

             // nhập TÀI KHOẢN
              TextField(
                controller: _userController,
                decoration: const InputDecoration(
                  labelText: "Tài khoản",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),

              // nhập mật khẩu
              TextField(
                controller: _passController,
                obscureText: _isObscure, // Ẩn hiện dựa theo biến này
                decoration: InputDecoration(
                  labelText: "Mật khẩu",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.lock),
                  // Nút con mắt hiện mật khẩu  nằm ở đuôi
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      // bấm vào thì đổi trạng thái (chộ mật khẩu hoặc không chộ)
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // Nút Đăng nhập
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "ĐĂNG NHẬP",
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}