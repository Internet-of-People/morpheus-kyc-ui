import 'package:morpheus_kyc_user/sdk/api.dart';

void main() async {
  final result = await apiPing('ping param');
  print('Result $result');
}
