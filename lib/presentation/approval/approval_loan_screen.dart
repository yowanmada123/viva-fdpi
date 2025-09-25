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
    final loan = loanList[index];

    if (loan.userAprv1.trim().isEmpty) {
      context.read<ApproveLoanBloc>().add(
        ApproveLoanLoad(
          trId: loan.trId,
          typeAprv: "approve1",
          status: "approve",
        ),
      );
      // if (credentialState is CredentialsLoadSuccess &&
      //     credentialState.credentials["APPROVALBON1"] == "Y") {
      // } else {
      //   _showNoPermissionSnackBar(context);
      //   return;
      // }
    } else if (loan.userAprv2.trim().isEmpty) {
      if (credentialState is CredentialsLoadSuccess &&
          credentialState.credentials["APPROVALBON2"] == "Y") {
        context.read<ApproveLoanBloc>().add(
          ApproveLoanLoad(
            trId: loan.trId,
            typeAprv: "approve2",
            status: "approve",
          ),
        );
      } else {
        _showNoPermissionSnackBar(context);
        return;
      }
    } else if (loan.userAprv3.trim().isEmpty) {
      if (credentialState is CredentialsLoadSuccess &&
          credentialState.credentials["APPROVALBON3"] == "Y") {
        context.read<ApproveLoanBloc>().add(
          ApproveLoanLoad(
            trId: loan.trId,
            typeAprv: "approve3",
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
    print("Harus remove index: $index");
    context.read<ApprovalLoanListBloc>().add(RemoveLoanListIndex(index: index));
  }

  void _handleReject(
    int index,
    List<ApprovalLoan> loanList,
    BuildContext context,
  ) {
    final credentialState = context.read<CredentialsBloc>().state;
    final loan = loanList[index];

    if (loan.userAprv1.trim().isEmpty) {
      if (credentialState is CredentialsLoadSuccess &&
          credentialState.credentials["APPROVALBON1"] == "Y") {
        context.read<ApproveLoanBloc>().add(
          ApproveLoanLoad(
            trId: loan.trId,
            typeAprv: "approve1",
            status: "reject",
          ),
        );
      } else {
        _showNoPermissionSnackBar(context);
        return;
      }
    } else if (loan.userAprv2.trim().isEmpty) {
      if (credentialState is CredentialsLoadSuccess &&
          credentialState.credentials["APPROVALBON2"] == "Y") {
        context.read<ApproveLoanBloc>().add(
          ApproveLoanLoad(
            trId: loan.trId,
            typeAprv: "approve2",
            status: "reject",
          ),
        );
      } else {
        _showNoPermissionSnackBar(context);
        return;
      }
    } else if (loan.userAprv3.trim().isEmpty) {
      if (credentialState is CredentialsLoadSuccess &&
          credentialState.credentials["APPROVALBON3"] == "Y") {
        context.read<ApproveLoanBloc>().add(
          ApproveLoanLoad(
            trId: loan.trId,
            typeAprv: "approve3",
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
    context.read<ApprovalLoanListBloc>().add(RemoveLoanListIndex(index: index));
  }

  void _showNoPermissionSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Anda tidak memiliki permission untuk approve KasBon"),
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
                      content: const Text(
                        "Session Anda telah habis. Silakan login kembali",
                      ),
                      duration: const Duration(seconds: 5),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xffEB5757),
                    ),
                  );
                  Navigator.of(context).popUntil((route) => route.isFirst);
                } else {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              }
            },
            builder: (context, state) {
              if (state is ApprovalLoanListInitial ||
                  state is ApprovalLoanListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ApprovalLoanListLoadFailure) {
                return Center(child: Text(state.message));
              }
              if (state is ApprovalLoanListLoadSuccess) {
                if (_currentPage >= state.loanList.length &&
                    state.loanList.isNotEmpty) {
                  _currentPage = state.loanList.length - 1;
                  _pageController.animateToPage(
                    _currentPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                  );
                }

                if (state.loanList.isEmpty) {
                  return const Center(
                    child: Text(
                      "Approval KasBon Tidak Tersedia",
                      style: TextStyle(fontSize: 14),
                    ),
                  );
                }

                return PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: state.loanList.length,
                  onPageChanged: (index) {
                    setState(() => _currentPage = index);
                  },
                  itemBuilder: (context, index) {
                    final loan = state.loanList[index];
                    return ApprovalCard(
                      requests: loan,
                      scrollController: _getController(index),
                      onReachBottom: () async {
                        if (_isAnimated) return;
                        setState(() => _isAnimated = true);

                        await _pageController.animateToPage(
                          _currentPage + 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );

                        setState(() => _isAnimated = false);
                      },
                      onReachTop: () async {
                        if (_isAnimated) return;
                        setState(() => _isAnimated = true);

                        await _pageController.animateToPage(
                          _currentPage - 1,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        );

                        setState(() => _isAnimated = false);
                      },
                    );
                  },
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
              return const SizedBox.shrink();
            }

            final credentialState = context.read<CredentialsBloc>().state;
            final loanList = state.loanList;

            if (_currentPage >= loanList.length) return const SizedBox.shrink();
            final currentPr = loanList[_currentPage];

            bool canApprove = false;
            if (credentialState is CredentialsLoadSuccess) {
              if (currentPr.userAprv1.trim().isEmpty) canApprove = true;
              if (currentPr.userAprv2.trim().isEmpty) canApprove = true;
              if (currentPr.userAprv3.trim().isEmpty) canApprove = true;
            }

            if (!canApprove) return const SizedBox.shrink();

            return ApprovalBottomBar(
              isLoading: false,
              onApprove: () => _handleApproval(_currentPage, loanList, context),
              onReject: () => _handleReject(_currentPage, loanList, context),
              canApprove: canApprove,
            );
          },
        ),
      ),
    );
  }
}
