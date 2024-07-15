import 'package:connectivity_plus/connectivity_plus.dart';
import '../../enums/NetworkStatus.dart';

class NetworkServices {
  final Connectivity _connectivity = Connectivity();

  Future<NetworkStatus> checkConnectivity() async {
    try {
      List<ConnectivityResult> connectivityResults = await _connectivity.checkConnectivity();
      ConnectivityResult connectivityResult = connectivityResults.first;
      if (connectivityResult == ConnectivityResult.mobile) {
        return NetworkStatus.Online;
      } else if (connectivityResult == ConnectivityResult.wifi) {
        return NetworkStatus.Online;
      } else if (connectivityResult == ConnectivityResult.none) {
        return NetworkStatus.Offline;
      } else {
        return NetworkStatus.Unknown;
      }
    } catch (e) {
      print('Error in connectivity check: $e');
      return NetworkStatus.Unknown;
    }
  }
}