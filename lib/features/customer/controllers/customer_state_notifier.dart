import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:riddhi_clone/features/customer/controllers/customer_state.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_request_model.dart';
import 'package:riddhi_clone/features/customer/models/get_all_customer_data_response_model.dart';
import 'package:riddhi_clone/features/customer/models/get_customer_outstanding_request_model.dart';
import 'package:riddhi_clone/features/customer/repository/customer_repository.dart';

final customerStateNotifierProvider = StateNotifierProvider<CustomerStateNotifier, CustomerState>(
  (ref) => CustomerStateNotifier(ref.read(customerRepositoryProvider)),
);

class CustomerStateNotifier extends StateNotifier<CustomerState> {
  CustomerStateNotifier(this._customerRepository) : super(CustomerState.initial());

  final CustomerRepository _customerRepository;
  final RefreshController getAllCustomerDataRefreshController = RefreshController();

  Future<void> getAllCustomerData({
    int page = 1,
    int size = 50,
  }) async {
    if (page == 1) {
      state = state.copyWith(
        isLoading: true,
        hasError: false,
        allCustomerDataItems: [],
      );
    }

    final requestModel = GetAllCustomerRequestModel(
      page: page,
      size: size,
    );

    final result = await _customerRepository.getAllCustomerData(requestModel: requestModel);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          hasError: true,
          errorMessage: failure.message,
        );
        if (page == 1) {
          getAllCustomerDataRefreshController.refreshFailed();
        } else {
          getAllCustomerDataRefreshController.loadFailed();
        }
      },
      (data) {
        final newItems = data.items ?? <GetAllCustomerDataItem>[];
        final hasMoreData = (data.page ?? 0) < (data.pages ?? 0);

        if (page == 1) {
          state = state.copyWith(
            isLoading: false,
            hasError: false,
            allCustomerData: data,
            allCustomerDataItems: newItems,
            currentPage: data.page,
            total: data.total,
            totalPages: data.pages,
            hasMoreData: hasMoreData,
          );
          getAllCustomerDataRefreshController.refreshCompleted();
        } else {
          final existingItems = state.allCustomerDataItems;
          final updatedItems = [...existingItems, ...newItems];

          state = state.copyWith(
            isLoadingMore: false,
            allCustomerDataItems: updatedItems,
            currentPage: data.page,
            hasMoreData: hasMoreData,
          );

          if (hasMoreData) {
            getAllCustomerDataRefreshController.loadComplete();
          } else {
            getAllCustomerDataRefreshController.loadNoData();
          }
        }
      },
    );
  }

  Future<void> getCustomerOutstanding({
    required String customerId,
  }) async {
    state = state.copyWith(
      isLoadingOutstanding: true,
      hasOutstandingError: false,
    );

    final requestModel = GetCustomerOutstandingRequestModel(
      customerId: customerId,
    );

    final result = await _customerRepository.getCustomerOutstanding(requestModel: requestModel);

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoadingOutstanding: false,
          hasOutstandingError: true,
          outstandingErrorMessage: failure.message,
        );
      },
      (data) {
        state = state.copyWith(
          isLoadingOutstanding: false,
          hasOutstandingError: false,
          customerOutstandingData: data,
        );
      },
    );
  }

  Future<void> refreshAllCustomerData() async {
    state = state.copyWith(isRefreshing: true);
    await getAllCustomerData();
    state = state.copyWith(isRefreshing: false);
  }

  Future<void> loadMoreAllCustomerData() async {
    if (state.hasMoreData && !state.isLoadingMore) {
      state = state.copyWith(isLoadingMore: true);
      final nextPage = (state.currentPage ?? 0) + 1;
      await getAllCustomerData(page: nextPage);
    }
  }

  void clearAllCustomerDataError() {
    state = state.copyWith(hasError: false);
  }

  void clearOutstandingError() {
    state = state.copyWith(hasOutstandingError: false);
  }

  @override
  void dispose() {
    getAllCustomerDataRefreshController.dispose();
    super.dispose();
  }
}
