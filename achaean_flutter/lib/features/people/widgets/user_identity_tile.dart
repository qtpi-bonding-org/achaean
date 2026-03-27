import 'package:flutter/material.dart';

import '../../../design_system/widgets/inscription_tile.dart';

/// Displays a user's identity: display name (if available) + truncated pubkey.
class UserIdentityTile extends StatelessWidget {
  final String pubkey;
  final String? displayName;
  final VoidCallback? onTap;
  final Widget? trailing;

  const UserIdentityTile({
    super.key,
    required this.pubkey,
    this.displayName,
    this.onTap,
    this.trailing,
  });

  String get _truncatedPubkey {
    if (pubkey.length <= 12) return pubkey;
    return '${pubkey.substring(0, 6)}...${pubkey.substring(pubkey.length - 6)}';
  }

  @override
  Widget build(BuildContext context) {
    return InscriptionTile(
      title: displayName ?? _truncatedPubkey,
      subtitle: displayName != null ? _truncatedPubkey : null,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
