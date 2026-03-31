part of '../view.dart';

class _Offers extends StatefulWidget {
  const _Offers();

  @override
  State<_Offers> createState() => _OffersState();
}

class _OffersState extends State<_Offers> {
  List<OfferModel>? offers;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      final resp = await DioHelper.getData(EndPoints.offerHome);

      if (resp != null && resp is List) {
        setState(() {
          offers = resp.map((e) => OfferModel.fromJson(e)).toList();
        });
      }
    } catch (e) {
      debugPrint("Error fetching offers: $e");
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox(
        height: 180.h,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (offers == null || offers!.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 180.h,
      child: PageView.builder(
        itemCount: offers!.length,
        itemBuilder: (context, index) {
          final model = offers![index];
          return _buildOfferItem(model);
        },
      ),
    );
  }

  Widget _buildOfferItem(OfferModel model) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.network(
              model.imageUrl,
              height: 320,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => AppImage(
                image:
                "https://img.buzzfeed.com/buzzfeed-static/static/2019-08/16/2/asset/2f2486d35771/sub-buzz-2247-1565922471-1.jpg",
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xffE9DCD3).withOpacity(0.8),
              ),
              width: double.infinity,

              child: Column(
                mainAxisSize: MainAxisSize.min,  
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "${model.discountPercent}% OFF DISCOUNT \nCUPON CODE : ${model.couponCode}",
                          maxLines: 2,  
                          overflow: TextOverflow.ellipsis,  
                          style: const TextStyle(
                            color: Color(0xff62322D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const AppImage(image: "offer.svg"),
                    ],
                  ),
                  SizedBox(height: 8), // spacing لطيف

                  Row(
                    children: [
                      const AppImage(image: "offer.svg"),
                      Expanded(
                        child: Text(
                          "${model.descriptionTitle1} \n${model.descriptionTitle2}",
                          maxLines: 2, 
                          overflow: TextOverflow.ellipsis, 
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                            color: Color(0xff434C6D),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
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

class OfferModel {
  late final int id;
  late final String couponCode;
  late final int discountPercent;
  late final String descriptionTitle1;
  late final String descriptionTitle2;
  late final String imageUrl;

  OfferModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    couponCode = json['couponCode'] ?? "";
    discountPercent = json['discountPercent'] ?? 0;
    descriptionTitle1 = json['descriptionTitle1'] ?? "";
    descriptionTitle2 = json['descriptionTitle2'] ?? "";
    imageUrl = json['imageUrl'] ?? "";
  }
}