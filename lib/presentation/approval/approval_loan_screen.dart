// approval_screen.dart
import 'package:fdpi_app/bloc/approval_loan/approval_loan_list/approval_loan_list_bloc.dart';
import 'package:fdpi_app/bloc/approval_loan/approve_loan/approve_loan_bloc.dart';
import 'package:fdpi_app/bloc/auth/authentication/authentication_bloc.dart';
import 'package:fdpi_app/bloc/authorization/credentials/credentials_bloc.dart';
import 'package:fdpi_app/data/repository/approval_loan_repository.dart';
import 'package:fdpi_app/models/approval_loan/approval_loan.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:fdpi_app/presentation/widgets/approval/approval_loan_card.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalScreen extends StatefulWidget {
  final String title;
  const ApprovalScreen({super.key, required this.title});

  @override
  ApprovalScreenState createState() => ApprovalScreenState();
}

class ApprovalScreenState extends State<ApprovalScreen> {
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
    // Initialize 3 controllers for sliding window
    for (int i = 0; i < 3; i++) {
      _scrollControllers.add(ScrollController());
    }
  }

  void _handleApproval(
    int index,
    List<ApprovalLoan> loanList,
    BuildContext context,
  ) {
    final credentialState = context.read<CredentialsBloc>().state;
    if (loanList[index].userAprv1.trim() == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALBON1"] == "Y") {
          context.read<ApproveLoanBloc>().add(
            ApproveLoanLoad(
              trId: loanList[index].trId,
              typeAprv: "approve1",
              status: "approve",
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Anda tidak memiliki permission untuk approve KasBon",
              ),
            ),
          );
          return;
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Anda tidak memiliki permission untuk approve KasBon",
            ),
          ),
        );
        return;
      }
    }
    setState(() {
      loanList.removeAt(index);
      if (_currentPage >= loanList.length) {
        _currentPage = loanList.length - 1;
      }
    });
    if (_currentPage == loanList.length - 1) {
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleReject(
    int index,
    List<ApprovalLoan> loanList,
    BuildContext context,
  ) {
    final credentialState = context.read<CredentialsBloc>().state;

    if (loanList[index].userAprv1.trim() == "") {
      if (credentialState is CredentialsLoadSuccess) {
        if (credentialState.credentials["APPROVALBON1"] == "Y") {
          context.read<ApproveLoanBloc>().add(
            ApproveLoanLoad(
              trId: loanList[index].trId,
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
    }
    if (index >= loanList.length) return;

    setState(() {
      loanList.removeAt(index);
      if (_currentPage >= loanList.length) {
        _currentPage = loanList.length - 1;
      }
    });
  }

  ScrollController _getController(int index) {
    // Recycle controllers using modulo
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
        BlocProvider<ApprovalLoanListBloc>(
          create:
              (context) => ApprovalLoanListBloc(
                approvalLoanRepository: context.read<ApprovalLoanRepository>(),
              )..add(
                GetLoanListEvent(
                  vendorId: "",
                  approvalType: "",
                  approvalStatus: "O",
                ),
              ),
        ),
        BlocProvider(
          create:
              (context) => ApproveLoanBloc(
                approvalLoanRepository: context.read<ApprovalLoanRepository>(),
              ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: SafeArea(
          child: BlocConsumer<ApprovalLoanListBloc, ApprovalLoanListState>(
            listener: (context, state) {
              if (state is ApprovalLoanListLoadFailure) {
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
              if (state is ApprovalLoanListInitial ||
                  state is ApprovalLoanListLoading) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalLoanListLoadFailure) {
                return Center(child: Text(state.message));
              }
              if (state is ApprovalLoanListLoadSuccess) {
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    return true;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: state.loanList.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) {
                      if (index >= state.loanList.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ApprovalCard(
                        requests: state.loanList[index],
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          int index = _currentPage;

                          if (_isAnimated) return;
                          setState(() {
                            _isAnimated = true;
                          });

                          await _pageController.animateToPage(
                            index + 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );

                          setState(() {
                            _isAnimated = false;
                          });
                        },
                        onReachTop: () async {
                          int index = _currentPage;

                          if (_isAnimated) return;

                          setState(() {
                            _isAnimated = true;
                          });

                          await _pageController.animateToPage(
                            index - 1,
                            duration: Duration(milliseconds: 300),
                            curve: Curves.easeOut,
                          );

                          setState(() {
                            _isAnimated = false;
                          });
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
          ApprovalLoanListBloc,
          ApprovalLoanListState
        >(
          builder: (context, state) {
            if (state is! ApprovalLoanListLoadSuccess) {
              return SizedBox.shrink();
            }

            final credentialState = context.read<CredentialsBloc>().state;
            final loanList = state.loanList;

            if (_currentPage >= loanList.length) return SizedBox.shrink();
            final currentPr = loanList[_currentPage];

            bool canApprove = false;

            if (credentialState is CredentialsLoadSuccess) {
              if (currentPr.userAprv1.trim() == "") {
                canApprove = true;
              }
              if (currentPr.userAprv2.trim() == "") {
                canApprove = true;
              }
            }

            if (!canApprove) return SizedBox.shrink();
            return ApprovalBottomBar(
              isLoading: false,
              onApprove:
                  () => _handleApproval(_currentPage, state.loanList, context),
              onReject:
                  () => _handleReject(_currentPage, state.loanList, context),
              canApprove: canApprove,
            );
          },
        ),
      ),
    );
  }
}
