// ignore_for_file: public_member_api_docs, document_ignores, use_setters_to_change_properties

import 'package:riddhi_clone/features/common/models/master_data_model.dart';

class MasterDataController {
  MasterDataController._();
  static final instance = MasterDataController._();

  MasterData? mastersData;

  void setMastersData(MasterData data) {
    mastersData = data;
  }
}
