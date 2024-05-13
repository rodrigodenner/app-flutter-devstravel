import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final BuildContext pageContext;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final String title;
  final bool hideSearch;
  final bool showDrawer;
  final bool showBack;

  const CustomAppBar({
    Key? key,
    required this.pageContext,
    required this.scaffoldKey,
    required this.title,
    this.hideSearch = false,
    this.showDrawer = true,
    this.showBack = false,
  }) : super(key: key);

  @override
  _CustomAppBarState createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late IconButton leadingButton;

  @override
  void initState() {
    super.initState();
    _updateLeadingButton();
  }

  @override
  void didUpdateWidget(CustomAppBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateLeadingButton();
  }

  void searchAction() {
    Navigator.pushReplacementNamed(widget.pageContext, '/search');
  }

  void _updateLeadingButton() {
    leadingButton = widget.showBack
        ? IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black, size: 30),
      onPressed: () {
        Navigator.of(widget.pageContext).pop();
      },
    )
        : IconButton(
      icon: const Icon(Icons.menu, color: Colors.black, size: 30),
      onPressed: () {
        widget.scaffoldKey.currentState?.openDrawer();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      backgroundColor: Colors.white,
      title: Text(
        widget.title,
        style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Helvetica Neue'),
      ),
      leading: leadingButton,
      actions: [
        IconButton(
          icon: !widget.hideSearch
              ? const Icon(Icons.search, color: Colors.black, size: 30)
              : Container(),
          onPressed: searchAction,
        ),
      ],
    );
  }
}