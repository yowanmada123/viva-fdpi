import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/auth/logout/logout_bloc.dart';
import 'base_pop_up.dart';

class LogOutButton extends StatelessWidget {
  const LogOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogoutBloc, LogoutState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(right: 16.0),
          // child: Icon(Icons.logout, color: Colors.white),
          child: BlocConsumer<LogoutBloc, LogoutState>(
            listener: (context, state) {
              if (state is LogoutFailure) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text("Logout Not Success")));
              } else if (state is LogoutSuccess) {
                BlocProvider.of<AuthenticationBloc>(
                  context,
                ).add(SetAuthenticationStatus(isAuthenticated: false));
              }
            },
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  showDialog<bool>(
                    context: context,
                    builder: (BuildContext childContext) {
                      return BasePopUpDialog(
                        noText: "Tidak",
                        yesText: "Ya",
                        onNoPressed: () {},
                        onYesPressed: () {
                          if (state is! LogoutLoading) {
                            context.read<LogoutBloc>().add(LogoutPressed());
                          }
                        },
                        question:
                            "Apakah Anda yakin ingin keluar dari aplikasi?",
                      );
                    },
                  );
                },
                child: Icon(Icons.logout, color: Color(0xFF1C3FAA)),
              );
            },
          ),
        );
      },
    );
  }
}
