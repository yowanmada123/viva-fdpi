import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/spk_list/spk_list_bloc.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/fdpi/house_item/house_item_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../bloc/fdpi/site/site_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/house_item.dart';
import '../../models/fdpi/residence.dart';
import '../../models/fdpi/site.dart';
import 'spk_checklist_screen.dart';
// import 'spk_progress_list_screen.dart';

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
              (context) =>
                  HouseItemBloc(fdpiRepository: context.read<FdpiRepository>()),
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
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text('Site'),
                        SizedBox(width: 2.w),
                        Text('(*)', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    BlocBuilder<SiteBloc, SiteState>(
                      builder: (context, state) {
                        if (state is SiteLoadedSuccess) {
                          return DropdownButtonFormField<String>(
                            decoration: const InputDecoration(hintText: 'Site'),
                            value: _site,
                            items:
                                state.sites.map((Site item) {
                                  return DropdownMenuItem<String>(
                                    value: item.idSite,
                                    child: Text(item.siteName),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              if (value != null) {
                                setState(() {
                                  _site = value;
                                  _cluster = null;
                                  _houseId = null;
                                });
                                context.read<ResidenceBloc>().add(
                                  LoadResidence("", "", value, ""),
                                );
                              }
                            },
                          );
                        }
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(hintText: 'Site'),
                          items: [],
                          onChanged: null,
                        );
                      },
                    ),
                    SizedBox(height: 16.w),

                    Row(
                      children: [
                        Text('Cluster'),
                        SizedBox(width: 2.w),
                        Text('(*)', style: TextStyle(color: Colors.red)),
                      ],
                    ),
                    BlocBuilder<ResidenceBloc, ResidenceState>(
                      builder: (context, state) {
                        if (state is ResidenceLoadSuccess) {
                          final validCluster =
                              state.residences.any(
                                    (r) => r.idCluster == _cluster,
                                  )
                                  ? _cluster
                                  : null;

                          return DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: 'Cluster',
                            ),
                            value: validCluster,
                            items:
                                state.residences.map((Residence item) {
                                  return DropdownMenuItem<String>(
                                    value: item.idCluster,
                                    child: Text(item.clusterName),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _cluster = value;
                                _houseId = null;
                              });

                              context.read<HouseItemBloc>().add(
                                GetHouseItem(
                                  "",
                                  "",
                                  _site!,
                                  value!,
                                  "",
                                  "",
                                  "",
                                ),
                              );
                            },
                          );
                        }
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(hintText: 'Cluster'),
                          items: [],
                          onChanged: null,
                        );
                      },
                    ),
                    SizedBox(height: 16.w),
                    Row(children: [Text('House Item'), SizedBox(width: 2.w)]),
                    BlocBuilder<HouseItemBloc, HouseItemState>(
                      builder: (context, state) {
                        if (state is HouseItemLoadSuccess) {
                          final validCluster =
                              state.houseItems.any(
                                    (r) => r.id_house == _houseId,
                                  )
                                  ? _houseId
                                  : null;

                          return DropdownButtonFormField<String>(
                            decoration: const InputDecoration(
                              hintText: 'House Item',
                            ),
                            value: validCluster,
                            items:
                                state.houseItems.map((HouseItem item) {
                                  return DropdownMenuItem<String>(
                                    value: item.id_house,
                                    child: Text(item.house_name),
                                  );
                                }).toList(),
                            onChanged: (value) {
                              setState(() {
                                _houseId = value;
                              });
                            },
                          );
                        }
                        return DropdownButtonFormField<String>(
                          decoration: InputDecoration(hintText: 'House Item'),
                          items: [],
                          onChanged: null,
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
                        if (_site == null || _cluster == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tolong lengkapi semua data'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        context.read<SpkListBloc>().add(
                          GetSPKList(
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
              const SizedBox(height: 16),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BlocConsumer<SpkListBloc, SpkListState>(
                  listener:
                      (context, state) => {
                        if (state is SpkListLoadFailure)
                          {
                            if (state.error is UnauthorizedException)
                              {
                                context.read<AuthenticationBloc>().add(
                                  SetAuthenticationStatus(
                                    isAuthenticated: false,
                                  ),
                                ),
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Session Anda telah habis. Silakan login kembali",
                                    ),
                                    duration: Duration(seconds: 5),
                                  ),
                                ),
                              },
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.message)),
                            ),
                          },
                      },
                  builder: (context, state) {
                    if (state is SpkListLoadSuccess) {
                      return Table(
                        columnWidths: {
                          0: const FixedColumnWidth(100),
                          1: const FixedColumnWidth(150),
                          2: const FixedColumnWidth(120),
                          3: const FixedColumnWidth(100),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 236, 236, 236),
                            ),
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),

                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  'House Item',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  'Vendor',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.w),
                                child: Text(
                                  'SPK ID',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          ...List.generate(state.spkList.length, (index) {
                            return TableRow(
                              key: ValueKey(state.spkList[index].idSPK),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.grey,
                                    width: 1,
                                  ),
                                ),
                                color:
                                    index % 2 == 0
                                        ? const Color.fromARGB(
                                          255,
                                          255,
                                          255,
                                          255,
                                        )
                                        : const Color.fromARGB(
                                          255,
                                          254,
                                          255,
                                          255,
                                        ),
                              ),
                              children: [
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                      vertical: 2.w,
                                    ),
                                    child: IconButton(
                                      onPressed: () {
                                        navigateToSPKProgressListScreen(
                                          context,
                                          state.spkList[index].qcTransId,
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: GestureDetector(
                                    onTap:
                                        () => navigateToSPKProgressListScreen(
                                          context,
                                          state.spkList[index].qcTransId,
                                        ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.w,
                                      ),
                                      child: Text(
                                        state.spkList[index].houseName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: GestureDetector(
                                    onTap:
                                        () => navigateToSPKProgressListScreen(
                                          context,
                                          state.spkList[index].qcTransId,
                                        ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.w,
                                      ),
                                      child: Text(
                                        state.spkList[index].vendorName,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment:
                                      TableCellVerticalAlignment.middle,
                                  child: GestureDetector(
                                    onTap:
                                        () => navigateToSPKProgressListScreen(
                                          context,
                                          state.spkList[index].qcTransId,
                                        ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.w,
                                        vertical: 2.w,
                                      ),
                                      child: Text(
                                        state.spkList[index].idSPK,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      );
                    }
                    return Text(
                      'Mohon terlebih dahulu memilih site dan cluster',
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
