
class userModel {
  final String name; 
  final String uid;
  final String profilePic; 
  final bool isOnline;
  final String phoneNumber;
  final List<String> groupId;
  userModel({
    required this.name,
    required this.uid,
    required this.profilePic,
    required this.isOnline,
    required this.phoneNumber,
    required this.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'uid': uid,
      'profilePic': profilePic,
      'isOnline': isOnline,
      'phoneNumber': phoneNumber,
      'groupId': groupId,
    };
  }

  factory userModel.fromMap(Map<String, dynamic> map,) {
    return userModel(
      name: map['name'] as String,
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      isOnline: map['isOnline'] as bool,
      phoneNumber: map['phoneNumber'] as String,
       groupId: (map['groupId'] as List<dynamic>).cast<String>(),
    );
  }

 
  

  
  }

 



