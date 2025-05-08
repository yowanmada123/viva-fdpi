import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/QC/spr_list/spr_list_bloc.dart';
import '../../bloc/auth/authentication/authentication_bloc.dart';
import '../../bloc/fdpi/house_item/house_item_bloc.dart';
import '../../bloc/fdpi/residence/residence_bloc.dart';
import '../../bloc/fdpi/site/site_bloc.dart';
import '../../data/repository/fdpi_repository.dart';
import '../../data/repository/spk_repository.dart';
import '../../models/errors/custom_exception.dart';
import '../../models/fdpi/residence.dart';
import '../../models/fdpi/site.dart';
import 'spk_progress_list_screen.dart';

class SprListScreen extends StatelessWidget {
  const SprListScreen({super.key});

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
                  SprListBloc(spkRepository: context.read<SPKRepository>()),
        ),
      ],
      child: const _SprListScreenContent(),
    );
  }
}

class _SprListScreenContent extends StatelessWidget {
  const _SprListScreenContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SPR List')),
      body: const _SprListBody(),
    );
  }
}

class _SprListBody extends StatefulWidget {
  const _SprListBody({super.key});

  @override
  State<_SprListBody> createState() => _SprListBodyState();
}

class _SprListBodyState extends State<_SprListBody> {
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
              child: BlocConsumer<SprListBloc, SprListState>(
                listener:
                    (context, state) => {
                      if (state is SprListLoadFailure)
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
                  if (state is SprListLoadSuccess) {
                    return Table(
                      columnWidths: {
                        0: const FixedColumnWidth(150),
                        1: const FixedColumnWidth(150),
                        2: const FixedColumnWidth(120),
                        3: const FixedColumnWidth(130),
                        4: const FixedColumnWidth(100),
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
                                'Site Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Cluster Name',
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
                                'Transaction ID',
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
                        ...List.generate(state.sprList.length, (index) {
                          return TableRow(
                            key: ValueKey(state.sprList[index].siteName),
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
                                    state.sprList[index].siteName,
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
                                    state.sprList[index].clusterName,
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
                                    state.sprList[index].houseName,
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
                                    state.sprList[index].qcTransId,
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
                                                  const SpkProgressListScreen(),
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
    final sprListBloc = BlocProvider.of<SprListBloc>(context);

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
            BlocProvider.value(value: sprListBloc),
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
                                    print("Masuk kamuuu");
                                    setState(() {
                                      _site = localSite;
                                      _cluster = localCluster;
                                    });

                                    context.read<SprListBloc>().add(
                                      GetSPRList(
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
