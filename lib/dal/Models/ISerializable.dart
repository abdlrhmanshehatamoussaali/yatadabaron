import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';

class ISerializable{
  dynamic fromJSON(Map<String,dynamic> json){

  }
  Map<String,String> toJSON(bool includeID){

  }
  Future fetchRelatedEntities(UnitOfWork uow) async{
    
  }
}