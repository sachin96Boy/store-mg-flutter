import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:store_mg_fl/features/auth/models/user_model.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';

class AppBarUser extends StatefulHookConsumerWidget {
  const AppBarUser({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarUserState();
}

class _AppBarUserState extends ConsumerState<AppBarUser> {
  late Future<UserModel?> user;

  Future<UserModel?> handleUser() async {
    final userModel =
        await ref.read(authResponseProvider.notifier).getAuthenticatedUser();
    return userModel;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = handleUser();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CircularProgressIndicator();
          default:
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final user = snapshot.data;
              return AppBar(
                centerTitle: true,
                title: user != null ? Text(user.userName) : SizedBox(),
                leading: Icon(Icons.store),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.exit_to_app,
                        )),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
