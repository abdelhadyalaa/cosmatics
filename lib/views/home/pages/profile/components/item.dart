part of '../view.dart';
class _Item extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Widget? page;

  const _Item({super.key, required this.title, this.onTap, this.page});

  @override
  Widget build(BuildContext context) {
    final isLogout = title.toLowerCase() == "logout";
    final image = "${title.toLowerCase().replaceAll(" ", "_")}.svg";
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: ListTile(
        onTap: page == null
            ? null
            : () {
          goTo(page: page!);
        },
        leading: AppImage(image: image),
        title: Text(title, style: TextStyle(color: isLogout ? Colors.red : null)),
        trailing: isLogout ? null : AppImage(image: "forward.svg"),
      ),
    );
  }
}
