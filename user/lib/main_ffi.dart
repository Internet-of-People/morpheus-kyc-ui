import 'package:morpheus_kyc_user/sdk/api.dart';

void main() async {
  final pingResult = await apiPing('ping param');
  print('Result $pingResult');

  final didsResult = await listDids();
  print(didsResult);
}
