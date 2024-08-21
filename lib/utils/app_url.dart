class AppUrls {
  static const baseUrl = "http://192.168.10.137:9000/api/v1";
  static const imageUrl = "http://192.168.10.137:9000/";

  static const socketUrl = "http://103.145.138.74:3001";

  static const signUp = "$baseUrl/users/signup";
  static const verifyOtp = "$baseUrl/users/verify-otp";
  static const signIn = "$baseUrl/users/login";
  static const forgotPassword = "$baseUrl/users/forget-password";
  static const forgotPasswordOTP = "$baseUrl/users/otp/forget-password";
  static const resetPassword = "$baseUrl/users/reset-password";
  static const changePassword = "$baseUrl/users/change-password";
  static const user = "$baseUrl/users";
  static const addHouse =
      "$baseUrl/house/single"; // Add house "multiple" or "single"
  static const ownHouse =
      "$baseUrl/house/user/all-name"; // Add house "multiple" or "single"
  static const houseShortDetails =
      "$baseUrl/house/user/short-details"; // Add house "multiple" or "single"
  static const allHouse = "$baseUrl/house"; // Get house "all" or "single"
  static const scanHouse = "$baseUrl/house/scan"; // Get house "all" or "single"
  static const userHouse = "$baseUrl/house/user";
  static const houseScan = "$baseUrl/house/scan";
  static const addRoom = "$baseUrl/room/add";
  static const allRoom = "$baseUrl/room/all";
  static const getRoom = "$baseUrl/room/get";
  static const updateRoomName = "$baseUrl/room/roomName";
  static const room = "$baseUrl/room";
  static const surface = "$baseUrl/surface"; // Surface "add" or "update"

  static const logOut = "$baseUrl/users/user/logout/true";
  static const verifyEmail = "$baseUrl/users/verify-email";
  static const notifications = "$baseUrl/notifications";
  static const privacyPolicies = "$baseUrl/setting?title=privacyPolicy";
  static const aboutUs = "$baseUrl/setting?title=aboutUs";
  static const termsOfServices = "$baseUrl/setting?title=termsOfService";
}
