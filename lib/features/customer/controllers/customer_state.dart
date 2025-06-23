import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';
import 'package:riddhi_clone/features/customer/models/get_customer_outstanding_response_model.dart';

class CustomerState {
  CustomerState({
    required this.isLoading,
    required this.isLoadingMore,
    required this.isRefreshing,
    required this.hasError,
    required this.hasMoreData,
    required this.allCustomerDataItems,
    this.allCustomerData,
    this.errorMessage,
    this.currentPage,
    this.total,
    this.totalPages,
    this.isLoadingOutstanding = false,
    this.hasOutstandingError = false,
    this.customerOutstandingData,
    this.outstandingErrorMessage,
  });

  CustomerState.initial();

  bool isLoading = false;
  bool isLoadingMore = false;
  bool isRefreshing = false;
  bool hasError = false;
  bool hasMoreData = true;
  GetAllCustomerDataData? allCustomerData;
  List<GetAllCustomerDataItem> allCustomerDataItems = [];
  String? errorMessage;
  int? currentPage;
  int? total;
  int? totalPages;

  // Customer Outstanding specific properties
  bool isLoadingOutstanding = false;
  bool hasOutstandingError = false;
  GetCustomerOutstandingData? customerOutstandingData;
  String? outstandingErrorMessage;

  CustomerState copyWith({
    bool? isLoading,
    bool? isLoadingMore,
    bool? isRefreshing,
    bool? hasError,
    bool? hasMoreData,
    GetAllCustomerDataData? allCustomerData,
    List<GetAllCustomerDataItem>? allCustomerDataItems,
    String? errorMessage,
    int? currentPage,
    int? total,
    int? totalPages,
    bool? isLoadingOutstanding,
    bool? hasOutstandingError,
    GetCustomerOutstandingData? customerOutstandingData,
    String? outstandingErrorMessage,
  }) {
    return CustomerState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasError: hasError ?? this.hasError,
      hasMoreData: hasMoreData ?? this.hasMoreData,
      allCustomerData: allCustomerData ?? this.allCustomerData,
      allCustomerDataItems: allCustomerDataItems ?? this.allCustomerDataItems,
      errorMessage: errorMessage ?? this.errorMessage,
      currentPage: currentPage ?? this.currentPage,
      total: total ?? this.total,
      totalPages: totalPages ?? this.totalPages,
      isLoadingOutstanding: isLoadingOutstanding ?? this.isLoadingOutstanding,
      hasOutstandingError: hasOutstandingError ?? this.hasOutstandingError,
      customerOutstandingData: customerOutstandingData ?? this.customerOutstandingData,
      outstandingErrorMessage: outstandingErrorMessage ?? this.outstandingErrorMessage,
    );
  }
}
