class ApiEndPoints {
  static final String baseUrl = 'https://staging.api.cashrole.com/api/v1/merchant';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = '/register/';
  final String loginEmail = '/login/';
  final String verifyToken = '/verify-otp/';
  final String resendOtp = '/resend-otp/';
  final String banks = '/banks/';
  final String balance = '/balance/';
  final String createSeller = '/seller/create/';
  final String sellersList = '/list-sellers/';
  final String sellerDetail = '/seller/detail/{uid}';
  final String updateSellerDetails = '/seller/update/{uid}/';
  final String deleteSellerDetail = '/seller/delete/{uid}';
  final String storesList = '/store/';
  final String createStore = '/store/create/';
  final String deleteStore = '/store/delete/{link}';
  final String storeDetail = '/store/detail/{link}';
  final String storeUpdate = '/store/update/{link}/';
  final String productsList = '/products/';
  final String createProduct = '/products/create/';
  final String deleteProducts = '/products/delete/{label}/';
  final String productsDetail = '/products/detail/{label}/';
  final String productsUpdate = '/products/update/{label}/';
  final String productsUpload = '/products/upload/{label}/';

  final String refreshToken = 'https://staging.api.cashrole.com/api/v1/authentication/token/refresh/';



}
