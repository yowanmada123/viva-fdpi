import 'package:fdpi_app/bloc/fdpi/site/site_bloc.dart';
import 'package:fdpi_app/data/repository/spk_repository.dart';
import 'package:fdpi_app/models/QC/SPK.dart';
import 'package:fdpi_app/models/fdpi/house_item.dart';
import 'package:fdpi_app/models/fdpi/residence.dart';
import 'package:fdpi_app/presentation/SPK/spk_progress_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../bloc/QC/spk_list/spk_list_bloc.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/fdpi/house_item/house_item_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/site.dart';

class SpkListScreen extends StatelessWidget {
  const SpkListScreen({super.key});

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
      child: const _SpkListScreenContent(),
    );
  }
}

class _SpkListScreenContent extends StatelessWidget {
  const _SpkListScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPK List')),
      body: const _SpkListBody(),
    );
  }
}

class _SpkListBody extends StatefulWidget {
  const _SpkListBody({super.key});

  @override
  State<_SpkListBody> createState() => _SpkListBodyState();
}

class _SpkListBodyState extends State<_SpkListBody> {
  final _formKey = GlobalKey<FormState>();
  String? _site;
  String? _cluster;
  String? _houseItem;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xff1C3FAA),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () => _showFilterBottomSheet(context),
              child: const Text('Filter'),
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
                                SetAuthenticationStatus(isAuthenticated: false),
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
                        0: const FixedColumnWidth(150),
                        1: const FixedColumnWidth(150),
                        2: const FixedColumnWidth(120),
                        3: const FixedColumnWidth(130),
                      },
                      children: [
                        TableRow(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 194, 194, 194),
                          ),
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'SPK ID',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'House Item',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Vendor',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Action',
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
                                      ? const Color.fromARGB(255, 212, 239, 255)
                                      : const Color.fromARGB(
                                        255,
                                        244,
                                        255,
                                        255,
                                      ),
                            ),
                            children: [
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    state.spkList[index].idSPK,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    state.spkList[index].houseName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: Text(
                                    state.spkList[index].vendorName,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 2.0,
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) =>
                                                  SpkProgressListScreen(
                                                    qcTransId:
                                                        state
                                                            .spkList[index]
                                                            .qcTransId,
                                                  ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    );
                  }
                  return Container(
                    child: Center(
                      child: Text(
                        'Mohon terlebih dahulu memilih site dan cluster',
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    // Get the BLoC instances before showing the bottom sheet
    final siteBloc = BlocProvider.of<SiteBloc>(context);
    final residenceBloc = BlocProvider.of<ResidenceBloc>(context);
    final houseItemBloc = BlocProvider.of<HouseItemBloc>(context);
    final spkListBloc = BlocProvider.of<SpkListBloc>(context);

    // Create a local state manager for the bottom sheet

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        String? localSite = _site;
        String? localCluster = _cluster;
        String? localHouseItem = _houseItem;
        return MultiBlocProvider(
          providers: [
            BlocProvider.value(value: siteBloc),
            BlocProvider.value(value: residenceBloc),
            BlocProvider.value(value: houseItemBloc),
            BlocProvider.value(value: spkListBloc),
          ],
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setModalState) {
              return Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                decoration: const BoxDecoration(color: Colors.white),
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        BlocBuilder<SiteBloc, SiteState>(
                          builder: (context, state) {
                            if (state is SiteLoadedSuccess) {
                              return DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Site',
                                ),
                                value: localSite,
                                items:
                                    state.sites.map((Site item) {
                                      return DropdownMenuItem<String>(
                                        value: item.idSite,
                                        child: Text(item.siteName),
                                      );
                                    }).toList(),
                                onChanged: (value) {
                                  if (value != null) {
                                    setModalState(() {
                                      localSite = value;
                                      localCluster = null;
                                    });
                                    context.read<ResidenceBloc>().add(
                                      LoadResidence("", "", value, ""),
                                    );
                                  }
                                },
                              );
                            }
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Site'),
                              items: [],
                              onChanged: null,
                            );
                          },
                        ),

                        const SizedBox(height: 16),
                        BlocBuilder<ResidenceBloc, ResidenceState>(
                          builder: (context, state) {
                            if (state is ResidenceLoadSuccess) {
                              // Ensure selected cluster exists in current list
                              final validCluster =
                                  state.residences.any(
                                        (r) => r.idCluster == localCluster,
                                      )
                                      ? localCluster
                                      : null;

                              return DropdownButtonFormField<String>(
                                decoration: const InputDecoration(
                                  labelText: 'Cluster',
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
                                  setModalState(() {
                                    localCluster = value;
                                  });
                                },
                              );
                            }
                            return DropdownButtonFormField<String>(
                              decoration: InputDecoration(labelText: 'Cluster'),
                              items: [],
                              onChanged: null,
                            );
                          },
                        ),

                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: FilledButton(
                                style: FilledButton.styleFrom(
                                  backgroundColor: Colors.grey,
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Close'),
                              ),
                            ),

                            const SizedBox(width: 16),

                            Expanded(
                              child: FilledButton(
                                onPressed: () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    setState(() {
                                      _site = localSite;
                                      _cluster = localCluster;
                                    });

                                    context.read<SpkListBloc>().add(
                                      GetSPKList(
                                        idSite: _site ?? '',
                                        idCluster: _cluster ?? '',
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text('Filter'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
