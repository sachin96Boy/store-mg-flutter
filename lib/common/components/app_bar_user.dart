import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:store_mg_fl/features/auth/models/user_model.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';
import 'package:store_mg_fl/features/auth/views/auth_screen.dart';

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
                title: user != null
                    ? Text(user.userName)
                    : ElevatedButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacementNamed(AuthScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                            elevation: 8.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            backgroundColor:
                                ShadTheme.of(context).colorScheme.secondary),
                        child: Text(
                          'Register',
                          style: ShadTheme.of(context).textTheme.h3,
                        ),
                      ),
                leading: user != null ? Icon(Icons.store) : SizedBox(),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 12.0),
                    child: user != null
                        ? IconButton(
                            onPressed: () {
                              ref.read(authResponseProvider.notifier).logOut();
                            },
                            icon: Icon(
                              Icons.exit_to_app,
                            ),
                          )
                        : SizedBox(),
                  ),
                ],
              );
            }
        }
      },
    );
  }
}
