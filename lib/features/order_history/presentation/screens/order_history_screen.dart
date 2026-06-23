import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:food_app/core/theme/colors_manager.dart';
import 'package:food_app/core/theme/app_text_style.dart';
import 'package:food_app/core/theme/app_theme.dart';
import 'package:food_app/features/order_history/data/models/order_history_model.dart';
import '../cubit/order_history_cubit.dart';
import '../cubit/order_history_state.dart';
import '../widgets/order_history_card.dart';

/// Screen displaying the user's order history with active and past tabs.
class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _scrollController = ScrollController();
    context.read<OrderHistoryCubit>().loadHistory();

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;
      final tab = _tabController.index == 0 ? OrderHistoryTab.active : OrderHistoryTab.past;
      context.read<OrderHistoryCubit>().selectTab(tab);
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 100) {
        context.read<OrderHistoryCubit>().loadNextPage();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
      appBar: AppBar(
        backgroundColor: isDark ? ColorsManager.backgroundDark : ColorsManager.backgroundLight,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text('My Orders', style: AppTextStyle.font20Grey900Bold),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(52.h),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark ? ColorsManager.grey800 : ColorsManager.grey100,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                color: ColorsManager.primary,
                borderRadius: BorderRadius.circular(10.r),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              dividerColor: ColorsManager.transparent,
              labelStyle: AppTextStyle.font14Grey700Medium.copyWith(fontWeight: FontWeight.w600),
              labelColor: ColorsManager.white,
              unselectedLabelColor: isDark ? ColorsManager.grey400 : ColorsManager.grey500,
              tabs: const [
                Tab(text: 'Active'),
                Tab(text: 'Past'),
              ],
            ),
          ),
        ),
      ),
      body: BlocBuilder<OrderHistoryCubit, OrderHistoryState>(
        builder: (context, state) {
          final isLoading = state.status == OrderHistoryStatus.loading || state.status == OrderHistoryStatus.initial;
          final isPaginating = state.status == OrderHistoryStatus.paginating;
          final items = isLoading
              ? List.generate(3, (_) => OrderHistoryModel.fake())
              : state.filteredOrders;

          return Skeletonizer(
            enabled: isLoading,
            child: items.isEmpty && !isLoading
                ? _buildEmptyState(context, state.selectedTab)
                : ListView.separated(
                    controller: _scrollController,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    itemCount: items.length + (isPaginating ? 1 : 0),
                    separatorBuilder: (_, __) => SizedBox(height: 12.h),
                    itemBuilder: (context, index) {
                      if (index == items.length) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 16.h),
                          child: Center(
                            child: SizedBox(
                              height: 24.h,
                              width: 24.w,
                              child: const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: ColorsManager.primary,
                              ),
                            ),
                          ),
                        );
                      }
                      return OrderHistoryCard(order: items[index]);
                    },
                  ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, OrderHistoryTab tab) {
    final isDark = context.isDarkMode;
    final isActive = tab == OrderHistoryTab.active;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              color: ColorsManager.primary.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isActive ? Icons.hourglass_empty_rounded : Icons.receipt_long_outlined,
              size: 48.sp,
              color: ColorsManager.primary,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            isActive ? 'No Active Orders' : 'No Past Orders',
            style: AppTextStyle.font18Grey900SemiBold,
          ),
          SizedBox(height: 8.h),
          Text(
            isActive
                ? 'You have no orders in progress right now.'
                : 'You haven\'t placed any orders yet.',
            style: AppTextStyle.font14Grey600Regular,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
