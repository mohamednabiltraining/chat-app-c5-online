import 'package:chat_c5/base.dart';
import 'package:chat_c5/model/category.dart';
import 'package:chat_c5/ui/add_room/addroom_view_model.dart';
import 'package:chat_c5/ui/add_room/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomScreen extends StatefulWidget {
  static const String routeName = 'add-room';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends BaseState<AddRoomScreen, AddRoomViewModel>
    implements AddRoomNavigator {
  var categories = Category.getCategories();
  late Category selectedItem;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String title = '', desc = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedItem = categories[0];
    viewModel.navigator = this;
  }

  @override
  AddRoomViewModel initViewModel() => AddRoomViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => viewModel,
      child: Stack(children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            'assets/images/background_image.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Add Room',
            ),
          ),
          body: Container(
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(12)),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('Create New Room'),
                  Image.asset('assets/images/group.png'),
                  TextFormField(
                    decoration: InputDecoration(hintText: 'Room Title'),
                    onChanged: (text) {
                      title = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter room title';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: DropdownButton<Category>(
                            value: selectedItem,
                            items: categories
                                .map((cat) => DropdownMenuItem<Category>(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            cat.image,
                                            height: 50,
                                            width: 50,
                                          ),
                                          SizedBox(
                                            width: 12,
                                          ),
                                          Text(cat.title)
                                        ],
                                      ),
                                      value: cat,
                                    ))
                                .toList(),
                            onChanged: (cat) {
                              if (cat == null) return;
                              setState(() {
                                selectedItem = cat;
                              });
                            }),
                      )
                    ],
                  ),
                  TextFormField(
                    maxLines: 4,
                    minLines: 4,
                    onChanged: (text) {
                      desc = text;
                    },
                    decoration: InputDecoration(
                      hintText: 'Description',
                    ),
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'please enter room description';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        validateForm();
                      },
                      child: Text('Create'))
                ],
              ),
            ),
          ),
        )
      ]),
    );
  }

  void validateForm() {
    if (formKey.currentState?.validate() == true) {
      viewModel.createRoom(title, desc, selectedItem.id);
    }
  }

  void roomCreated() {
    showMessage('room Created Successfully', actionName: "ok", action: () {
      hideDialog();
      Navigator.pop(context);
    });
  }
}
