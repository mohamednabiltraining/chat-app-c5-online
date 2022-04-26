import 'package:chat_c5/base.dart';
import 'package:chat_c5/database/database_utils.dart';
import 'package:chat_c5/ui/add_room/navigator.dart';

class AddRoomViewModel extends BaseViewModel<AddRoomNavigator>{

  void createRoom(String roomTitle,String roomDesc,String catId)async{
    navigator?.showLoading(message: 'creating room...');
    String? message =null;
    try{
      var res  = await DataBaseUtils.createRoom(roomTitle,roomDesc,catId);
    }catch(ex){
      message = ex.toString();
      message = 'something went wrong';
    }
    navigator?.hideDialog();
    if(message !=null){
      navigator?.showMessage(message);
    }else {
      navigator?.roomCreated();
    }
  }
}