
import 'package:flutter/material.dart';

class BaseViewModel<N extends BaseNavigator> extends ChangeNotifier {
  N? navigator=null;
}

abstract class BaseNavigator {
  void showMessage(String message);
  void showLoading({String message,bool isDismissable});
  void hideDialog();
}

abstract class BaseState<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel ;
  VM initViewModel();
  @override
  void initState() {
    super.initState();
    viewModel = initViewModel();
  }
  @override
  void showLoading({String message='Loading',bool isDismissable=true}) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Row(
            children: [CircularProgressIndicator(), Text(message)],
          ),
        ),barrierDismissible: isDismissable);
  }

  @override
  void hideDialog() {
    // dialog is appearing on current screen
    // to hide dialog we should pop until we got current screen
    Navigator.popUntil(context, (route) {
    bool isVisible = route is PopupRoute;
    return !isVisible;
    });
  }

  @override
  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Row(
            children: [Expanded(child: Text(message))],
          ),
        ));
  }
}
