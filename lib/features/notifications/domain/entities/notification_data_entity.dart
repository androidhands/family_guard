import 'package:equatable/equatable.dart';

class NotificationDataEntity extends Equatable {
  /*{"id":"Qv9dYrA8yYdfjMTqLvxEbreH7SM2","title":"Member Connection","data":"Boody has accepted your request, You are now one of his family member","routPath":"\/","imageUrl":"Qv9dYrA8yYdfjMTqLvxEbreH7SM21692035394.jpg"} */
  final String uid;
  final String title;
  final String data;
  final String routPath;
  final String imageUrl;

  const NotificationDataEntity( this.uid,  this.title,  this.data,  this.routPath,  this.imageUrl);
  
  @override
  List<Object?> get props =>[ uid,  title,  data,  routPath,  imageUrl];
}
