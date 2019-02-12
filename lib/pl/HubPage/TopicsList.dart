import 'package:flutter/material.dart';
import 'package:yatadabaron_flutter/dal/Repositories/UnitOfWork.dart';
import 'package:yatadabaron_flutter/pl/Shared/SharedWidgets.dart';
import 'package:yatadabaron_flutter/pl/HubPage/TopicListItem.dart';
import 'package:yatadabaron_flutter/utils/utils.dart';

class TopicsList extends StatelessWidget {
  Function onClick;
  int pageSize;
  int noOfPages;

  TopicsList(this.pageSize, this.onClick, this.noOfPages);

  _pageFetcher(int pageNumber) async {
    await Future.delayed(Duration(seconds: 1));
    UnitOfWork uow = UnitOfWork();
    var results = await uow.ResearchTopics.fetch({
      "limit": pageSize.toString(),
      "offset": (pageNumber*pageSize).toString(),
    });
    return results;
  }

  _pageBuilder(List page) {
    var items = page.map((topic) {
      return TopicListItem(topic, (t) {
        this.onClick(t);
      });
    }).toList();

    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      itemBuilder: (context, index) {
        var item = items[index];
        var visualItem = Container(
          padding: EdgeInsets.all(5),
          child: item,
        );

        return Column(
          children: <Widget>[
            visualItem,
            Divider(
              color: Colors.grey,
            )
          ],
        );
      },
      itemCount: items.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (noOfPages != null) {
      return SharedWidgets.infiniteList(_pageFetcher, _pageBuilder, noOfPages);
    } else {
      return SharedWidgets.spinner();
    }
  }
}
