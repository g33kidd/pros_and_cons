class CampOptions {
  final bool alwaysOn;
  // Not sure on other options at the moment but this interface is here if needed.
  String wsOverridePath;

  CampOptions({this.alwaysOn});
}

class Campfire {
  final String camp;

  // This would be any active connection to WS or whatever
  String sessionID;

  Campfire({this.camp});

  // Initializes the Campfire instance.
  static Future<Campfire> init({camp, CampOptions? options}) async {
    return new Campfire(camp: camp);
  }
}

class CampSchema {}

class AuthSchema implements CampSchema {}

class User extends AuthSchema {
  // There is a camp attribute, but we really don't care about that?
  // String camp;
  int id;
  String username;
  String emailAddress;
  Map<String, dynamic> metadata;
}
