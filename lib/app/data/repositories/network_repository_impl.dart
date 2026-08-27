import 'package:seleraku/app/data/datasources/remote/network_remote_datasource.dart';
import 'package:seleraku/app/domain/repositories/network_repository.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final NetworkRemoteDatasource remote;

  NetworkRepositoryImpl(this.remote);

  @override
  Future<bool> isConnected() async {
    return await remote.isConnected();
  }
}
