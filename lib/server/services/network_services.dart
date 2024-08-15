import 'package:connectivity_plus/connectivity_plus.dart';
import '../../enums/network_status.dart';

class NetworkServices {
  final Connectivity _connectivity = Connectivity();

  Future<NetworkStatus> checkConnectivity() async {
    try {
      List<ConnectivityResult> connectivityResults = await _connectivity.checkConnectivity();
      ConnectivityResult connectivityResult = connectivityResults.first;
      if (connectivityResult == ConnectivityResult.mobile) {
        return NetworkStatus.online;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return NetworkStatus.online;
      } else if (connectivityResult == ConnectivityResult.none) {
        return NetworkStatus.offline;
      } else {
        return NetworkStatus.unknown;
      }
    } catch (e) {
      print('Error in connectivity check: $e');
      return NetworkStatus.unknown;
    }
  }
}