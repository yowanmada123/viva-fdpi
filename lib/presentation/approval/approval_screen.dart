// approval_screen.dart
import 'package:fdpi_app/presentation/widgets/approval/vertical_timeline.dart';
import 'package:flutter/material.dart';
import 'package:fdpi_app/presentation/widgets/approval/approval_card.dart';
import 'package:fdpi_app/presentation/widgets/approval/aprrove_bottom_navigator.dart';
import 'dart:developer';

class ApprovalScreen extends StatefulWidget {
  final String title;
  const ApprovalScreen({super.key, required this.title});

  @override
  ApprovalScreenState createState() => ApprovalScreenState();
}

class ApprovalScreenState extends State<ApprovalScreen> {
  final PageController _pageController = PageController();
  final List<ScrollController> _scrollControllers = [];
  final List<Map<String, dynamic>> _requests = [];
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
      _requests.addAll(_demoRequests);
      _isLoading = false;
    });
  }

  void _loadMoreRequests() {
    log("masuk sini request $_isLoading");
    if (_isLoading) return;
    setState(() => _isLoading = true);

    setState(() {
      _requests.addAll([_demoRequests[0]]);
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
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
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
              return ApprovalCard(
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
        ),
      ),
      bottomNavigationBar: ApprovalBottomBar(
        isLoading: false,
        onApprove: () => _handleApproval(_currentPage),
        onReject: () {
          // Handle reject logic
        },
      ),
    );
  }

  final List<Map<String, dynamic>> _demoRequests = [
    {
      "date": "12 Juni 2024",
      "title": "Belanja Kebutuhan IT",
      "requested_by": "Didik Prasetyo",
      "step": [
        TimelineStep(
          header: "Diajukan",
          detail: "Didik Prasetyo (Manager IT), 12 Juni 2024",
          status: TimelineStatus.approved,
        ),
        TimelineStep(
          header: "Persetujuan Pertama",
          detail: "Sutrisno Slamet (Direksi), 14 Juni 2024",
          status: TimelineStatus.approved,
        ),
        TimelineStep(
          header: "Persetujuan Kedua",
          detail: "Joko Sutisno (Direksi 2), 14 Juni 2024",
          status: TimelineStatus.waiting,
        ),
      ],
      "request_detail": [
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
      ],
    },
    {
      "date": "12 Juni 2024",
      "title": "Belanja Kebutuhan IT 2",
      "requested_by": "Didik Prasetyo",
      "step": [
        TimelineStep(
          header: "Diajukan",
          detail: "Didik Prasetyo (Manager IT), 12 Juni 2024",
          status: TimelineStatus.approved,
        ),
        TimelineStep(
          header: "Persetujuan Pertama",
          detail: "Sutrisno Slamet (Direksi), 14 Juni 2024",
          status: TimelineStatus.approved,
        ),
        TimelineStep(
          header: "Persetujuan Kedua",
          detail: "Joko Sutisno (Direksi 2), 14 Juni 2024",
          status: TimelineStatus.waiting,
        ),
      ],
      "request_detail": [
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
        '1 Unit PC, Intel Ultra Core 5 122H, 32 GB RAM, 1TB SSD',
      ],
    },
  ];
}
