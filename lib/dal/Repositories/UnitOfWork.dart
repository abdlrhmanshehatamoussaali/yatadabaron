import 'package:yatadabaron_flutter/dal/Models/Country.dart';
import 'package:yatadabaron_flutter/dal/Models/CustomResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/Gender.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchPurpose.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopic.dart';
import 'package:yatadabaron_flutter/dal/Models/ResearchTopicComment.dart';
import 'package:yatadabaron_flutter/dal/Models/UserMessage.dart';
import 'package:yatadabaron_flutter/dal/Models/UserReply.dart';
import 'package:yatadabaron_flutter/dal/Repositories/ChaptersRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/GenericRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/ResearchTopicCommentsRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UsersRepository.dart';
import 'package:yatadabaron_flutter/dal/Repositories/VersesRepository.dart';

class UnitOfWork {
  ChaptersRepository Chapters;
  VersesRepository Verses;

  UsersRepository Users;
  GenericRepository Countries;
  GenericRepository Genders;
  GenericRepository Purposes;
  GenericRepository UserMessages;
  GenericRepository UserReplies;
  GenericRepository ResearchTopics;
  ResearchTopicCommentsRepository ResearchTopicComments;
  
  UnitOfWork() {
    this.Chapters = ChaptersRepository();
    this.Verses = VersesRepository();

    this.Users = UsersRepository(this);
    this.Countries = GenericRepository<Country>();
    this.Genders =    GenericRepository<Gender>();
    this.Purposes =   GenericRepository<ResearchPurpose>();
    this.UserMessages = GenericRepository<UserMessage>();
    this.UserReplies = GenericRepository<UserReply>();
    this.ResearchTopicComments = ResearchTopicCommentsRepository(this);
    
    this.ResearchTopics = GenericRepository<ResearchTopic>();
  }
}
