abstract class LocalRemoteDatasource {
  Future getLocalUserOnce(String uId);
  Future getLocalListResep();
  Future getLocalListUser(List<String> listIdUser);
}
