import 'package:clean_app/core/result/result.dart';
import 'package:clean_app/dependency_injection.dart';
import 'package:clean_app/features/products/domain/model/enum/product_category.dart';
import 'package:clean_app/features/products/domain/model/product_model.dart';
import 'package:clean_app/features/products/domain/usecases/get_products_usecase.dart';
import 'package:clean_app/features/products/view/bloc/products_bloc.dart';
import 'package:clean_app/features/products/view/bloc/products_event.dart';
import 'package:clean_app/features/products/view/bloc/products_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key, this.onLogout});
  final VoidCallback? onLogout;

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_loadNextPageWhenNeeded);
  }

  void _loadNextPageWhenNeeded() {
    if (!_scrollController.hasClients) return;
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<ProductsBloc>().add(const ProductsNextPageRequested());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_loadNextPageWhenNeeded)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Интернет-магазин'),
      actions: [
        if (widget.onLogout != null)
          IconButton(tooltip: 'Выйти', onPressed: widget.onLogout, icon: const Icon(Icons.logout)),
      ],
    ),
    body: BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) => Column(children: [
        _CategoryBar(selected: state.category),
        Expanded(child: _ProductsBody(state: state, controller: _scrollController)),
      ]),
    ),
  );
}

class _CategoryBar extends StatelessWidget {
  const _CategoryBar({this.selected});
  final ProductCategory? selected;

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 56,
    child: ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      children: [
        ChoiceChip(label: const Text('Все'), selected: selected == null, onSelected: (_) => context.read<ProductsBloc>().add(const ProductsCategoryChanged(null))),
        const SizedBox(width: 8),
        ...ProductCategory.values.where((item) => item != ProductCategory.other).expand((item) => [
          ChoiceChip(label: Text(item.title), selected: selected == item, onSelected: (_) => context.read<ProductsBloc>().add(ProductsCategoryChanged(item))),
          const SizedBox(width: 8),
        ]),
      ],
    ),
  );
}

class _ProductsBody extends StatelessWidget {
  const _ProductsBody({required this.state, required this.controller});
  final ProductsState state;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    if (state is ProductsInitial || state is ProductsLoading) return const Center(child: CircularProgressIndicator());
    if (state is ProductsError) {
      final error = state as ProductsError;
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        Text(error.message), const SizedBox(height: 12),
        FilledButton(onPressed: () => context.read<ProductsBloc>().add(const ProductsRefreshed()), child: const Text('Повторить')),
      ]));
    }
    final loaded = state as ProductsNextPageLoaded;
    return RefreshIndicator(
      onRefresh: () async => context.read<ProductsBloc>().add(const ProductsRefreshed()),
      child: ListView.builder(
        controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: loaded.products.length + 1,
        itemBuilder: (context, index) {
          if (index == loaded.products.length) {
            if (loaded.isLoadingNextPage) {
              return const Padding(padding: EdgeInsets.all(16), child: Center(child: CircularProgressIndicator()));
            }
            if (loaded.nextPageError != null) {
              return Padding(
                padding: const EdgeInsets.all(12),
                child: TextButton(onPressed: () => context.read<ProductsBloc>().add(const ProductsNextPageRequested()), child: Text('Не удалось загрузить: ${loaded.nextPageError}. Повторить')),
              );
            }
            return loaded.hasMore ? const SizedBox(height: 64) : const SizedBox.shrink();
          }
          return _ProductTile(product: loaded.products[index]);
        },
      ),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Image.network(
          product.image,
          width: 56,
          height: 56,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => const Icon(Icons.broken_image),
        ),
        title: Text(product.title),
        subtitle: Text(product.category.title),
        trailing: Text('\$${product.price.toStringAsFixed(2)}'),
        onTap: () => showDialog<void>(
          context: context,
          builder: (_) => _ProductDetailsDialog(productId: product.id),
        ),
      );
}

class _ProductDetailsDialog extends StatefulWidget {
  const _ProductDetailsDialog({required this.productId});
  final int productId;

  @override
  State<_ProductDetailsDialog> createState() => _ProductDetailsDialogState();
}

class _ProductDetailsDialogState extends State<_ProductDetailsDialog> {
  late final Future<Result<ProductModel>> _productFuture;

  @override
  void initState() {
    super.initState();
    _productFuture = sl<GetProductsByIdUsecase>().call(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Информация о товаре'),
      content: SizedBox(
        width: 420,
        child: FutureBuilder<Result<ProductModel>>(
          future: _productFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 180,
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final result = snapshot.data;
            if (result is Failed<ProductModel>) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Text(result.failure.message),
              );
            }

            if (result is! Success<ProductModel>) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('Не удалось загрузить товар'),
              );
            }

            final product = result.data;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      product.image,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) => const SizedBox(
                        height: 180,
                        child: Center(child: Icon(Icons.broken_image, size: 64)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    product.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(product.category.title),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (product.description.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Text(product.description),
                  ],
                ],
              ),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Закрыть'),
        ),
      ],
    );
  }
}
