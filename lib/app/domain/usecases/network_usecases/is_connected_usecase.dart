import 'package:seleraku/app/domain/repositories/network_repository.dart';

class IsConnectedUsecase {
  final NetworkRepository repository;

  IsConnectedUsecase(this.repository);

  Future<bool> call() async {
    return await repository.isConnected();
  }
}
