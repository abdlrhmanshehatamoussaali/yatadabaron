import 'package:yatadabaron_flutter/dal/Models/Country.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/dal/Models/ISerializable.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/utils/ValidationRules.dart';

class User implements ISerializable {
  int UserID;
  int Age;
  int GenderID;
  int PurposeID;
  int CountryID;
  String Name;
  String Email;
  String Password;

  //Related Entities
  Country MyCountry;
  ResearchPurpose MyPurpose;
  Gender MyGender;
  Future fetchCountry(UnitOfWork uow) async {
    this.MyCountry =
        (await uow.Countries.fetch({"CountryID": this.CountryID.toString()}))
            .first;
  }

  Future fetchGender(UnitOfWork uow) async {
    this.MyGender =
        (await uow.Genders.fetch({"GenderID": this.GenderID.toString()})).first;
  }

  Future fetchPurpose(UnitOfWork uow) async {
    this.MyPurpose =
        (await uow.Purposes.fetch({"PurposeID": this.PurposeID.toString()}))
            .first;
  }

  Future fetchRelatedEntities(UnitOfWork uow) async {
    await fetchCountry(uow);
    await fetchPurpose(uow);
    await fetchGender(uow);
  }

  //Serialization
  @override
  User fromJSON(dynamic record) {
    try {
      User g = User();
      g.Name = record["Name"];
      g.Email = record["Email"];
      g.Password = record["Password"];
      g.UserID = int.parse(record["UserID"].toString());
      g.Age = int.parse(record["Age"].toString());
      g.GenderID = int.parse(record["GenderID"].toString());
      g.PurposeID = int.parse(record["PurposeID"].toString());
      g.CountryID = int.parse(record["CountryID"].toString());
      return g;
    } catch (e) {
      return null;
    }
  }

  @override
  Map<String, String> toJSON(bool includeID) {
    Map<String, String> body = Map<String, String>();
    if (includeID) {
      body["UserID"] = this.UserID.toString();
    }
    body["Email"] = Email;
    body["Password"] = Password;
    body["Age"] = Age.toString();
    body["Name"] = Name;
    body["CountryID"] = CountryID.toString();
    body["GenderID"] = GenderID.toString();
    body["PurposeID"] = PurposeID.toString();
    return body;
  }

  //validation
  String passwordValidation() => ValidationRules.validatePassword(Password);
  String emailvalidation() {
    if(Email!=null){
      Email = Email.replaceAll(" ", "");
    }
    return ValidationRules.validateEmail(Email);
  }

  String countryValidation() => ValidationRules.validateNonZero(CountryID);
  String purposeValidation() => ValidationRules.validateNonZero(PurposeID);
  String genderValidation() => ValidationRules.validateNonZero(GenderID);
  String nameValidation() {
    String v;
    v = ValidationRules.validateNotNull(Name);
    if (v != null) {
      return v;
    }

    v = ValidationRules.validateArabicName(Name);
    if (v != null) {
      return v;
    }
    return null;
  }

  String ageValidation() {
    String nonZero = ValidationRules.validateNonZero(Age);
    if (nonZero != null) {
      return nonZero;
    }
    if ((this.Age < 10) || (this.Age > 100)) {
      return ValidationRules.validationMessages("INVALID_AGE");
    }
    return null;
  }

  bool isvalid() {
    return (emailvalidation() == null) &&
        (passwordValidation() == null) &&
        (nameValidation() == null) &&
        (ageValidation() == null) &&
        (countryValidation() == null) &&
        (genderValidation() == null) &&
        (purposeValidation() == null);
  }
}
