import 'package:collection/collection.dart';
import 'package:intl/intl.dart';
import 'package:riddhi_clone/constants/app_enums.dart';
import 'package:riddhi_clone/constants/app_strings.dart';
import 'package:riddhi_clone/resources/app_utils.dart';

extension RupeesFormatter on num {
  String inRupeesFormat({int decimalDigits = 2, bool isShowSymbol = true}) {
    final indianRupeesFormat =
        NumberFormat.currency(locale: AppStrings.en_in, decimalDigits: decimalDigits, symbol: AppStrings.rupeeSymbol);

    final List<dynamic> listOfStrings = indianRupeesFormat.format(this).split('');
    final amount = listOfStrings.join();
    return isShowSymbol
        ? amount
        : amount.replaceAll(
            AppStrings.rupeeSymbol,
            '',
          );
  }
}

extension GetFileTypeFolder on String {
  ///* Please note
  String getFileTypeFolderName() {
    final value = this;

    if (AppUtils.isImage(value)) {
      return S3Filetype.image.name;
    } else if (AppUtils.isVideo(value)) {
      return S3Filetype.video.name;
    } else if (AppUtils.isAudio(value)) {
      return S3Filetype.audio.name;
    } else if (AppUtils.isDocument(value)) {
      return S3Filetype.document.name;
    } else {
      return S3Filetype.none.name;
    }
  }
}

extension OrderTypeString on String {
  ///* Please note
  String getOrderTypeTitle() {
    final value = OrderType.values.firstWhereOrNull((e) => e.value == this);
    switch (value) {
      case OrderType.regularOrder:
        return 'Regular Order';
      case OrderType.superCashOrder:
        return 'Super Cash Order';
      case null:
        return 'Unknown Order';
    }
  }
}

extension StringCasingExtension on String {
  /// Capitalizes the first letter of the string
  String toCapitalize() {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of every word in the string
  String toCapitalizeEachWord() {
    return split(' ').map(
      (word) {
        return word.isNotEmpty ? word[0].toUpperCase() + word.substring(1).toLowerCase() : '';
      },
    ).join(' ');
  }
}
