import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../widgets/residence_card.dart';

class FDPIResidencesScreen extends StatelessWidget {
  const FDPIResidencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fdpiRepository = context.read<FdpiRepository>();

    return BlocProvider(
      create: (context) {
        return ResidenceBloc(fdpiRepository: fdpiRepository)
          ..add(LoadResidence("", "", ""));
      },
      child: ResidenceListView(),
    );
  }
}

class ResidenceListView extends StatelessWidget {
  const ResidenceListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFD9FF),
        title: const Text(
          'Fasindo App',
          style: TextStyle(
            color: Color(0xFF1C3FAA),
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF1C3FAA), weight: 3),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        color: const Color(0xFFEAF1FF),
        child: BlocConsumer<ResidenceBloc, ResidenceState>(
          listener: (context, state) {
            if (state is ResidenceLoadFailure) {
              if (state.exception is UnauthorizedException) {
                context.read<AuthenticationBloc>().add(
                  SetAuthenticationStatus(isAuthenticated: false),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      "Session Anda telah habis. Silakan login kembali",
                    ),
                    duration: Duration(seconds: 5),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Color(0xffEB5757),
                  ),
                );
                Navigator.popUntil(context, ModalRoute.withName('/'));
                return;
              }

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
            }
          },
          builder: (context, state) {
            if (state is ResidenceLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ResidenceLoadSuccess) {
              return MasonryGridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                shrinkWrap: true,
                itemCount: state.residences.length,
                itemBuilder: (BuildContext context, int index) {
                  return ResidenceCard(
                    detailResidence: state.residences[index],
                  );
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
