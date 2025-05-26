import 'dart:math';

import 'package:carousel_slider_plus/carousel_slider_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../bloc/auth/authentication/authentication_bloc.dart';
import '../bloc/auth/logout/logout_bloc.dart';
import '../bloc/authorization/access_menu/access_menu_bloc.dart';
import '../bloc/authorization/credentials/credentials_bloc.dart';
import '../data/repository/auth_repository.dart';
import '../data/repository/authorization_repository.dart';
import '../models/authorization/menu.dart';
import '../models/errors/custom_exception.dart';
import 'SPK/spk_list_screen.dart';
import 'SPK/spr_list_screen.dart';
import 'approval/approval_screen.dart';
import 'booking/booking_screen.dart';
import 'fdpi/fdpi_residences_screen.dart';
import 'loan/loan_screen.dart';
import 'widgets/bottom_navigator.dart';
import 'widgets/logout_button.dart';

class DriverDashboardScreen extends StatelessWidget {
  const DriverDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = context.read<AuthRepository>();
    final authorizationRepository = context.read<AuthorizationRepository>();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => LogoutBloc(authRepository),
        ),
        BlocProvider(
          create:
              (context) => AccessMenuBloc(
                authorizationRepository: authorizationRepository,
              )..add(LoadAccessMenu()),
        ),
        BlocProvider.value(
          value: context.read<CredentialsBloc>()..add(CredentialsLoad()),
        ),
      ],
      child: MyGridLayout(),
    );
  }
}

class MyGridLayout extends StatelessWidget {
  Map<String, dynamic>? getButton(SubMenu submenu) {
    Map<String, Map<String, dynamic>> buttons = {
      'site': {
        'icon': Icons.map,
        'description': 'Lihat dan interaksi dengan layout cluster',
        'route': FDPIResidencesScreen(title: submenu.menu_caption),
      },
      'booking': {
        'icon': Icons.book,
        'description': 'Pesan atau negosiasi transaksi',
        'route': BookingScreen(title: submenu.menu_caption),
      },
      'sales': {
        'icon': Icons.real_estate_agent,
        'description': 'Menu untuk sales',
        'route': null,
      },
      'checkListBank': {
        'icon': Icons.task,
        'description': 'Monitoring Pembayaran Bank',
        'route': SprListScreen(title: submenu.menu_caption),
      },
      'checkListBuilding': {
        'icon': Icons.checklist,
        'description': 'Monitoring Pembangunan Rumah',
        'route': SpkListScreen(title: submenu.menu_caption),
      },
      'approvalKasBon': {
        'icon': Icons.edit_document,
        'text': 'Approval Pengajuan',
        'description': 'Approval Pengajuan',
        'route': ApprovalScreen(title: submenu.menu_caption),
      },
      'approvalKasBon': {
        'icon': Icons.edit_document,
        'text': 'Approval Pengajuan',
        'description': 'Approval Kasbon',
        'route': ApprovalScreen(title: submenu.menu_caption),
      },
      'approvalSPB': {
        'icon': Icons.edit_document,
        'text': 'Approval Pengajuan',
        'description': 'Approval SPB',
        'route': ApprovalScreen(title: submenu.menu_caption),
      },
      'approvalSPK': {
        'icon': Icons.edit_document,
        'text': 'Approval Pengajuan',
        'description': 'Approval SPK',
        'route': ApprovalScreen(title: submenu.menu_caption),
      },
      'approvalSPR': {
        'icon': Icons.edit_document,
        'text': 'Approval Pengajuan',
        'description': 'Approval SPR',
        'route': ApprovalScreen(title: submenu.menu_caption),
      },
      'kasBon': {
        'icon': Icons.request_quote,
        'text': 'Approval Pengajuan',
        'description': 'Kasbon',
        'route': LoanScreen(title: submenu.menu_caption),
      },
      // 'testing-ui-spk': {
      //   'icon': Icons.edit_document,
      //   'text': 'Approval Pengajuan',
      //   'description': 'Approval Pengajuan',
      //   'route': NewSpkChecklistScreen(),
      // },
    };

    if (!buttons.containsKey(submenu.menu_id)) return null;

    Map<String, dynamic> button = buttons[submenu.menu_id]!;
    button['text'] = submenu.menu_caption;
    return button;
  }

  final List<String> imagesCaraousel = [
    'assets/images/foto-awards.webp',
    'assets/images/foto-awards-1.webp',
    'assets/images/foto-awards-2.webp',
    'assets/images/foto-awards-3.webp',
    'assets/images/foto-awards-4.webp',
  ];

  MyGridLayout({super.key});

  void _navigateToScreen(BuildContext context, Map<String, dynamic> button) {
    if (button['route'] == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Fitur belum tersedia")));
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => button['route']),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFFBFD9FF),
        title: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.w),
          child: Text(
            'Fasindo App',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1C3FAA),
              fontFamily: 'Poppins',
            ),
          ),
        ),
        actions: [const LogOutButton()],
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(currentIndex: 0),
      body: SafeArea(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          color: const Color(0xFFBFD9FF),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 4.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.waving_hand_rounded,
                            color: Colors.orange,
                          ),
                          SizedBox(width: 8.w),
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                            builder: (context, authState) {
                              if (authState is Authenticated &&
                                  authState.user.username.isNotEmpty) {
                                return Text(
                                  'Hi, ${authState.user.username}',
                                  style: TextStyle(
                                    fontSize: max(24.sp, 24.0),
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF2F80ED),
                                    fontFamily: 'Poppins',
                                  ),
                                );
                              }
                              return Text(
                                'Hi, Guess',
                                style: TextStyle(
                                  fontSize: max(24.sp, 24.0),
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF2F80ED),
                                  fontFamily: 'Poppins',
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),

                // Carousel Section
                Container(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 155.w,
                      autoPlay: true,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      autoPlayAnimationDuration: Duration(milliseconds: 1000),
                      enlargeCenterPage: true,
                    ),
                    items:
                        imagesCaraousel.map((element) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 155.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                clipBehavior: Clip.hardEdge,
                                child: Image.asset(element, fit: BoxFit.cover),
                              );
                            },
                          );
                        }).toList(),
                  ),
                ),
                SizedBox(height: 24.w),

                // Menu Section
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 32.h,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFEAF1FF),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: BlocConsumer<AccessMenuBloc, AccessMenuState>(
                    listener: (context, state) {
                      if (state is AccessMenuLoadFailure) {
                        if (state.exception is UnauthorizedException) {
                          context.read<AuthenticationBloc>().add(
                            SetAuthenticationStatus(isAuthenticated: false),
                          );
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        }
                      }
                    },
                    builder: (context, state) {
                      if (state is AccessMenuLoadSuccess) {
                        return _buildGroupMenu(context, state.menus);
                      }
                      return Text("Tidak ada menu yang dapat diakses");
                    },
                  ),
                ),

                // Container(
                //   width: double.infinity,
                //   padding: EdgeInsets.symmetric(horizontal: 24.w),
                //   decoration: BoxDecoration(color: Color(0xFFEAF1FF)),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         'Testing Purpose(Static User Interface)',
                //         style: TextStyle(
                //           fontWeight: FontWeight.w600,
                //           fontSize: max(16.sp, 16.0),
                //         ),
                //       ),
                //       SizedBox(height: 16.w),
                //       _buildMenuCard(
                //         context,
                //         getButton(
                //           SubMenu(
                //             entity_id: '',
                //             appl_id: '',
                //             menu_id: 'approval',
                //             seq_id: '',
                //             menu_caption: 'Approval',
                //             route_path: '',
                //           ),
                //         ),
                //       ),
                //       SizedBox(height: 16.w),
                //       _buildMenuCard(
                //         context,
                //         getButton(
                //           SubMenu(
                //             entity_id: '',
                //             appl_id: '',
                //             menu_id: 'testing-ui-spk',
                //             seq_id: '',
                //             menu_caption: 'SPK Checklist',
                //             route_path: '',
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGroupMenu(BuildContext context, List<Menu> menus) {
    return Column(
      children:
          menus.map<Widget>((menu) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  menu.menu_header_caption,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: max(16.sp, 16.0),
                  ),
                ),
                SizedBox(height: 16.w),
                ...menu.submenus.map((item) {
                  return Column(
                    children: [
                      _buildMenuCard(context, getButton(item)),
                      SizedBox(height: 16.w),
                    ],
                  );
                }),
              ],
            );
          }).toList(),
    );
  }

  Widget _buildMenuCard(BuildContext context, Map<String, dynamic>? button) {
    if (button == null) return Container();
    return GestureDetector(
      onTap: () => _navigateToScreen(context, button),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: Color(0xFFEAF1FF),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Icon(button['icon'], color: Color(0xFF2F80ED), size: 48.w),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    button['text'],
                    style: TextStyle(
                      fontSize: max(16.sp, 16.0),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 4.w),
                  Text(
                    button['description'],
                    style: TextStyle(
                      fontSize: max(14.sp, 14.0),
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
