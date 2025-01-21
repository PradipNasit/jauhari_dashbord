class Api {

  Api ._();
  static    const baseUrl = "http://46.202.163.138:5000/api";
  static  const logIn = "/admin-login";
  static  const verifyOtp = "/admin/verify/otp";
  static  const getDashBordData = "/get/sip/analytics";
  static  const getUserData = "/get/users";
  static  const editUserData = "/edit/user/by/admin";
  static  const editSipData = "/update/sip/status/manually";
  static  const deleteUserData = "/verify/delete/user/otp";
  static  const deleteUserReqOtp = "/delete/user";
  static  const createSip = "/create/sip-plan";
  static  const getSipData = "/get/all/sip-plans";
  static  const createBusiness = "/create/admin/company-information";
  static  const createSocialMedia = "/create/social-media";
  static  const createCancellationPolicy = "/create/cancellation-policy";
  static  const createTermsAndCondition = "/create/terms-and-conditions";
  static  const privacyPolicy = "/create/privacy-policy";
  static  const returnAndRefund = "/create/return-and-refund-policy";
  static  const getUserParticularDetails = "/get/user/sip/details";
  static  const withDrawSip = "/withdraw/sip";
  static  const verifyWithDrawSip = "/verify/withdraw";
  static  const createFaq = "/create/faq";
  static  const getFaq = "/get/all/faq";
  static  const editFaq = "/update/faq";
  static  const addGoldManually = "/add/amount/sip/amount";
  static  const getAllBanners = "/get/all/banners";
  static  const updateBannerStatus = "/update/banner/status";
  static  const deleteBanner = "/delete/banner";
  static  const getUserTransactionDetails = "/get/user/sip/transactions";
}