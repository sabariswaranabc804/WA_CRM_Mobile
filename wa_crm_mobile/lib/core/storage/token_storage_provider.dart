import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'token_storage.dart';

part 'token_storage_provider.g.dart';

@riverpod
TokenStorage tokenStorage(Ref ref) {
  return TokenStorage();
}
