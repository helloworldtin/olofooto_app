import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:olofooto/core/common/resources/style/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({required this.navigationShell, super.key});
  static const routeName = 'dash-board-screen';
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: ThemeData.fallback().copyWith(
          splashColor: AppColors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: navigationShell.currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.black,
          backgroundColor: AppColors.white,
          type: BottomNavigationBarType.fixed,
          onTap: navigationShell.goBranch,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.home),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyLight.graph),
              label: 'chart',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.plus),
              label: 'add',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.chat),
              label: 'chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(IconlyBroken.profile),
              label: 'profile',
            ),
          ],
        ),
      ),
      body: navigationShell,
    );
  }
}
