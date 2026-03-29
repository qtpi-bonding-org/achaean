/* AUTOMATICALLY GENERATED CODE DO NOT MODIFY */
/*   To generate run: "serverpod generate"    */

// ignore_for_file: implementation_imports
// ignore_for_file: library_private_types_in_public_api
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: public_member_api_docs
// ignore_for_file: type_literal_in_constant_pattern
// ignore_for_file: use_super_parameters
// ignore_for_file: invalid_use_of_internal_member

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:serverpod_client/serverpod_client.dart' as _i1;
import 'dart:async' as _i2;
import 'package:achaean_client/src/protocol/greetings/greeting.dart' as _i3;
import 'package:koinon_index_core_client/koinon_index_core_client.dart' as _i4;
import 'package:koinon_index_content_client/koinon_index_content_client.dart'
    as _i5;
import 'protocol.dart' as _i6;

/// This is an example endpoint that returns a greeting message through
/// its [hello] method.
/// {@category Endpoint}
class EndpointGreeting extends _i1.EndpointRef {
  EndpointGreeting(_i1.EndpointCaller caller) : super(caller);

  @override
  String get name => 'greeting';

  /// Returns a personalized greeting message: "Hello {name}".
  _i2.Future<_i3.Greeting> hello(String name) =>
      caller.callServerEndpoint<_i3.Greeting>(
        'greeting',
        'hello',
        {'name': name},
      );
}

class Modules {
  Modules(Client client) {
    koinon_core = _i4.Caller(client);
    koinon_content = _i5.Caller(client);
  }

  late final _i4.Caller koinon_core;

  late final _i5.Caller koinon_content;
}

class Client extends _i1.ServerpodClientShared {
  Client(
    String host, {
    dynamic securityContext,
    @Deprecated(
      'Use authKeyProvider instead. This will be removed in future releases.',
    )
    super.authenticationKeyManager,
    Duration? streamingConnectionTimeout,
    Duration? connectionTimeout,
    Function(
      _i1.MethodCallContext,
      Object,
      StackTrace,
    )?
    onFailedCall,
    Function(_i1.MethodCallContext)? onSucceededCall,
    bool? disconnectStreamsOnLostInternetConnection,
  }) : super(
         host,
         _i6.Protocol(),
         securityContext: securityContext,
         streamingConnectionTimeout: streamingConnectionTimeout,
         connectionTimeout: connectionTimeout,
         onFailedCall: onFailedCall,
         onSucceededCall: onSucceededCall,
         disconnectStreamsOnLostInternetConnection:
             disconnectStreamsOnLostInternetConnection,
       ) {
    greeting = EndpointGreeting(this);
    modules = Modules(this);
  }

  late final EndpointGreeting greeting;

  late final Modules modules;

  @override
  Map<String, _i1.EndpointRef> get endpointRefLookup => {'greeting': greeting};

  @override
  Map<String, _i1.ModuleEndpointCaller> get moduleLookup => {
    'koinon_core': modules.koinon_core,
    'koinon_content': modules.koinon_content,
  };
}
