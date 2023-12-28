import 'package:another_flushbar/flushbar_helper.dart';
import 'package:chat_app/core/widgets/progress_indicator_widget.dart';
import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/domain/entity/thread/thread.dart';
import 'package:chat_app/presentation/home/store/message/message_store.dart';
import 'package:chat_app/presentation/thread/thread/thread_store.dart';
import 'package:chat_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

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
    _threadStore.getThreads();

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
        return _threadStore.loading || _threadStore.isLoading
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return Padding(
      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10, top: 30),
      child: Column(
        children: [
          // TextField(
          //   controller: _searchController,
          //   decoration: InputDecoration(
          //     filled: true,
          //     fillColor: Theme.of(context).colorScheme.onBackground,
          //     hintText: "Search",
          //     enabledBorder: OutlineInputBorder(
          //       borderSide: BorderSide.none,
          //       borderRadius: BorderRadius.circular(25),
          //     ),
          //     focusColor: Theme.of(context).colorScheme.onBackground,
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(25),
          //     ),
          //     prefixIcon: IconButton(
          //       icon: Icon(Icons.search),
          //       onPressed: () {
          //         // _threadStore.searchPost(_searchController.text);
          //       },
          //     ),
          //   ),
          // ),
          const SizedBox(height: 10),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                return _threadStore.getThreads();
              },
              child: _threadStore.isLoading
                  ? CustomProgressIndicatorWidget()
                  : ListView.separated(
                      itemCount: (_threadStore.threadList?.length ?? 0) + 1,
                      separatorBuilder: (context, position) {
                        return const SizedBox(height: 10);
                      },
                      itemBuilder: (context, position) {
                        if (position == 0) {
                          return ListTile(
                            onTap: () async {
                              await _threadStore.changeThread();
                              Scaffold.of(context).closeDrawer();
                            },
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
                        return _buildListItem(
                            _threadStore.threadList!.elementAt(position - 1));
                      },
                    ),
            ),
          ),
          if (_threadStore.threadList?.isEmpty ?? true)
            Expanded(child: Center(child: Text("No Thread Found"))),
          Divider(
            height: 10,
            thickness: 1,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          ListTile(
            leading: CircleAvatar(
              child: Icon(
                Icons.person,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            title: Text(
              "Hoang Truong",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildListItem(Thread thread) {
    return ListTile(
      onTap: () async {
        Scaffold.of(context).closeDrawer();
        await _threadStore.changeThread(thread: thread);
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      tileColor: _threadStore.selectedThread?.id == thread.id
          ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
          : null,
      title: Text(
        thread.title ?? "",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(),
      ),
      subtitle: Text(
        DateFormat("dd/MM/yyyy hh:mm a").format(
          DateTime.fromMillisecondsSinceEpoch(thread.createdAt),
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              color: Theme.of(context).hintColor,
            ),
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
