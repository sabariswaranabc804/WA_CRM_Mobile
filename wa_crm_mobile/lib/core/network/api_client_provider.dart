import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../storage/token_storage_provider.dart';
import 'api_client.dart';
import 'dio_client.dart';

part 'api_client_provider.g.dart';

@riverpod
ApiClient apiClient(Ref ref) {
  final storage = ref.watch(tokenStorageProvider);
  final dioClient = DioClient(tokenStorage: storage);
  return ApiClient(dioClient.dio);
}
