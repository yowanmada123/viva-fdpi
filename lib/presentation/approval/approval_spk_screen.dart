// approval_screen.dart
import 'package:fdpi_app/bloc/approval_spb/approval_spb_list/approval_spb_list_bloc.dart';
import 'package:fdpi_app/bloc/approval_spb/approve_spb/approve_spb_bloc.dart';
import 'package:fdpi_app/bloc/auth/authentication/authentication_bloc.dart';
import 'package:fdpi_app/data/repository/approval_spb.dart';
import 'package:fdpi_app/models/approval_spb/spb.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/approval_spb/approval_spb_detail/approval_spb_detail_bloc.dart';
import '../../bloc/approval_spk/approval_spk_list/approval_spk_list_bloc.dart';
import '../../bloc/approval_spk/approve_spk/approve_spk_bloc.dart';
import '../../data/repository/approval_spk.dart';
import '../../models/approval_spk/approval_spk.dart';
import '../widgets/approval/approval_spb_card.dart';
import '../widgets/approval/approval_spk_card.dart';

class ApprovalSpkScreen extends StatefulWidget {
  final String title;
  const ApprovalSpkScreen({super.key, required this.title});

  @override
  ApprovalSpkScreenState createState() => ApprovalSpkScreenState();
}

class ApprovalSpkScreenState extends State<ApprovalSpkScreen> {
  final PageController _pageController = PageController();
  final List<ScrollController> _scrollControllers = [];
  int _currentPage = 0;
  bool _isAnimated = false;
  bool _initialDetailLoaded = false;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < 3; i++) {
      _scrollControllers.add(ScrollController());
    }
  }

  void _handleApproval(
    int index,
    List<ApprovalSpk> spkList,
    BuildContext context,
  ) {
    if (spkList[index].aprv1By == "" && spkList[index].rejectBy == "") {
      context.read<ApproveSpkBloc>().add(
        ApproveSpkLoad(
          idSpk: spkList[index].idSpk,
          spkType: spkList[index].spkType,
          typeAprv: "approve1",
          status: "approve",
        ),
      );
    } else {
      context.read<ApproveSpkBloc>().add(
        ApproveSpkLoad(
          idSpk: spkList[index].idSpk,
          spkType: spkList[index].spkType,
          typeAprv: "approve2",
          status: "approve",
        ),
      );
    }

    if (index >= spkList.length) return;

    setState(() {
      spkList.removeAt(index);
      if (_currentPage >= spkList.length) {
        _currentPage = spkList.length - 1;
      }
    });
  }

  void _handleReject(
    int index,
    List<ApprovalSpk> spkList,
    BuildContext context,
  ) {
    if (spkList[index].aprv1By == "" && spkList[index].rejectBy == "") {
      context.read<ApproveSpkBloc>().add(
        ApproveSpkLoad(
          idSpk: spkList[index].idSpk,
          spkType: spkList[index].spkType,
          typeAprv: "approve1",
          status: "reject",
        ),
      );
    } else {
      context.read<ApproveSpkBloc>().add(
        ApproveSpkLoad(
          idSpk: spkList[index].idSpk,
          spkType: spkList[index].spkType,
          typeAprv: "approve2",
          status: "reject",
        ),
      );
    }

    if (index >= spkList.length) return;

    setState(() {
      spkList.removeAt(index);
      if (_currentPage >= spkList.length) {
        _currentPage = spkList.length - 1;
      }
    });
  }

  ScrollController _getController(int index) {
    return _scrollControllers[index % 3];
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _scrollControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => ApprovalSpkListBloc(
                approvalSpkRepository: context.read<ApprovalSpkRepository>(),
              )..add(
                GetSpkListEvent(
                  idSite: "",
                  idCluster: "",
                  idHouse: "",
                  approvalType: "",
                  approvalStatus: "",
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => ApproveSpkBloc(
                approvalSpkRepository: context.read<ApprovalSpkRepository>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: BlocConsumer<ApprovalSpkListBloc, ApprovalSpkListState>(
            listener: (context, state) {
              if (state is ApprovalSpkListLoadFailure) {
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
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Color(0xffEB5757),
                    ),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return;
                }
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              if (state is ApprovalSpkListInitial ||
                  state is ApprovalSpkListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalSpkListLoadFailure) {
                return Center(child: Text(state.message));
              }
              if (state is ApprovalSpkListLoadSuccess) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) => true,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: state.spkList.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return ApprovalSpkCard(
                        requests: state.spkList[index],
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          if (_isAnimated) return;
                          setState(() => _isAnimated = true);

                          final nextPage = index + 1;
                          if (nextPage < state.spkList.length) {
                            await _pageController.animateToPage(
                              nextPage,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }

                          setState(() => _isAnimated = false);
                        },
                        onReachTop: () async {
                          if (_isAnimated) return;
                          setState(() => _isAnimated = true);

                          final prevPage = index - 1;
                          if (prevPage >= 0) {
                            await _pageController.animateToPage(
                              prevPage,
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeOut,
                            );
                          }

                          setState(() => _isAnimated = false);
                        },
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
        ),
        bottomNavigationBar:
            BlocBuilder<ApprovalSpkListBloc, ApprovalSpkListState>(
              builder: (context, state) {
                if (state is! ApprovalSpkListLoadSuccess) {
                  return SizedBox.shrink();
                }

                return ApprovalBottomBar(
                  isLoading: false,
                  onApprove:
                      () =>
                          _handleApproval(_currentPage, state.spkList, context),
                  onReject: () {
                    _handleReject(_currentPage, state.spkList, context);
                  },
                );
              },
            ),
      ),
    );
  }
}
