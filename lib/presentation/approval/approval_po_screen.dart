// approval_screen.dart
import 'package:fdpi_app/bloc/approval_po/approval_po_list/approval_po_list_bloc.dart';
import 'package:fdpi_app/bloc/approval_po/approve_po/approve_po_bloc.dart';
import 'package:fdpi_app/bloc/auth/authentication/authentication_bloc.dart';
import 'package:fdpi_app/data/repository/approval_po_repository.dart';
import 'package:fdpi_app/models/approval_po/approval_po.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:fdpi_app/presentation/widgets/approval/approval_po_card.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/authorization/credentials/credentials_bloc.dart';

class ApprovalPoScreen extends StatefulWidget {
  final String title;
  const ApprovalPoScreen({super.key, required this.title});

  @override
  ApprovalPoScreenState createState() => ApprovalPoScreenState();
}

class ApprovalPoScreenState extends State<ApprovalPoScreen> {
  final PageController _pageController = PageController();
  final List<ScrollController> _scrollControllers = [];
  int _currentPage = 0;
  bool _isAnimated = false;

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
    List<ApprovalPo> poList,
    BuildContext context,
  ) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (poList[index].aprvBy == "" && poList[index].rjcBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALPO1"] == "Y") {
          context.read<ApprovePoBloc>().add(
            ApprovePoLoadEvent(
              poId: poList[index].poId,
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
    } else if (poList[index].aprv2By == "" && poList[index].rjc2By == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALPO2"] == "Y") {
          context.read<ApprovePoBloc>().add(
            ApprovePoLoadEvent(
              poId: poList[index].poId,
              typeAprv: "approve2",
              status: "approve",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve PO"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve PO"),
          ),
        );
        return;
      }
    }

    if (index >= poList.length) return;

    setState(() {
      poList.removeAt(index);
      if (_currentPage >= poList.length) {
        _currentPage = poList.length - 1;
      }
    });
  }

  void _handleReject(int index, List<ApprovalPo> poList, BuildContext context) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (poList[index].aprvBy == "" && poList[index].rjcBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALPO1"] == "Y") {
          context.read<ApprovePoBloc>().add(
            ApprovePoLoadEvent(
              poId: poList[index].poId,
              typeAprv: "approve1",
              status: "reject",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve PO"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve PO"),
          ),
        );
        return;
      }
    } else if (poList[index].aprv2By == "" && poList[index].rjcBy == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALPO2"] == "Y") {
          context.read<ApprovePoBloc>().add(
            ApprovePoLoadEvent(
              poId: poList[index].poId,
              typeAprv: "approve2",
              status: "reject",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Anda tidak memiliki permission untuk approve PO"),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Anda tidak memiliki permission untuk approve PO"),
          ),
        );
        return;
      }
    }

    if (index >= poList.length) return;

    setState(() {
      poList.removeAt(index);
      if (_currentPage >= poList.length) {
        _currentPage = poList.length - 1;
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
              (context) => ApprovalPoListBloc(
                approvalPORepository: context.read<ApprovalPORepository>(),
              )..add(GetApprovalPOListEvent()),
        ),
        BlocProvider(
          create:
              (context) => ApprovePoBloc(
                approvalPORepository: context.read<ApprovalPORepository>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: BlocConsumer<ApprovalPoListBloc, ApprovalPoListState>(
            listener: (context, state) {
              if (state is ApprovalPoListFailureState) {
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
                ).showSnackBar(SnackBar(content: Text(state.messsage)));
              }
            },
            builder: (context, state) {
              if (state is ApprovalPoListInitial ||
                  state is ApprovalPoListLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalPoListFailureState) {
                return Center(child: Text(state.messsage));
              }
              if (state is ApprovalPoListSuccessState) {
                if (state.data.isEmpty) {
                  return Center(
                    child: Text(
                      "Approval PO Tidak Tersedia",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) => true,
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: state.data.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      return ApprovalPoCard(
                        requests: state.data[index],
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          if (_isAnimated) return;
                          setState(() => _isAnimated = true);

                          final nextPage = index + 1;
                          if (nextPage < state.data.length) {
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
        bottomNavigationBar: BlocBuilder<
          ApprovalPoListBloc,
          ApprovalPoListState
        >(
          builder: (context, state) {
            if (state is! ApprovalPoListSuccessState) {
              return SizedBox.shrink();
            }

            final credentialState = context.read<CredentialsBloc>().state;
            final poList = state.data;

            if (_currentPage >= poList.length) return SizedBox.shrink();
            final currentPr = poList[_currentPage];

            bool canApprove = false;

            if (credentialState is CredentialsLoadSuccess) {
              if (credentialState.credentials["APPROVALPO1"] == "Y") {
                canApprove = currentPr.aprvBy == "" && currentPr.rjcBy == "";
              }
              if (credentialState.credentials["APPROVALPO2"] == "Y") {
                canApprove = currentPr.aprv2By == "" && currentPr.rjc2By == "";
              }
            }

            if (!canApprove) return SizedBox.shrink();
            return ApprovalBottomBar(
              isLoading: false,
              onApprove:
                  () => _handleApproval(_currentPage, state.data, context),
              onReject: () {
                _handleReject(_currentPage, state.data, context);
              },
              canApprove: canApprove,
            );
          },
        ),
      ),
    );
  }
}
