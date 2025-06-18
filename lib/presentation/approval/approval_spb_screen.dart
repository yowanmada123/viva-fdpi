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
import '../../bloc/authorization/credentials/credentials_bloc.dart';
import '../widgets/approval/approval_spb_card.dart';

class ApprovalSpbScreen extends StatefulWidget {
  final String title;
  const ApprovalSpbScreen({super.key, required this.title});

  @override
  ApprovalSpbScreenState createState() => ApprovalSpbScreenState();
}

class ApprovalSpbScreenState extends State<ApprovalSpbScreen> {
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

  void _handleApproval(int index, List<Spb> spbList, BuildContext context) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (spbList[index].aprv1By == "" && spbList[index].rejectBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPB1"] == "Y") {
          context.read<ApproveSpbBloc>().add(
            ApproveSpbLoad(
              idSpb: spbList[index].idSpb,
              typeAprv: "approve1",
              status: "approve",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve SPB"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve SPB"),
          ),
        );
        return;
      }
    } else if (spbList[index].aprv2By == "" && spbList[index].reject2By == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPB2"] == "Y") {
          context.read<ApproveSpbBloc>().add(
            ApproveSpbLoad(
              idSpb: spbList[index].idSpb,
              typeAprv: "approve2",
              status: "approve",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve SPB"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve SPB"),
          ),
        );
        return;
      }
    }

    context.read<ApprovalSpbDetailBloc>().add(
      ApprovalSpbDetailLoad(idSpb: spbList[index].idSpb),
    );

    if (index >= spbList.length) return;

    setState(() {
      spbList.removeAt(index);
      if (_currentPage >= spbList.length) {
        _currentPage = spbList.length - 1;
      }
    });
  }

  void _handleReject(int index, List<Spb> spbList, BuildContext context) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (spbList[index].aprv1By == "" && spbList[index].rejectBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPB1"] == "Y") {
          context.read<ApproveSpbBloc>().add(
            ApproveSpbLoad(
              idSpb: spbList[index].idSpb,
              typeAprv: "approve1",
              status: "reject",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve SPB"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve SPB"),
          ),
        );
        return;
      }
    } else if (spbList[index].aprv2By == "" && spbList[index].reject2By == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPB2"] == "Y") {
          context.read<ApproveSpbBloc>().add(
            ApproveSpbLoad(
              idSpb: spbList[index].idSpb,
              typeAprv: "approve2",
              status: "reject",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve SPB"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve SPB"),
          ),
        );
        return;
      }
    }

    context.read<ApprovalSpbDetailBloc>().add(
      ApprovalSpbDetailLoad(idSpb: spbList[index].idSpb),
    );

    if (index >= spbList.length) return;

    setState(() {
      spbList.removeAt(index);
      if (_currentPage >= spbList.length) {
        _currentPage = spbList.length - 1;
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
              (context) => ApprovalSpbListBloc(
                approvalSpbRepository: context.read<ApprovalSpbRepository>(),
              )..add(GetSpbListEvent()),
        ),
        BlocProvider(
          create:
              (context) => ApprovalSpbDetailBloc(
                approvalSpbRepository: context.read<ApprovalSpbRepository>(),
              ),
        ),
        BlocProvider(
          create:
              (context) => ApproveSpbBloc(
                approvalSpbRepository: context.read<ApprovalSpbRepository>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: BlocConsumer<ApprovalSpbListBloc, ApprovalSpbListState>(
            listener: (context, state) {
              if (state is ApprovalSpbListFailure) {
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
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  return;
                }
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }

              // Handle initial detail load
              if (state is ApprovalSpbListSuccess &&
                  !_initialDetailLoaded &&
                  state.spbList.isNotEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context.read<ApprovalSpbDetailBloc>().add(
                    ApprovalSpbDetailLoad(idSpb: state.spbList[0].idSpb),
                  );
                });
                _initialDetailLoaded = true;
              }
            },
            builder: (context, state) {
              if (state is ApprovalSpbListInitial ||
                  state is ApprovalSpbListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalSpbListFailure) {
                return Center(child: Text(state.message));
              }
              if (state is ApprovalSpbListSuccess) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) => true,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: state.spbList.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      if (index < state.spbList.length) {
                        context.read<ApprovalSpbDetailBloc>().add(
                          ApprovalSpbDetailLoad(
                            idSpb: state.spbList[index].idSpb,
                          ),
                        );
                      }
                    },
                    itemBuilder: (context, index) {
                      return ApprovalSpbCard(
                        requests: state.spbList[index],
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          if (_isAnimated) return;
                          setState(() => _isAnimated = true);

                          final nextPage = index + 1;
                          if (nextPage < state.spbList.length) {
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
            BlocBuilder<ApprovalSpbListBloc, ApprovalSpbListState>(
              builder: (context, state) {
                if (state is! ApprovalSpbListSuccess) {
                  return SizedBox.shrink();
                }

                return ApprovalBottomBar(
                  isLoading: false,
                  onApprove:
                      () =>
                          _handleApproval(_currentPage, state.spbList, context),
                  onReject: () {
                    _handleReject(_currentPage, state.spbList, context);
                  },
                );
              },
            ),
      ),
    );
  }
}
