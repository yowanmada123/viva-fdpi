// approval_screen.dart
import 'package:fdpi_app/bloc/approval_spb/approval_spb_list/approval_spb_list_bloc.dart';
import 'package:fdpi_app/bloc/auth/authentication/authentication_bloc.dart';
import 'package:fdpi_app/data/repository/approval_spb.dart';
import 'package:fdpi_app/models/approval_spb/spb.dart';
import 'package:fdpi_app/models/errors/custom_exception.dart';
import 'package:flutter/material.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

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
  final List<Spb> _requests = [];
  int _currentPage = 0;
  bool _isLoading = false;
  bool _isAnimated = false;

  @override
  void initState() {
    super.initState();
    _loadInitialRequests();
    _initializeControllers();
  }

  void _initializeControllers() {
    // Initialize 3 controllers for sliding window
    for (int i = 0; i < 3; i++) {
      _scrollControllers.add(ScrollController());
    }
  }

  Future<void> _loadInitialRequests() async {
    setState(() => _isLoading = true);
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      _isLoading = false;
    });
  }

  void _loadMoreRequests() {
    log("masuk sini request $_isLoading");
    if (_isLoading) return;
    setState(() => _isLoading = true);

    setState(() {
      _isLoading = false;
    });
  }

  void _handleApproval(int index) {
    setState(() {
      _requests.removeAt(index);
      if (_currentPage >= _requests.length) {
        _currentPage = _requests.length - 1;
      }
    });
    if (_currentPage == _requests.length - 1) {
      log("masuk sini");
      _loadMoreRequests();
    }
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
    return BlocProvider(
      create:
          (context) => ApprovalSpbListBloc(
            approvalSpbRepository: context.read<ApprovalSpbRepository>(),
          )..add(GetSpbListEvent()),
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
                _requests.addAll(state.spbList);
                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    return true;
                  },
                  child: PageView.builder(
                    controller: _pageController,
                    scrollDirection: Axis.vertical,
                    itemCount: _requests.length + (_isLoading ? 1 : 0),
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                      if (_currentPage >= _requests.length - 1) {
                        log("masuk sini");
                        _loadMoreRequests();
                      }
                    },
                    itemBuilder: (context, index) {
                      if (index >= _requests.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      return ApprovalSpbCard(
                        requests: _requests[index],
                        scrollController: _getController(index),
                        onReachBottom: () async {
                          int index = _currentPage;
                          log("capai bawah degan state animated $_isAnimated");

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
                          log("capai atas degan state animated $_isAnimated");

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
        bottomNavigationBar: ApprovalBottomBar(
          isLoading: false,
          onApprove: () => _handleApproval(_currentPage),
          onReject: () {
            // Handle reject logic
          },
        ),
      ),
    );
  }
}
