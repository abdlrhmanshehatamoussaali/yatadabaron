import 'package:yatadabaron_flutter/dal/Repositories/ChaptersRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/CountriesRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/GenderRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/PurposesRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/ResearchTopicCommentsRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/ResearchTopicsRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UserMessagesRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UserRepliesRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UsersRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/VersesRepository.dart';

class UnitOfWork {
  ChaptersRepository Chapters;
  VersesRepository Verses;
  UsersRepository Users;
  CountriesRepository Countries;

  GenderRepository Genders;
  PurposesRepository Purposes;
  UserMessagesRepository UserMessages;
  UserRepliesRepository UserReplies;
  ResearchTopicsRepository ResearchTopics;
  ResearchTopicCommentsRepository ResearchTopicComments;

  UnitOfWork() {
    this.Chapters = ChaptersRepository();
    this.Verses = VersesRepository();
    this.Users = UsersRepository();
    this.Countries = CountriesRepository();
    this.Genders = GenderRepository();
    this.Purposes = PurposesRepository();
    this.UserMessages = UserMessagesRepository();
    this.UserReplies = UserRepliesRepository();
    this.ResearchTopicComments = ResearchTopicCommentsRepository();
    this.ResearchTopics = ResearchTopicsRepository();
  }
}
