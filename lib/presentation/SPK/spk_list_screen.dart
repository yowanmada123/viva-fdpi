import 'package:fdpi_app/presentation/widgets/ui/dropdown_with_clear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/house_item_with_spk/house_item_with_spk_bloc.dart';
import '../../bloc/QC/spk_list/spk_list_bloc.dart';
import '../../bloc/QC/vendor_has_spk/vendor_has_spk_bloc.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../bloc/fdpi/site/site_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/house_item_spk.dart';
import '../../models/fdpi/residence.dart';
import '../../models/fdpi/site.dart';
import '../../models/master/vendor.dart';
import '../widgets/group_spk_list.dart';
import 'spk_checklist_screen.dart';

class SpkListScreen extends StatelessWidget {
  final String title;
  const SpkListScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  SiteBloc(fdpiRepository: context.read<FdpiRepository>())
                    ..add(GetSites("", "", "")),
        ),
        BlocProvider(
          create:
              (context) =>
                  ResidenceBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
        BlocProvider(
          create:
              (context) => HouseItemWithSpkBloc(
                spkRepository: context.read<SPKRepository>(),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  VendorHasSpkBloc(spkRepository: context.read<SPKRepository>())
                    ..add(GetVendorHasSpkEvent()),
        ),
        BlocProvider(
          create:
              (context) =>
                  SpkListBloc(spkRepository: context.read<SPKRepository>()),
        ),
      ],
      child: _SpkListScreenContent(title: title),
    );
  }
}

class _SpkListScreenContent extends StatelessWidget {
  final String title;
  const _SpkListScreenContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const _SpkListBody(),
    );
  }
}

class _SpkListBody extends StatefulWidget {
  const _SpkListBody();

  @override
  State<_SpkListBody> createState() => _SpkListBodyState();
}

class _SpkListBodyState extends State<_SpkListBody> {
  String? _site;
  String? _cluster;
  String? _houseId;
  String? _vendorId;

  navigateToSPKProgressListScreen(BuildContext context, String qcTransId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewSpkChecklistScreen(qcTransId: qcTransId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              children: [
                // Filter form section without fixed height
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.w,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vendor dropdown
                      Row(
                        children: [
                          Text('Vendor'),
                          SizedBox(width: 2.w),
                          Text('*', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      BlocBuilder<VendorHasSpkBloc, VendorHasSpkState>(
                        builder: (context, state) {
                          return DropdownWithClear<String>(
                            value: _vendorId,
                            items:
                                state is VendorHasSpkLoadedSuccess
                                    ? state.vendors.map((Vendor item) {
                                      return DropdownMenuItem<String>(
                                        value: item.vendorId,
                                        child: Text(item.vendorName),
                                      );
                                    }).toList()
                                    : [],
                            hintText: 'Pilih Vendor',
                            onChanged: (value) {
                              setState(() {
                                _vendorId = value;
                              });
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16.w),

                      // Site dropdown
                      Row(
                        children: [
                          Text('Site'),
                          SizedBox(width: 2.w),
                          Text('*', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                      BlocBuilder<SiteBloc, SiteState>(
                        builder: (context, state) {
                          return DropdownWithClear<String>(
                            value: _site,
                            items:
                                state is SiteLoadedSuccess
                                    ? state.sites.map((Site item) {
                                      return DropdownMenuItem<String>(
                                        value: item.idSite,
                                        child: Text(item.siteName),
                                      );
                                    }).toList()
                                    : [],
                            hintText: 'Pilih Site',
                            onChanged: (value) {
                              setState(() {
                                _site = value;
                                _cluster = null;
                                _houseId = null;
                              });

                              if (value != null) {
                                context.read<ResidenceBloc>().add(
                                  LoadResidence("", "", value, ""),
                                );
                              } else {
                                context.read<ResidenceBloc>().add(
                                  ResetResidenceEvent(),
                                );
                                context.read<HouseItemWithSpkBloc>().add(
                                  ResetHouseItemWithSpkEvent(),
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16.w),

                      // Cluster dropdown
                      Row(children: [Text('Cluster'), SizedBox(width: 2.w)]),
                      BlocBuilder<ResidenceBloc, ResidenceState>(
                        builder: (context, state) {
                          return DropdownWithClear<String>(
                            value: _cluster,
                            items:
                                state is ResidenceLoadSuccess
                                    ? state.residences.map((Residence item) {
                                      return DropdownMenuItem<String>(
                                        value: item.idCluster,
                                        child: Text(item.clusterName),
                                      );
                                    }).toList()
                                    : [],
                            hintText: 'Pilih Cluster',
                            onChanged: (value) {
                              setState(() {
                                _cluster = value;
                                _houseId = null;
                              });

                              if (value != null) {
                                context.read<HouseItemWithSpkBloc>().add(
                                  GetHouseItemWithSpkEvent(
                                    idSite: _site!,
                                    idCluster: value,
                                    docType: "SPK",
                                    activeFlag: "Y",
                                  ),
                                );
                              } else {
                                context.read<HouseItemWithSpkBloc>().add(
                                  ResetHouseItemWithSpkEvent(),
                                );
                              }
                            },
                          );
                        },
                      ),
                      SizedBox(height: 16.w),

                      // House dropdown
                      Row(children: [Text('House Item'), SizedBox(width: 2.w)]),
                      BlocConsumer<HouseItemWithSpkBloc, HouseItemWithSpkState>(
                        listener: (context, state) {
                          if (state is HouseItemWithSpkLoaded) {
                            if (state.items.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Data house item not found'),
                                  backgroundColor: Colors.red,
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            }
                          }
                        },
                        builder: (context, state) {
                          return DropdownWithClear<String>(
                            value: _houseId,
                            items:
                                state is HouseItemWithSpkLoaded
                                    ? state.items.map((HouseItemSpk item) {
                                      return DropdownMenuItem<String>(
                                        value: item.idHouse,
                                        child: Text(item.houseName),
                                      );
                                    }).toList()
                                    : [],
                            hintText: 'Pilih Rumah',
                            onChanged: (value) {
                              setState(() {
                                _houseId = value;
                              });
                            },
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xff1C3FAA),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          if (_site == null && _vendorId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Silakan pilih site atau vendor terlebih dahulu.",
                                ),
                              ),
                            );
                            return;
                          }

                          context.read<SpkListBloc>().add(
                            GetSPKList(
                              idVendor: _vendorId ?? '',
                              idSite: _site ?? '',
                              idCluster: _cluster ?? '',
                              idHouse: _houseId ?? '',
                            ),
                          );
                        },
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Center(
                            child: Text(
                              'Search',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.w),
                // Results section with flexible scrolling
                BlocConsumer<SpkListBloc, SpkListState>(
                  listener: (context, state) {
                    if (state is SpkListLoadFailure) {
                      if (state.error is UnauthorizedException) {
                        context.read<AuthenticationBloc>().add(
                          SetAuthenticationStatus(isAuthenticated: false),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Session Anda telah habis. Silakan login kembali",
                            ),
                            duration: const Duration(seconds: 5),
                          ),
                        );
                      }
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.message)));
                    }
                  },
                  builder: (context, state) {
                    if (state is SpkListLoadSuccess) {
                      return GroupedSPKList(groupedSPK: state.spkList);
                    } else if (state is SpkListLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return const Center(
                      child: Text(
                        'Mohon terlebih dahulu memilih site dan cluster',
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
