import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:seleraku/app/data/datasources/remote/network_remote_datasource.dart';

class NetworkRemoteDatasourceImpl implements NetworkRemoteDatasource {
  final InternetConnection internetConnection;
  NetworkRemoteDatasourceImpl(this.internetConnection);

  @override
  Future<bool> isConnected() async {
    return await internetConnection.hasInternetAccess;
  }
}
