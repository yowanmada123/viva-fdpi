import 'dart:developer';

import 'package:fdpi_app/bloc/information/spk_list/spk_list_bloc.dart';
import 'package:fdpi_app/bloc/information/spk_type/spk_type_bloc.dart';
import 'package:fdpi_app/models/fdpi/house_item.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk.dart';
import 'package:fdpi_app/models/fdpi/spk_review/spk_type.dart';
import 'package:fdpi_app/presentation/information/spk_detail_screen.dart';
import 'package:fdpi_app/presentation/widgets/ui/dropdown_with_clear.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../bloc/QC/cleaning_list/cleaning_list_bloc.dart';
import '../../../bloc/QC/house_item_with_spk/house_item_with_spk_bloc.dart';
import '../../../bloc/auth/authentication/authentication_bloc.dart';
import '../../../bloc/fdpi/residence/residence_bloc.dart';
import '../../../bloc/fdpi/site/site_bloc.dart';
// import '../../../bloc/information/spk_type/spk_type_bloc.dart';
import 'package:fdpi_app/bloc/fdpi/house_item/house_item_bloc.dart';

import '../../../data/repository/fdpi_repository.dart';
import '../../../data/repository/spk_repository.dart';
import '../../../models/errors/custom_exception.dart';
import '../../../models/fdpi/residence.dart';
import '../../../models/fdpi/site.dart';

class ViewSPKScreen extends StatelessWidget {
  final String title;
  const ViewSPKScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    log('Access to lib/presentation/clean/cleaning_list_screen.dart');
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
                  SpkTypeBloc(fdpiRepository: context.read<FdpiRepository>())
                    ..add(const GetAllLookupData()), // GANTI: dari GetSpkTypes
        ),
        BlocProvider(
          create:
              (context) =>
                  ResidenceBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  SpkListBloc(spkRepository: context.read<SPKRepository>()),
        ),
        BlocProvider(
          create:
              (context) =>
                  HouseItemBloc(fdpiRepository: context.read<FdpiRepository>()),
        ),
      ],
      child: _ViewSPKScreenContent(title: title),
    );
  }
}

class _ViewSPKScreenContent extends StatelessWidget {
  final String title;
  const _ViewSPKScreenContent({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const _CleaningListBody(),
    );
  }
}

class _CleaningListBody extends StatefulWidget {
  const _CleaningListBody();

  @override
  State<_CleaningListBody> createState() => _CleaningListBodyState();
}

class _CleaningListBodyState extends State<_CleaningListBody> {
  String? _site;
  String? _spkType;
  String? _cluster;
  String? _houseId;

  void _navigateToSpkDetail(
    BuildContext context,
    Spk spk,
    String employeeName,
    String contractorName,
    String spkTypeLabel,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => SpkDetailScreen(
              spk: spk,
              employeeName: employeeName,
              contractorName: contractorName,
              spkTypeLabel: spkTypeLabel,
            ),
      ),
    );
  }

  Map<String, List<Spk>> _groupSpkByHouseName(List<Spk> items) {
    final grouped = <String, List<Spk>>{};

    for (var item in items) {
      final houseName = item.houseName; // B.27, B.28, dll
      if (!grouped.containsKey(houseName)) {
        grouped[houseName] = [];
      }
      grouped[houseName]!.add(item);
    }

    return grouped;
  }

  Widget _buildTableHeaderCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.all(8.w),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.w),
        child: Text(
          text,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 11),
        ),
      ),
    );
  }

  String _formatAmount(String amt) {
    final value = double.tryParse(amt);
    if (value == null || amt.isEmpty) return amt;
    final intValue = value.toInt();
    return intValue.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]},',
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
                              // context.read<HouseItemWithSpkBloc>().add(
                              //   ResetHouseItemWithSpkEvent(),
                              // );
                            }
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.w),

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
                              context.read<HouseItemBloc>().add(
                                GetHouseItem("", "", _site!, value, "", "", ""),
                              );
                            } else {
                              context.read<HouseItemWithSpkBloc>().add(
                                ResetHouseItemWithSpkEvent(),
                              );
                            }
                          },
                          // dropdownWidth: double.infinity,
                        );
                      },
                    ),
                    SizedBox(height: 16.w),
                    Row(children: [Text('House Name'), SizedBox(width: 2.w)]),
                    BlocConsumer<HouseItemBloc, HouseItemState>(
                      listener: (context, state) {
                        if (state is HouseItemLoadSuccess) {
                          if (state.houseItems.isEmpty) {
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
                              state is HouseItemLoadSuccess
                                  ? state.houseItems.map((HouseItem item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id_house,
                                      child: Text(item.house_name),
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
                    SizedBox(height: 16.w),
                    Row(children: [Text('Tipe SPK'), SizedBox(width: 2.w)]),
                    BlocBuilder<SpkTypeBloc, SpkTypeState>(
                      builder: (context, state) {
                        return DropdownWithClear<String>(
                          value: _spkType,
                          items:
                              state is SpkTypeLoadedSuccess
                                  ? state.spkTypes.map((SpkType item) {
                                    return DropdownMenuItem<String>(
                                      value: item.str1,
                                      child: Text(item.str2),
                                    );
                                  }).toList()
                                  : [],
                          hintText: 'Pilih Tipe SPK',
                          onChanged: (value) {
                            setState(() {
                              _spkType = value;
                            });
                          },
                        );
                      },
                    ),
                    SizedBox(height: 16.w),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: const Color(0xff1C3FAA),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_site == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Site belum dipilih!"),
                            ),
                          );
                          return;
                        }

                        context.read<SpkListBloc>().add(
                          GetSpkList(
                            idSite: _site ?? '',
                            idCluster: _cluster ?? '',
                            idHouse: _houseId ?? '',
                            spkType: _spkType ?? '',
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
              const SizedBox(height: 24),
              Column(
                children: [
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
                              duration: Duration(seconds: 5),
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
                        final groupedSpk = _groupSpkByHouseName(state.spkList);
                        // TAMBAH: Ambil SpkTypeBloc untuk mengakses helper methods
                        final spkTypeBloc = context.read<SpkTypeBloc>();

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: groupedSpk.length,
                          itemBuilder: (context, index) {
                            final houseName = groupedSpk.keys.elementAt(index);
                            final spkItems = groupedSpk[houseName]!;

                            return ExpansionTile(
                              title: Text(
                                houseName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Table(
                                    columnWidths: const {
                                      0: FixedColumnWidth(50),
                                      1: FixedColumnWidth(
                                        150,
                                      ), // Lebih lebar untuk nama
                                      2: FixedColumnWidth(
                                        150,
                                      ), // Lebih lebar untuk nama
                                      3: FixedColumnWidth(120),
                                      4: FixedColumnWidth(130),
                                      5: FixedColumnWidth(120),
                                      6: FixedColumnWidth(130),
                                      7: FixedColumnWidth(130),
                                    },
                                    children: [
                                      TableRow(
                                        decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                        ),
                                        children: [
                                          _buildTableHeaderCell(''),
                                          _buildTableHeaderCell('Pihak 1'),
                                          _buildTableHeaderCell('Pihak 2'),
                                          _buildTableHeaderCell('Type'),
                                          _buildTableHeaderCell(
                                            'Total Contract',
                                          ),
                                          _buildTableHeaderCell('Remark'),
                                          _buildTableHeaderCell(
                                            'Date Approve 1',
                                          ),
                                          _buildTableHeaderCell(
                                            'Date Approve 2',
                                          ),
                                        ],
                                      ),
                                      ...List.generate(spkItems.length, (
                                        rowIndex,
                                      ) {
                                        final spk = spkItems[rowIndex];
                                        return TableRow(
                                          decoration: BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.grey,
                                                width: 1,
                                              ),
                                            ),
                                            color:
                                                rowIndex % 2 == 0
                                                    ? Colors.white
                                                    : Colors.grey[50],
                                          ),
                                          children: [
                                            TableCell(
                                              verticalAlignment:
                                                  TableCellVerticalAlignment
                                                      .middle,
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 8.w,
                                                  vertical: 8.w,
                                                ),
                                                child: IconButton(
                                                  onPressed: () {
                                                    _navigateToSpkDetail(
                                                      context,
                                                      spk,
                                                      spk
                                                              .namaEmployee
                                                              .isNotEmpty
                                                          ? spk.namaEmployee
                                                          : spkTypeBloc
                                                              .getEmployeeName(
                                                                spk.pihak1,
                                                              ),
                                                      spk
                                                              .namaContractor
                                                              .isNotEmpty
                                                          ? spk.namaContractor
                                                          : spkTypeBloc
                                                              .getContractorName(
                                                                spk.pihak2,
                                                              ),
                                                      spkTypeBloc
                                                          .getSpkTypeLabel(
                                                            spk.spkType,
                                                          ),
                                                    );
                                                  },
                                                  icon: Icon(
                                                    Icons.visibility,
                                                    color: Colors.blue,
                                                    size: 20,
                                                  ),
                                                  padding: EdgeInsets.zero,
                                                  constraints: BoxConstraints(),
                                                ),
                                              ),
                                            ),
                                            _buildTableCell(
                                              spk.namaEmployee.isNotEmpty
                                                  ? spk.namaEmployee
                                                  : spkTypeBloc.getEmployeeName(
                                                    spk.pihak1,
                                                  ),
                                            ),
                                            _buildTableCell(
                                              spk.namaContractor.isNotEmpty
                                                  ? spk.namaContractor
                                                  : spkTypeBloc
                                                      .getContractorName(
                                                        spk.pihak2,
                                                      ),
                                            ),
                                            _buildTableCell(
                                              spkTypeBloc.getSpkTypeLabel(
                                                spk.spkType,
                                              ),
                                            ),
                                            _buildTableCell(
                                              'Rp ${_formatAmount(spk.amt)}',
                                            ),
                                            _buildTableCell(
                                              spk.remarkSpk ?? '-',
                                            ),
                                            _buildTableCell(spk.dtAprv1 ?? '-'),
                                            _buildTableCell(spk.dtAprv2 ?? '-'),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 16.h),
                              ],
                            );
                          },
                        );
                      }
                      return Center(
                        child: Text(
                          'Mohon terlebih dahulu memilih site dan cluster',
                        ),
                      );
                    },
                  ),

                  // BlocConsumer<SpkListBloc, SpkListState>(
                  //   listener: (context, state) {
                  //     if (state is SpkListLoadFailure) {
                  //       if (state.error is UnauthorizedException) {
                  //         context.read<AuthenticationBloc>().add(
                  //           SetAuthenticationStatus(isAuthenticated: false),
                  //         );
                  //         ScaffoldMessenger.of(context).showSnackBar(
                  //           SnackBar(
                  //             content: Text(
                  //               "Session Anda telah habis. Silakan login kembali",
                  //             ),
                  //             duration: Duration(seconds: 5),
                  //           ),
                  //         );
                  //       }
                  //       ScaffoldMessenger.of(
                  //         context,
                  //       ).showSnackBar(SnackBar(content: Text(state.message)));
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     if (state is SpkListLoadSuccess) {
                  //       final groupedSpk = _groupSpkByHouseName(state.spkList);

                  //       return ListView.builder(
                  //         shrinkWrap: true,
                  //         physics: NeverScrollableScrollPhysics(),
                  //         itemCount: groupedSpk.length,
                  //         itemBuilder: (context, index) {
                  //           final houseName = groupedSpk.keys.elementAt(index);
                  //           final spkItems = groupedSpk[houseName]!;

                  //           return ExpansionTile(
                  //             title: Text(
                  //               houseName,
                  //               style: TextStyle(
                  //                 fontWeight: FontWeight.bold,
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //             children: [
                  //               // Tabel hanya muncul saat diklik
                  //               SingleChildScrollView(
                  //                 scrollDirection: Axis.horizontal,
                  //                 child: Table(
                  //                   columnWidths: const {
                  //                     0: FixedColumnWidth(50),
                  //                     1: FixedColumnWidth(100),
                  //                     2: FixedColumnWidth(100),
                  //                     3: FixedColumnWidth(80),
                  //                     4: FixedColumnWidth(130),
                  //                     5: FixedColumnWidth(120),
                  //                     6: FixedColumnWidth(130),
                  //                     7: FixedColumnWidth(130),
                  //                   },
                  //                   children: [
                  //                     // Header
                  //                     TableRow(
                  //                       decoration: BoxDecoration(
                  //                         color: Colors.grey[300],
                  //                       ),
                  //                       children: [
                  //                         _buildTableHeaderCell(''),
                  //                         _buildTableHeaderCell('Pihak 1'),
                  //                         _buildTableHeaderCell('Pihak 2'),
                  //                         _buildTableHeaderCell('Type'),
                  //                         _buildTableHeaderCell(
                  //                           'Total Contract',
                  //                         ),
                  //                         _buildTableHeaderCell('Remark'),
                  //                         _buildTableHeaderCell(
                  //                           'Date Approve 1',
                  //                         ),
                  //                         _buildTableHeaderCell(
                  //                           'Date Approve 2',
                  //                         ),
                  //                       ],
                  //                     ),
                  //                     // Data Rows
                  //                     ...List.generate(spkItems.length, (
                  //                       rowIndex,
                  //                     ) {
                  //                       final spk = spkItems[rowIndex];
                  //                       return TableRow(
                  //                         decoration: BoxDecoration(
                  //                           border: Border(
                  //                             bottom: BorderSide(
                  //                               color: Colors.grey,
                  //                               width: 1,
                  //                             ),
                  //                           ),
                  //                           color:
                  //                               rowIndex % 2 == 0
                  //                                   ? Colors.white
                  //                                   : Colors.grey[50],
                  //                         ),
                  //                         children: [
                  //                           TableCell(
                  //                             verticalAlignment:
                  //                                 TableCellVerticalAlignment
                  //                                     .middle,
                  //                             child: Padding(
                  //                               padding: EdgeInsets.symmetric(
                  //                                 horizontal: 8.w,
                  //                                 vertical: 8.w,
                  //                               ),
                  //                               child: IconButton(
                  //                                 onPressed: () {
                  //                                   navigateToSPRProgressListScreen(
                  //                                     context,
                  //                                     spk.qcTransId,
                  //                                   );
                  //                                 },
                  //                                 icon: Icon(
                  //                                   Icons.visibility,
                  //                                   color: Colors.blue,
                  //                                   size: 20,
                  //                                 ),
                  //                                 padding: EdgeInsets.zero,
                  //                                 constraints: BoxConstraints(),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           _buildTableCell(spk.pihak1),
                  //                           _buildTableCell(spk.pihak2),
                  //                           _buildTableCell(spk.spkType),
                  //                           _buildTableCell('Rp ${spk.amt}'),
                  //                           _buildTableCell(spk.remark ?? '-'),
                  //                           _buildTableCell(spk.dtAprv1 ?? '-'),
                  //                           _buildTableCell(spk.dtAprv2 ?? '-'),
                  //                         ],
                  //                       );
                  //                     }),
                  //                   ],
                  //                 ),
                  //               ),
                  //               SizedBox(height: 16.h),
                  //             ],
                  //           );
                  //         },
                  //       );
                  //     }
                  //     return Center(
                  //       child: Text(
                  //         'Mohon terlebih dahulu memilih site dan cluster',
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
