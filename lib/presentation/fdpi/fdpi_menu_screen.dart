// screens/location_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/auth/logout/logout_bloc.dart';
import '../../bloc/fdpi/location/location_bloc.dart';
import '../../data/repository/auth_repository.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/city.dart';
import '../../models/fdpi/province.dart';
import '../../models/fdpi/status.dart';
import '../../presentation/fdpi/fdpi_residences_screen.dart';
import '../../presentation/widgets/base_pop_up.dart';

class FDPIMenuScreen extends StatelessWidget {
  const FDPIMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final fdpiRepository = context.read<FdpiRepository>();
    final authRepository = context.read<AuthRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  LocationBloc(fdpiRepository: fdpiRepository)
                    ..add(LoadProvinces())
                    ..add(LoadStatusResidence()),
        ),
        BlocProvider(create: (context) => LogoutBloc(authRepository)),
      ],
      child: const FDPIMenuView(),
    );
  }
}

class FDPIMenuView extends StatelessWidget {
  const FDPIMenuView({super.key});

  VoidCallback _navigateToFdpiResidenceScreen(
    BuildContext context,
    LocationState state,
  ) {
    // Handle form submission
    final province = state.selectedProvince?.idProvince ?? "";
    final city = state.selectedCity?.idCity ?? "";
    final status = state.selectedStatus?.name ?? "Aktif";

    return () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => FDPIResidencesScreen()),
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1E4694),
        title: const Text('FDPI', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(
          color: Colors.white, // This makes back button white
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: BlocConsumer<LogoutBloc, LogoutState>(
              listener: (context, state) {
                if (state is LogoutFailure) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Logout Not Success")));
                } else if (state is LogoutSuccess) {
                  print("Logout Success");
                  context.read<AuthenticationBloc>().add(
                    SetAuthenticationStatus(isAuthenticated: false),
                  );
                  Navigator.popUntil(context, ModalRoute.withName('/'));
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
                            context.read<LogoutBloc>().add(LogoutPressed());
                          },
                          question: "Apakah anda yakin ingin logout?",
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.logout),
                );
              },
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocConsumer<LocationBloc, LocationState>(
          listener: (context, state) {
            if (state.status == LocationStatus.failure) {
              if (state.exception is UnauthorizedException) {
                context.read<AuthenticationBloc>().add(
                  SetAuthenticationStatus(isAuthenticated: false),
                );
              }

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage ?? 'Error')),
              );
            }
          },
          builder: (context, state) {
            if (state.status == LocationStatus.initial ||
                state.status == LocationStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                // Province Dropdown
                _buildProvinceDropdown(context, state),
                const SizedBox(height: 20),
                // City Dropdown
                _buildCityDropdown(context, state),
                const SizedBox(height: 20),
                // Status Dropdown
                _buildStatusDropdown(context, state),
                const SizedBox(height: 20),
                // Submit Button
                ElevatedButton(
                  onPressed: _navigateToFdpiResidenceScreen(context, state),
                  child: const Text('Submit'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProvinceDropdown(BuildContext context, LocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Province', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<Province>(
          isExpanded: true,
          value: state.selectedProvince,
          hint: const Text(
            'Select Province',
            style: TextStyle(color: Colors.grey),
          ),
          items:
              state.provinces.map((province) {
                return DropdownMenuItem<Province>(
                  value: province,
                  child: Text(province.province),
                );
              }).toList(),
          onChanged: (province) {
            context.read<LocationBloc>().add(ProvinceChanged(province));
          },
        ),
      ],
    );
  }

  Widget _buildCityDropdown(BuildContext context, LocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('City', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<City>(
          isExpanded: true,
          value: state.selectedCity,
          hint: const Text('Select City', style: TextStyle(color: Colors.grey)),
          items:
              state.cities.map((city) {
                return DropdownMenuItem<City>(
                  value: city,
                  child: Text(city.cityName),
                );
              }).toList(),
          onChanged:
              state.selectedProvince == null
                  ? null
                  : (city) {
                    context.read<LocationBloc>().add(CityChanged(city));
                  },
        ),
        if (state.selectedProvince != null && state.cities.isEmpty)
          const Text(
            'No cities available for this province',
            style: TextStyle(color: Colors.red),
          ),
      ],
    );
  }

  Widget _buildStatusDropdown(BuildContext context, LocationState state) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
        DropdownButton<Status>(
          isExpanded: true,
          value: state.selectedStatus,
          hint: const Text(
            'Select Status',
            style: TextStyle(color: Colors.grey),
          ),
          items:
              state.statuses.map((status) {
                return DropdownMenuItem<Status>(
                  value: status,
                  child: Text(status.name),
                );
              }).toList(),
          onChanged: (status) {
            context.read<LocationBloc>().add(StatusChanged(status));
          },
        ),
      ],
    );
  }
}
