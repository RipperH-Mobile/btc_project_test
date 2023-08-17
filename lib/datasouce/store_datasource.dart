
import '../result/app_result.dart';
import '../ui/btc_funtion/btc_response.dart';

abstract class BtcDatasource {
  Future<AppResult<BtcDetailResponse?>> getDetailBtc() ;
}

