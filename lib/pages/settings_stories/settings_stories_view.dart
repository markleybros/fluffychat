//@dart=2.12

import 'package:flutter/material.dart';

import 'package:fluffychat/pages/settings_stories/settings_stories.dart';
import 'package:fluffychat/utils/localized_exception_extension.dart';
import 'package:fluffychat/widgets/avatar.dart';

class SettingsStoriesView extends StatelessWidget {
  final SettingsStoriesController controller;
  const SettingsStoriesView(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: controller.loadUsers,
        builder: (context, snapshot) {
          final error = snapshot.error;
          if (error != null) {
            return Center(child: Text(error.toLocalizedString(context)));
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
                child: CircularProgressIndicator.adaptive(
              strokeWidth: 2,
            ));
          }
          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, i) {
              final user = controller.users.keys.toList()[i];
              return SwitchListTile.adaptive(
                value: controller.users[user] ?? false,
                onChanged: (_) => controller.toggleUser(user),
                secondary: Avatar(
                  mxContent: user.avatarUrl,
                  name: user.calcDisplayname(),
                ),
                title: Text(user.calcDisplayname()),
              );
            },
          );
        },
      ),
    );
  }
}