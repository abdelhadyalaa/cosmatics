part of '../view.dart';

class _ProductList extends StatefulWidget {
  const _ProductList();

  @override
  State<_ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<_ProductList> {
  List<ProductModel>? products;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final resp = await DioHelper().getData(EndPoints.productHome);

      if (resp != null && resp is List) {
        setState(() {
          products = resp.map((e) => ProductModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      debugPrint("Error fetching products: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) return const Center(child: CircularProgressIndicator());
    if (products == null || products!.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Top rated products",
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xff434C6D),
          ),
        ),
        const SizedBox(height: 14),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 176 / 237,
          ),
          itemCount: products!.length,
          itemBuilder: (context, index) => _Item(
            model: products![index],
          ),
        ),
      ],
    );
  }
}

class ProductModel {
  late final int id;
  late final String title, imageUrl;
  late final num price;

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    title = json['name'] ?? "Ali";
    imageUrl = json['imageUrl'] ?? "";
    price = json['price'] ?? 0;
  }
}