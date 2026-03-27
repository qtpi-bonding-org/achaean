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
import 'package:serverpod/serverpod.dart' as _i1;
import '../greetings/greeting_endpoint.dart' as _i2;
import '../koinon/koinon_endpoint.dart' as _i3;
import '../koinon/webhook_endpoint.dart' as _i4;

class Endpoints extends _i1.EndpointDispatch {
  @override
  void initializeEndpoints(_i1.Server server) {
    var endpoints = <String, _i1.Endpoint>{
      'greeting': _i2.GreetingEndpoint()
        ..initialize(
          server,
          'greeting',
          null,
        ),
      'koinon': _i3.KoinonEndpoint()
        ..initialize(
          server,
          'koinon',
          null,
        ),
      'webhook': _i4.WebhookEndpoint()
        ..initialize(
          server,
          'webhook',
          null,
        ),
    };
    connectors['greeting'] = _i1.EndpointConnector(
      name: 'greeting',
      endpoint: endpoints['greeting']!,
      methodConnectors: {
        'hello': _i1.MethodConnector(
          name: 'hello',
          params: {
            'name': _i1.ParameterDescription(
              name: 'name',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['greeting'] as _i2.GreetingEndpoint).hello(
                session,
                params['name'],
              ),
        ),
      },
    );
    connectors['koinon'] = _i1.EndpointConnector(
      name: 'koinon',
      endpoint: endpoints['koinon']!,
      methodConnectors: {
        'register': _i1.MethodConnector(
          name: 'register',
          params: {
            'repoUrl': _i1.ParameterDescription(
              name: 'repoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).register(
                session,
                params['repoUrl'],
              ),
        ),
        'getUser': _i1.MethodConnector(
          name: 'getUser',
          params: {
            'pubkey': _i1.ParameterDescription(
              name: 'pubkey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).getUser(
                session,
                params['pubkey'],
              ),
        ),
        'listPoleis': _i1.MethodConnector(
          name: 'listPoleis',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).listPoleis(
                session,
              ),
        ),
        'getPolis': _i1.MethodConnector(
          name: 'getPolis',
          params: {
            'repoUrl': _i1.ParameterDescription(
              name: 'repoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).getPolis(
                session,
                params['repoUrl'],
              ),
        ),
        'getPolisMembers': _i1.MethodConnector(
          name: 'getPolisMembers',
          params: {
            'polisRepoUrl': _i1.ParameterDescription(
              name: 'polisRepoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinon'] as _i3.KoinonEndpoint).getPolisMembers(
                    session,
                    params['polisRepoUrl'],
                  ),
        ),
        'getRelationships': _i1.MethodConnector(
          name: 'getRelationships',
          params: {
            'pubkey': _i1.ParameterDescription(
              name: 'pubkey',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinon'] as _i3.KoinonEndpoint).getRelationships(
                    session,
                    params['pubkey'],
                  ),
        ),
        'getFlagsForPolis': _i1.MethodConnector(
          name: 'getFlagsForPolis',
          params: {
            'polisRepoUrl': _i1.ParameterDescription(
              name: 'polisRepoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinon'] as _i3.KoinonEndpoint).getFlagsForPolis(
                    session,
                    params['polisRepoUrl'],
                  ),
        ),
        'getFlaggedPostsForVouchers': _i1.MethodConnector(
          name: 'getFlaggedPostsForVouchers',
          params: {},
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint)
                  .getFlaggedPostsForVouchers(session),
        ),
        'getAgora': _i1.MethodConnector(
          name: 'getAgora',
          params: {
            'polisRepoUrl': _i1.ParameterDescription(
              name: 'polisRepoUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).getAgora(
                session,
                params['polisRepoUrl'],
                limit: params['limit'],
                offset: params['offset'],
              ),
        ),
        'getPersonalFeed': _i1.MethodConnector(
          name: 'getPersonalFeed',
          params: {
            'limit': _i1.ParameterDescription(
              name: 'limit',
              type: _i1.getType<int>(),
              nullable: false,
            ),
            'offset': _i1.ParameterDescription(
              name: 'offset',
              type: _i1.getType<int>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['koinon'] as _i3.KoinonEndpoint).getPersonalFeed(
                    session,
                    limit: params['limit'],
                    offset: params['offset'],
                  ),
        ),
        'getThread': _i1.MethodConnector(
          name: 'getThread',
          params: {
            'rootPostUrl': _i1.ParameterDescription(
              name: 'rootPostUrl',
              type: _i1.getType<String>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async => (endpoints['koinon'] as _i3.KoinonEndpoint).getThread(
                session,
                params['rootPostUrl'],
              ),
        ),
      },
    );
    connectors['webhook'] = _i1.EndpointConnector(
      name: 'webhook',
      endpoint: endpoints['webhook']!,
      methodConnectors: {
        'handlePush': _i1.MethodConnector(
          name: 'handlePush',
          params: {
            'payload': _i1.ParameterDescription(
              name: 'payload',
              type: _i1.getType<Map<String, dynamic>>(),
              nullable: false,
            ),
          },
          call:
              (
                _i1.Session session,
                Map<String, dynamic> params,
              ) async =>
                  (endpoints['webhook'] as _i4.WebhookEndpoint).handlePush(
                    session,
                    params['payload'],
                  ),
        ),
      },
    );
  }
}
