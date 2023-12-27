import 'package:another_flushbar/flushbar_helper.dart';
import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/presentation/thread/thread/thread_store.dart';
import 'package:chat_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ThreadListScreen extends StatefulWidget {
  @override
  _ThreadListScreenState createState() => _ThreadListScreenState();
}

class _ThreadListScreenState extends State<ThreadListScreen> {
  //stores:---------------------------------------------------------------------
  final ThreadStore _threadStore = getIt<ThreadStore>();

  final TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // check to see if already called api
    // if (!_threadStore.loading) {
    //   _threadStore.getPosts();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return
            // _threadStore.loading
            //     ? CustomProgressIndicatorWidget()
            //     :
            Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return [].isEmpty
        ? Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, bottom: 10, top: 30),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.onBackground,
                    hintText: "Search",
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(25),
                    ),
                    focusColor: Theme.of(context).colorScheme.onBackground,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    prefixIcon: IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        // _threadStore.searchPost(_searchController.text);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    itemCount: [].length + 1,
                    separatorBuilder: (context, position) {
                      return const SizedBox(height: 10);
                    },
                    itemBuilder: (context, position) {
                      if (position == 0) {
                        return ListTile(
                          onTap: () {},
                          leading: Icon(Icons.edit_note),
                          title: Text(
                            'New Chat',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        );
                      }
                      return _buildListItem(position - 1);
                    },
                  ),
                ),
                Divider(
                  height: 10,
                  thickness: 1,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Theme.of(context).cardColor,
                    ),
                  ),
                  onTap: () {},
                  title: Text(
                    "Hung InspireUI",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: Icon(Icons.more_vert),
                )
              ],
            ),
          )
        : Center(
            child: Text(
              AppLocalizations.of(context).translate('home_tv_no_thread_found'),
            ),
          );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      leading: Icon(Icons.cloud_circle),
      onTap: () {},
      title: Text(
        '_threadStore.threadList?.threads?[position].title',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      subtitle: Text(
        '_threadStore.threadList?.threads?[position].body}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_threadStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_threadStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
}
