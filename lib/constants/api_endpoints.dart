// Project imports:
import 'package:riddhi_clone/config/env/app_env.dart';

class APIEndpoints {
  const APIEndpoints._();

  //*Master Data
  static String get getMastersData => '/area/master';

  //* BASEURL
  static String get baseUrl => AppEnv.baseUrl;

  //* Common Paths
  static const String _user = '/user/';
  static const String _product = '/products/';
  static const String _order = '/order';
  static const String _demoMeeting = '/demo-meeting';
  static const String _sdoAppointment = '/sdo-appointment';
  static const String _sdoTermination = '/sdo-termination';
  static const String _rsp = '/rsp';
  static const String _rspDownload = '/rsp/download';
  static const String _notification = '/notification';
  static const String _returnOrder = '/return-order';
  static const String customer = '/customer';

  //* AUTH
  static String get login => '${_user}login';
  static String get refreshToken => '${_user}refresh';
  static String get logout => '${_user}logout';
  static String get sendOtp => '${_user}send_otp';
  static String get verifyOtp => '${_user}verify-otp';
  static String get createNewPassword => '${_user}generate-reset-password';
  static String get signedCookies => '${_user}signed-cookies';

  //* HOME
  static String get homeData => '${_user}self';
  static String get approvalCount => '${_user}approval-count';

  //* CUSTOMER
  static String get allCustomer => '/customer';
  static String get getAllZones => '/area/zones';
  static String get getAllRegions => '/area/regions';
  static String get getAllSubRegions => '/area/sub-regions';
  static String get getAllTerritories => '/area/territories';
  static String get getAllCities => '/area/cities';
  static String invoiceDue(String customerId) => '/customer/$customerId/due-invoice';
  static String getPastOrders(String customerId) => '$order/last-month/$customerId';
  static String getPastReturnOrders(String customerId) => '$order/last-month/$customerId/return';
  static String getSalesInvoice(String customerId) => '/customer/$customerId/sales-invoices';
  static String getCustomerDetails(String customerId) => '/customer/$customerId';
  static String getSalesInvoiceDetails(String customerId, String invoiceNo) =>
      '/customer/$customerId/sales-invoices-details/$invoiceNo';
  static String getSalesReturnInvoice(String customerId) => '/customer/$customerId/sales-return-invoices';
  static String getSalesReturnInvoiceDetails(String customerId, String returnInvoiceNo) =>
      '/customer/$customerId/sales-return-invoices-details/$returnInvoiceNo';
  static String getCustomerCollection(String customerId) => '/customer/$customerId/collection-data';
  static String getCustomerOutstanding(String customerId) => '/customer/$customerId/outstanding-data';
  static String getLedgerPdf(String customerId) => '/customer/$customerId/ledger/pdf';

  //* ORDER
  static String get allPlants => '/plants';
  static String allCommonPlants(String customerId) => '$_order/plants/$customerId';
  static String orderUpdate(String orderId) => '$_order/$orderId/status';
  static String getOrderDetails(String orderId) => '$_order/$orderId';

  static String get allProducts => _product;
  static String get productDetails => '${_product}details/';
  static String get addCart => '/cart';
  static String get updateCart => '/cart';
  static String get placeOrder => '/order';
  static String get product => '/product/';
  static String get order => _order;

  //* Return ORDER
  static String productVariant(String customerID, String plantId) =>
      '$_returnOrder/$customerID/$plantId/product-variants';
  static String batchNumbers(String customerID, String plantId, int productVariantId) =>
      '$_returnOrder/$customerID/$plantId/$productVariantId/batches';
  static String getInvoices(String customerID, String plantId, int productVariantId, String batchNo) =>
      '$_returnOrder/$customerID/$plantId/$productVariantId/$batchNo/invoices';

  static String updateOrderDetailsByApprover(String orderDetailId) => '$_order/$orderDetailId/details';

  //* Demo Meetings
  static String get allDemoMeeting => _demoMeeting;
  static String get createDemoMeeting => _demoMeeting;
  static String get demoProducts => '$_demoMeeting/demo-products';
  static String get majorInsects => '$_demoMeeting/major-insects';
  static String get majorDiseases => '$_demoMeeting/major-diseases';
  static String get majorWeeds => '$_demoMeeting/major-weeds';
  static String get crops => '$_demoMeeting/crops';
  static String get getAllUsers => '/user';
  static String get checkInCheckout => '$_demoMeeting/checkin-checkout';
  static String get changeObservationDate => '$_demoMeeting/schedule-follow-up';
  static String get getInviteeDetails => '$_demoMeeting/invitee-users-details';
  static String get getAllInvitee => '$_demoMeeting/invitees';

  //* Demo Material
  static String get demoMaterial => '/demo/material/tm/allocation';
  static String get allocatedProducts => '/demo-meeting/material-stocks';
  static String get stockLog => '/demo-meeting/product-logs/';
  static String get addReason => '/demo/submit-request/';
  static String get getEmpCodes => '/user/emp-codes';
  static String get submitTransfer => '/demo-meeting/product-allocation';

  //* SDO Appointments
  static String get sdoAppointments => _sdoAppointment;
  static String sdoAppointmentsUpdate(int sdoAppointmentId) => '$_sdoAppointment/$sdoAppointmentId';
  static String addSDOReason(int appointmentId) => '$_sdoAppointment/$appointmentId/status';
  static String get sdoAppointmentsDetails => '$_sdoAppointment/';
  static String get sdoApprovals => '$_sdoAppointment/timeline';
  static String get selfieUpload => '$_sdoAppointment/upload-selfie';
  static String get sdoGetAllTerritories => '$_sdoAppointment/dropdown/territory';
  static String get sdoGetAllRegions => '$_sdoAppointment/dropdown/region';
  static String get sdoGetAllDistributor => '$_sdoAppointment/dropdown/customer';

  //* SDO Terminations
  static String get sdoTermination => _sdoTermination;
  static String get sdoTerminationRequest => '$_sdoTermination/timeline';
  static String addSDOTerminationReason(int terminationId) => '$_sdoTermination/$terminationId/status';

  //* RSP Module
  static String get rspPlannedProducts => '$_rsp/territory/planned-products';
  static String get rspGetAllProducts => '$_rsp/products';
  static String get rspProductsAdd => '$_rsp/products/add';
  static String get rspProductsDetails => '$_rsp/details';
  static String get createUpdateRsp => _rsp;
  static String get rspPlanSubmitForApproval => '$_rsp/submit';
  static String get rspCountryZones => '$_rsp/country/zones';
  static String get rspCountryBrands => '$_rsp/country/brands';
  static String get rspCountryTerritories => '$_rsp/country/territories';
  static String get rspCountrySubRegions => '$_rsp/country/sub-regions';
  static String get rspZoneSubRegions => '$_rsp/zone/sub-regions';
  static String get rspZoneTerritories => '$_rsp/zone/territories';
  static String get rspZoneBrands => '$_rsp/zone/brands';
  static String get rspSubRegionTerritories => '$_rsp/sub-region/territories';
  static String get rspSubRegionBrands => '$_rsp/sub-region/brands';
  static String get deleteRspProduct => '$_rsp/products/delete';
  static String get rspProductDetailsForCountry => '$_rsp/country/details';
  static String get rspApprovePlan => '$_rsp/approve';

  //* RSP Download
  static String get rspDownloadTerritoryBrands => '$_rspDownload/territory/brands';
  static String get rspDownloadSubRegionBrands => '$_rspDownload/sub-region/brands';
  static String get rspDownloadSubRegionTerritories => '$_rspDownload/sub-region/territories';
  static String get rspDownloadZoneSubRegions => '$_rspDownload/zone/sub-regions';
  static String get rspDownloadZoneTerritories => '$_rspDownload/zone/territories';
  static String get rspDownloadZoneBrands => '$_rspDownload/zone/brands';
  static String get rspDownloadCountryTerritories => '$_rspDownload/country/territories';
  static String get rspDownloadCountrySubRegions => '$_rspDownload/country/sub-regions';
  static String get rspDownloadCountryBrands => '$_rspDownload/country/brands';
  static String get rspDownloadCountryZones => '$_rspDownload/country/zones';

  //* RSP Graph
  static String get rspGraph => '$_rsp/product-sales-data';
  static String get rspDistributorData => '$_rsp/distributor-sales-data';

  //* Notifications
  static String get getAllNotifications => '$_notification/list';
  static String markNotificationAsRead(int notificationId) => '$_notification/read/$notificationId';
  static String get markAllNotificationsAsRead => '$_notification/read_all';

  //* Order Approval
  static String get allApprovalOrders => '$_order/timeline';

  //* Afternoon
  static String get getAfternoon => _sdoAppointment;

  //* CHECKLIST
  static String get getCheckList => '${_user}self';
}
