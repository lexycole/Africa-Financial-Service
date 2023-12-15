import 'package:get/get.dart';
import 'package:xcrowme/screens/List_of_all_registered_sellers/index.dart';
// import 'package:xcrowme/screens/account_screen/index.dart';
import 'package:xcrowme/screens/connect_seller_form/index.dart';
import 'package:xcrowme/screens/decision_screen/index.dart';
import 'package:xcrowme/screens/products_screen/create_products.dart';
import 'package:xcrowme/screens/history_screen/index.dart';
import 'package:xcrowme/screens/home_screen/index.dart';
import 'package:xcrowme/screens/store_profile/store_profile.dart';
import 'package:xcrowme/screens/merchant_screen/merchant_login_screen.dart';
import 'package:xcrowme/screens/merchant_screen/merchant_register_screen.dart';
import 'package:xcrowme/screens/new_store/index.dart';
import 'package:xcrowme/screens/onboarding_screen/index.dart';
import 'package:xcrowme/screens/profile_screen/index.dart';
import 'package:xcrowme/screens/sign_in_screen/index.dart';
import 'package:xcrowme/screens/sign_up_screen/index.dart';
import 'package:xcrowme/screens/splash_screen/index.dart';
import 'package:xcrowme/screens/sellers_screen/index.dart';
import 'package:xcrowme/screens/verify-otp_screen/index.dart';


class RouteHelper {

  static const String initial ="/";
  static const String getStartedScreen ="/get-started";
  static const String onboardingScreen = "/onboarding-screen";
  static const String decisionScreen = "/decision-screen";
  static const String signupScreen = "/signup-screen";
  static const String signinScreen = "/signin-screen";
  static const String passwordResetScreen = "/password-reset-screen";
  static const String otpScreen = "/otp-screen";
  static const String listOfAllSellersScreen = "/list-of-all-users";
  static const String newstore = "/new-store";
  static const String storeprofile = "/store-profile"; 
  static const String profileScreen = "/profile-screen";
  static const String accountScreen = "/account-screen";
  static const String connectSellerForm = "/connect-seller-form";
  // Bottom tab screen
  static const String homeScreen = "/home-screen";
  static const String sellersScreen = "/sellers-screen";
  static const String historyScreen = "/history-screen";
  // Merchant Screens
  static const String merchantRegisterScreen = "/merchant-register-screen";
  static const String merchantLoginScreen = "/merchant-login-screen";
  // Products Screens
  static const String createProductsScreen = "/products-screen";



  static String getInitial()=>'$initial';
  static String getNewStore()=>'$newstore';
  static String getOnboardingScreen()=>'$onboardingScreen';
  static String getDecisionScreen()=>'$decisionScreen';
  static String getStarted()=>'$getStartedScreen';
  static String getSignUpScreen()=>'$signupScreen';
  static String getSignInScreen()=>'$signinScreen';
  static String getPasswordResetScreen()=>'$passwordResetScreen';
  static String getOtpScreen()=>'$otpScreen';
  static String getListOfAllSellersScreen()=>'$listOfAllSellersScreen';
  // static String getNewStore()=>'$newstore';
  static String getStoreProfile()=>'$storeprofile';
  static String getAccountScreen() => '$accountScreen';
  static String getConnectSellerForm() => '$connectSellerForm';
  // Bottom Screens
  static String getHomeScreen()=>'$homeScreen';
  static String getSellersScreen()=>'$sellersScreen';
  static String getProfileScreen()=>'$profileScreen';
  static String getHistoryScreen() => '$historyScreen';
  // Merchant Screens
  static String getMerchantRegisterScreen()=>'$merchantRegisterScreen';
  static String getMerchantLoginScreen()=>'$merchantLoginScreen';
  //Products Screens
  static String getProductScreen()=>'$createProductsScreen';

 
  


  static List<GetPage> routes=[
    // Splash Screen
    GetPage( name:initial, page: () => SplashScreen()),
    // Onboarding Screen
    GetPage(name: onboardingScreen, page:() {
      return OnboardingScreen();
    },
    transition: Transition.fadeIn),
    GetPage(name: decisionScreen, page:() {
      return DecisionScreen();
    },
    transition: Transition.fadeIn),
    // SignUp Screen
    GetPage(name: signupScreen, page:() {
      return SignUpScreen();
    },
    transition: Transition.fadeIn),
    // SignIn Screen
    GetPage(name: signinScreen, page:() {
      return SignInScreen();
    },
    transition: Transition.fadeIn),
  // BOTTOM TABS 
    // Home Screen
    GetPage(name:homeScreen, page:() {
      return HomeScreen(newStores: [],);
    }, transition: Transition.fadeIn),
    // Users Screen
    GetPage(name:sellersScreen, page:() {
      return SellersScreen();
    }, transition: Transition.fadeIn),
    // Profile Screen
    GetPage(name:profileScreen, page:() {
      return ProfileScreen(initialValue: '', sellerId: '',);
    }, transition: Transition.fadeIn),
    // History Screen
    GetPage(name:historyScreen, page:() {
        return HistoryScreen();
    }, transition: Transition.fadeIn),
    // Merchant Register Screen
    GetPage(name:merchantRegisterScreen, page:() {
      return RegisterMerchantScreen();
    }, transition: Transition.fadeIn),
    // Merchant Login Screen
    GetPage(name:merchantLoginScreen, page:() {
      return MerchantLoginScreen();
    }, transition: Transition.fadeIn),
    // List of all users
    GetPage(name: listOfAllSellersScreen, page:() {
      return ListOfAllSellersScreen(newSellers: [],);}
      ,transition: Transition.fadeIn),  
      // OTP Screen
    GetPage(name: otpScreen, page:() {
      return VerifyOTPScreen(phoneNumber: '',);}
      ,transition: Transition.fadeIn), 
      // New Store
    GetPage(name: newstore, page:() {
      return NewStoreScreen();}
      ,transition: Transition.fadeIn),
      // List of Store
    GetPage(name: storeprofile, page:() {
      return StoreProfileScreen(initialValue: '', link: '', sellerId: '',);}
      ,transition: Transition.fadeIn),
    //   // Account Screen
    // GetPage(name: accountScreen, page:() {
    //   return AccountScreen();}
    //   ,transition: Transition.fadeIn),
      // Connect Seller Form
    GetPage(name: connectSellerForm, page:() {
      return ConnectSellerFormScreen();
    }, transition: Transition.fadeIn),
    GetPage(name: createProductsScreen, page:() {
      return CreateProducts(initialValue: '', link: '', sellerId: '',);
    }, transition: Transition.fadeIn), 
  ];

}