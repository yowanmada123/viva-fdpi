// approval_screen.dart
import 'dart:developer';

import 'package:fdpi_app/bloc/approval_spr/approval_spr_list/approval_spr_list_bloc.dart';
import 'package:fdpi_app/bloc/approval_spr/approve_spr/approve_spr_bloc.dart';
import 'package:fdpi_app/bloc/approval_spr/approval_spr_detail/approval_spr_detail_bloc.dart';
import 'package:fdpi_app/bloc/auth/authentication/authentication_bloc.dart';
import 'package:fdpi_app/data/repository/approval_spr.dart';
import 'package:fdpi_app/models/approval_spr/spr.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:fdpi_app/presentation/widgets/approval/approval_spr_card.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../bloc/authorization/credentials/credentials_bloc.dart';

class ApprovalSprScreen extends StatefulWidget {
  final String title;
  const ApprovalSprScreen({super.key, required this.title});

  @override
  ApprovalSprScreenState createState() => ApprovalSprScreenState();
}

class ApprovalSprScreenState extends State<ApprovalSprScreen> {
  final PageController _pageController = PageController();
  final List<ScrollController> _scrollControllers = [];
  int _currentPage = 0;
  bool _isAnimated = false;
  bool _initialDetailLoaded = false;

  @override
  void initState() {
    log('Access to lib/presentation/approval/approval_spr_screen.dart');
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    for (int i = 0; i < 3; i++) {
      _scrollControllers.add(ScrollController());
    }
  }

  void _handleApproval(int index, List<Spr> sprList, BuildContext context) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (sprList[index].aprv1By == "" && sprList[index].rejectBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPR1"] == "Y") {
          context.read<ApproveSprBloc>().add(
            ApproveSprLoad(
              idSpr: sprList[index].idSpr,
              typeAprv: "approve1",
              status: "approve",
            ),
          );
        } else {
          _showNoPermissionSnackBar(context);
          return;
        }
      } else {
        _showNoPermissionSnackBar(context);
        return;
      }
    }

    context.read<ApprovalSprDetailBloc>().add(
      ApprovalSprDetailLoad(idSpr: sprList[index].idSpr),
    );

    if (index >= sprList.length) return;

    context.read<ApprovalSprListBloc>().add(RemoveListIndex(index: index));
  }

  void _handleReject(int index, List<Spr> sprList, BuildContext context) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (sprList[index].aprv1By == "" && sprList[index].rejectBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALSPRS1"] == "Y") {
          context.read<ApproveSprBloc>().add(
            ApproveSprLoad(
              idSpr: sprList[index].idSpr,
              typeAprv: "approve1",
              status: "reject",
            ),
          );
        } else {
          _showNoPermissionSnackBar(context);
          return;
        }
      } else {
        _showNoPermissionSnackBar(context);
        return;
      }
      // } else if (sprList[index].aprv2By == "" && sprList[index].reject2By == "") {
      //   if (credentialState is CredentialsLoadSuccess) {
      //     if (credentialState.credentials["APPROVALSPB2"] == "Y") {
      //       context.read<ApproveSprBloc>().add(
      //         ApproveSprLoad(
      //           idSpr: sprList[index].idSpr,
      //           typeAprv: "approve2",
      //           status: "reject",
      //         ),
      //       );
      //     } else {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //           content: Text("Anda tidak memiliki permission untuk approve SPB"),
      //         ),
      //       );
      //       return;
      //     }
      //   } else {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text("Anda tidak memiliki permission untuk approve SPB"),
      //       ),
      //     );
      //     return;
      //   }
    }

    context.read<ApprovalSprDetailBloc>().add(
      ApprovalSprDetailLoad(idSpr: sprList[index].idSpr),
    );

    if (index >= sprList.length) return;

    context.read<ApprovalSprListBloc>().add(RemoveListIndex(index: index));
  }

  void _showNoPermissionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Anda tidak memiliki permission untuk melakukan approve SPRS",
        ),
      ),
    );
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
              (context) => ApprovalSprListBloc(
                approvalSprRepository: context.read<ApprovalSprRepository>(),
              )..add(GetSprListEvent()),
        ),
        BlocProvider(
          create:
              (context) => ApprovalSprDetailBloc(
                approvalSprRepository: context.read<ApprovalSprRepository>(),
              ),
        ),
        BlocProvider(
          create:
              (context) => ApproveSprBloc(
                approvalSprRepository: context.read<ApprovalSprRepository>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: BlocConsumer<ApprovalSprListBloc, ApprovalSprListState>(
            listener: (context, state) {
              if (state is ApprovalSprListFailure) {
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
              if (state is ApprovalSprListSuccess &&
                  !_initialDetailLoaded &&
                  state.sprList.isNotEmpty) {
                final firstSpr = state.sprList.first;

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) return;

                  context.read<ApprovalSprDetailBloc>().add(
                    ApprovalSprDetailLoad(idSpr: firstSpr.idSpr),
                  );
                });

                _initialDetailLoaded = true;
              }
            },
            builder: (context, state) {
              if (state is ApprovalSprListInitial ||
                  state is ApprovalSprListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalSprListFailure) {
                return Center(child: Text(state.message));
              }
              if (state is ApprovalSprListSuccess) {
                if (_currentPage >= state.sprList.length &&
                    state.sprList.isNotEmpty) {
                  _currentPage = state.sprList.length - 1;
                  _pageController.animateToPage(
                    _currentPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }

                if (state.sprList.isEmpty) {
                  return Center(child: Text("Tidak ada data"));
                }

                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) => true,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: state.sprList.length,
                    onPageChanged: (index) {
                      if (index >= state.sprList.length) return;

                      setState(() => _currentPage = index);

                      context.read<ApprovalSprDetailBloc>().add(
                        ApprovalSprDetailLoad(
                          idSpr: state.sprList[index].idSpr,
                        ),
                      );
                    },
                    itemBuilder: (context, index) {
                      if (index >= state.sprList.length) {
                        return const SizedBox();
                      }

                      final spr = state.sprList[index];

                      return ApprovalSprCard(
                        requests: spr,
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          if (_isAnimated) return;
                          setState(() => _isAnimated = true);

                          final nextPage = index + 1;
                          if (nextPage < state.sprList.length) {
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
            BlocBuilder<ApprovalSprListBloc, ApprovalSprListState>(
              builder: (context, state) {
                if (state is! ApprovalSprListSuccess) {
                  return const SizedBox.shrink();
                }

                final credentialState = context.read<CredentialsBloc>().state;
                final sprList = state.sprList;

                // guard jika list kosong
                if (sprList.isEmpty) {
                  return const SizedBox.shrink();
                }

                // pastikan currentPage valid
                if (_currentPage >= sprList.length) {
                  _currentPage = sprList.length - 1;
                }

                final currentPr = sprList[_currentPage];

                bool canApprove = false;

                if (credentialState is CredentialsLoadSuccess) {
                  if (credentialState.credentials["APPROVALSPR1"] == "Y") {
                    canApprove =
                        currentPr.aprv1By == "" && currentPr.rejectBy == "";
                  }
                }

                if (!canApprove) return const SizedBox.shrink();

                return ApprovalBottomBar(
                  isLoading: false,
                  onApprove:
                      () =>
                          _handleApproval(_currentPage, state.sprList, context),
                  onReject:
                      () => _handleReject(_currentPage, state.sprList, context),
                  canApprove: canApprove,
                );
              },
            ),
      ),
    );
  }
}
