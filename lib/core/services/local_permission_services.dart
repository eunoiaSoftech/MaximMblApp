import 'package:get_storage/get_storage.dart';

class PermissionService {
  final box = GetStorage();

  // Function to store the rights list
  void storeRights(List<dynamic> rights) {
    print('check stored data while login rights $rights');
    box.write('rights', rights);
  }

  // Function to check permission by submenu name
  bool hasPermission(String submenuName) {
    // Retrieve the rights list from local storage
    List<dynamic> storedRights = box.read('rights') ?? [];

    // Search for the submenu name in the rights list
    var submenu = storedRights.firstWhere(
            (item) => item['sSubmenuName'] == submenuName,
        orElse: () => null);

    // Return true if isRights is 1, false otherwise
    if (submenu != null && submenu['isRights'] == 1) {
      return true;
    } else {
      return false;
    }
  }
}
