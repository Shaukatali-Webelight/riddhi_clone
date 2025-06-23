import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:riddhi_clone/helpers/internet_connection/internet_connection_state.dart';

final internetConnectionStateProvider =
    StateNotifierProvider<InternetConnectivityStateNotifier, InternetConnectionState>((ref) {
  return InternetConnectivityStateNotifier()..init();
});

final internetConnectedProvider = FutureProvider.autoDispose<bool>((ref) async {
  return InternetConnection().hasInternetAccess;
});

class InternetConnectivityStateNotifier extends StateNotifier<InternetConnectionState> {
  InternetConnectivityStateNotifier() : super(InternetConnectionState.initial());

  //!TODO commented this code for now as due to latest version upgrade of internet_connection_checker_plus, need to update code

  // final Connectivity _connectivity = Connectivity();

  void init() {
    _checkConnection();
    // _connectivity.onConnectivityChanged
    //     .listen((ConnectivityResult result) async {
    //   _checkConnectionStatus(result);
    // });
  }

  Future<void> _checkConnection() async {
    // try {
    //   final connectivityResult = await _connectivity.checkConnectivity();
    //   _checkConnectionStatus(connectivityResult);
    // } on PlatformException catch (e) {
    //   LogHelper.logError('$e');
    // }
  }

  // void _checkConnectionStatus(ConnectivityResult result) {
  //   state = state.copyWith(isConnected: result != ConnectivityResult.none);
  //   if (result == ConnectivityResult.none && !state.isAlertShowing) {
  //     _showDialogBox();
  //   }
  // }

  // void _showDialogBox() {
  //   return DialogHelper.showCustomAlertDialog(
  //     barrierDismissible: false,
  //     builder: (BuildContext context, widget) {
  //       return WillPopScope(
  //         onWillPop: () async => false,
  //         child: AlertDialog(
  //           title: const Text(AppStrings.noInternet),
  //           content: const Text(AppStrings.checkYourInternet),
  //           actions: [
  //             ElevatedButton(
  //               style: ButtonStyle(
  //                 elevation: MaterialStateProperty.all(0),
  //               ),
  //               onPressed: () {
  //                 NavigationHelper.navigatePop();
  //                 state = state.copyWith(isAlertShowing: false);
  //                 _checkConnection();
  //               },
  //               child: const Text(AppStrings.tryAgain),
  //             ),
  //           ],
  //         ),
  //       );
  //     },
  //   );
  // }
}
