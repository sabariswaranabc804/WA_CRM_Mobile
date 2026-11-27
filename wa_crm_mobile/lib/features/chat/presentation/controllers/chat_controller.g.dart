// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChatController)
final chatControllerProvider = ChatControllerProvider._();

final class ChatControllerProvider
    extends $NotifierProvider<ChatController, ChatControllerState> {
  ChatControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'chatControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$chatControllerHash();

  @$internal
  @override
  ChatController create() => ChatController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ChatControllerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ChatControllerState>(value),
    );
  }
}

String _$chatControllerHash() => r'bfacc0ccdb1f41d7d9410dee20acf29c24e84e2d';

abstract class _$ChatController extends $Notifier<ChatControllerState> {
  ChatControllerState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<ChatControllerState, ChatControllerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ChatControllerState, ChatControllerState>,
              ChatControllerState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
