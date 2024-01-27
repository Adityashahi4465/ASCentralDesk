import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../constants/ui_constants.dart';
import '../../../theme/app_colors.dart';

class NoticeFeedScreen extends ConsumerStatefulWidget {
  const NoticeFeedScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NoticeFeedScreenState();
}

class _NoticeFeedScreenState extends ConsumerState<NoticeFeedScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 12, left: 8, right: 8),
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  width: 300.0,
                  height: 70,
                  child: TabBar(
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BoxDecoration(
                      gradient: AppColors.blueGradient,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                      ),
                    ),
                    labelColor: const Color.fromARGB(255, 255, 255, 255)
                        .withOpacity(0.8), // Unselected tab color
                    // Selected tab color
                    unselectedLabelColor: AppColors.mDisabledColor,
                    tabs: const [
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(36.0, 0, 36.0, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.mode_comment,
                                size: 24,
                              ),
                              Text(
                                'Notices',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Tab(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                          child: Column(
                            children: [
                              Icon(
                                Icons.bookmark,
                                size: 24,
                              ),
                              Text(
                                'Bookmarks',
                                style: TextStyle(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: UiConstants.noticeFeeds,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
