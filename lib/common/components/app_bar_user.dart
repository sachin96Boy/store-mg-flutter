import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:store_mg_fl/features/auth/providers/auth_provider.dart';
import 'package:store_mg_fl/features/auth/views/auth_screen.dart';
import 'package:store_mg_fl/features/cart/views/cart_screen.dart';

class AppBarUser extends StatefulHookConsumerWidget {
  const AppBarUser({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AppBarUserState();
}

class _AppBarUserState extends ConsumerState<AppBarUser> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authResponseProvider);

    return auth.when(
      data: (data) {
        final response = data;
        return AppBar(
          centerTitle: true,
          title: response.user != null
              ? Text(response.user!.userName)
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
          leading: response.user != null
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(CartScreen.routeName);
                  },
                  icon: Icon(Icons.store))
              : SizedBox(),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 12.0),
              child: response.user != null
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
      },
      error: (error, stackTrace) {
        return Text(error.toString());
      },
      loading: () => Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
