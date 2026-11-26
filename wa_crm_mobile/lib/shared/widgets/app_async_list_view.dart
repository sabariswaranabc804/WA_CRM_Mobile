import 'package:flutter/material.dart';

import '../../core/constants/app_spacing.dart';
import 'app_states.dart';

class AppAsyncListView<T> extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<T> items;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final Widget emptyState;
  final VoidCallback? onRetry;
  final Future<void> Function()? onRefresh;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final Widget? separator;
  final EdgeInsetsGeometry? padding;
  final ScrollController? controller;
  final double loadMoreThreshold;

  const AppAsyncListView({
    super.key,
    required this.isLoading,
    required this.error,
    required this.items,
    required this.itemBuilder,
    required this.emptyState,
    this.onRetry,
    this.onRefresh,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.separator,
    this.padding,
    this.controller,
    this.loadMoreThreshold = 300,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const AppLoader();

    if (error != null) {
      return AppErrorState(message: error!, onRetry: onRetry ?? () {});
    }

    if (items.isEmpty) return _wrapRefresh(_emptyScrollable(context));

    return _wrapRefresh(_list());
  }

  Widget _emptyScrollable(BuildContext context) {
    return ListView(
      controller: controller,
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.55,
          child: emptyState,
        ),
      ],
    );
  }

  Widget _list() {
    final count = items.length + (isLoadingMore ? 1 : 0);

    Widget builder(BuildContext context, int i) {
      if (i >= items.length) return AppLoader.footer();
      return itemBuilder(context, items[i], i);
    }

    final list = separator == null
        ? ListView.builder(
            controller: controller,
            padding: padding,
            itemCount: count,
            itemBuilder: builder,
          )
        : ListView.separated(
            controller: controller,
            padding: padding,
            itemCount: count,
            separatorBuilder: (_, _) => separator!,
            itemBuilder: builder,
          );

    if (onLoadMore == null) return list;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final metrics = notification.metrics;
        if (metrics.axis == Axis.vertical &&
            metrics.pixels >= metrics.maxScrollExtent - loadMoreThreshold) {
          onLoadMore!();
        }
        return false;
      },
      child: list,
    );
  }

  Widget _wrapRefresh(Widget child) {
    if (onRefresh == null) return child;
    return RefreshIndicator(onRefresh: onRefresh!, child: child);
  }
}

class AppMetric extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const AppMetric({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
          Text(label, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }
}

class AppStatTile extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const AppStatTile({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Text(
              '$value',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
            const SizedBox(height: AppSpacing.xxs),
            Text(label, style: const TextStyle(fontSize: 11.5)),
          ],
        ),
      ),
    );
  }
}

class AppDetailRow extends StatelessWidget {
  final String label;
  final String value;

  const AppDetailRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
