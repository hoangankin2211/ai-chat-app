import 'dart:async';

import 'package:chat_app/di/service_locator.dart';
import 'package:chat_app/domain/entity/message/message.dart';
import 'package:chat_app/domain/entity/message/role.dart';
import 'package:chat_app/presentation/home/store/language/language_store.dart';
import 'package:chat_app/presentation/home/store/message/message_store.dart';
import 'package:chat_app/presentation/home/store/theme/theme_store.dart';
import 'package:chat_app/presentation/thread/thread_list.dart';
import 'package:chat_app/utils/locale/app_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //stores:---------------------------------------------------------------------
  final MessageStore _messageStore = getIt<MessageStore>();
  final ThemeStore _themeStore = getIt<ThemeStore>();
  final LanguageStore _languageStore = getIt<LanguageStore>();
  // final StreamController<Message> _streamController =
  //     StreamController.broadcast();
  // late final Stream<Message> _messageStream;
  late List<Message> listMessage;
  @override
  void initState() {
    // _messageStream = _streamController.stream.asBroadcastStream();
    _messageStore.getMessages();
    super.initState();
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 5,
        width: MediaQuery.of(context).size.width * 0.85,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        )),
        child: ThreadListScreen(),
      ),
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Flexible(child: buildListMessage()),
          InputWidget(
            isListening: false,
            micAvailable: true,
            onSubmitted: () {
              // _streamController.add();
              if (_textEditingController.text.isNotEmpty) {
                _messageStore.addMessage(
                    message: _textEditingController.value.text,
                    role: Role.user);
                _textEditingController.clear();
              }
            },
            onVoiceStart: () {},
            onVoiceStop: () {},
            textEditingController: _textEditingController,
          ),
        ],
      ),
    );
  }

  // app bar methods:-----------------------------------------------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: Text("Message"),
      actions: _buildActions(),
    );
  }

  List<Widget> _buildActions() {
    return <Widget>[
      _buildNewChatButton(),
      _buildLanguageButton(),
      _buildThemeButton(),
    ];
  }

  Widget _buildNewChatButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {},
          icon: Icon(Icons.edit_document),
        );
      },
    );
  }

  Widget _buildThemeButton() {
    return Observer(
      builder: (context) {
        return IconButton(
          onPressed: () {
            _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
          },
          icon: Icon(
            _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton() {
    return IconButton(
      onPressed: () {
        _buildLanguageDialog();
      },
      icon: Icon(
        Icons.language,
      ),
    );
  }

  Widget buildItem(String sender, String message) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                ),
                const SizedBox(width: 5),
                Text(sender),
              ],
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 45),
                child: Text(message),
              ),
            )
          ],
        ),
        margin: EdgeInsets.only(bottom: 10, left: 5, right: 5),
      ),
    );
  }

  Widget buildListMessage() {
    return Observer(
      builder: (context) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        separatorBuilder: (context, index) => const SizedBox(height: 5),
        itemBuilder: (context, index) {
          // index == _messageStore.listMessage.length
          //     ? (_messageStore.streamMessage != null
          //         ? Observer(
          //             builder: (context) => StreamBuilder<String>(
          //               stream: _messageStore.streamMessage,
          //               builder: (context, snapshot) {
          //                 if (snapshot.hasData &&
          //                     snapshot.data != null &&
          //                     snapshot.data!.isNotEmpty) {
          //                   return buildItem(
          //                       context, Role.assistant.name, snapshot.data!);
          //                 } else {
          //                   return const SizedBox();
          //                 }
          //               },
          //             ),
          //           )
          //         : const SizedBox())
          //     :

          if (index == _messageStore.listMessage.length) {
            if (_messageStore.responseMessage != null) {
              return StreamBuilder<String>(
                stream: _messageStore.responseMessage,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active &&
                      snapshot.hasData &&
                      snapshot.data != null &&
                      snapshot.data!.isNotEmpty) {
                    return buildItem(Role.assistant.name, snapshot.requireData);
                  } else {
                    return const SizedBox();
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          } else {
            final messageUI = _messageStore.listMessage.elementAt(index);
            return buildItem(
              messageUI.message.role,
              messageUI.message.title,
            );
          }
        },
        itemCount: _messageStore.listMessage.length + 1,
        controller: ScrollController(),
      ),
    );
  }

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
                dense: true,
                contentPadding: EdgeInsets.all(0.0),
                title: Text(
                  object.language,
                  style: TextStyle(
                    color: _languageStore.locale == object.locale
                        ? Theme.of(context).primaryColor
                        : _themeStore.darkMode
                            ? Colors.white
                            : Colors.black,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                  // change user language based on selected locale
                  _languageStore.changeLanguage(object.locale);
                },
              ),
            )
            .toList(),
      ),
    );
  }

  _showDialog<T>({required BuildContext context, required Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T? value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}

class InputWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Function onSubmitted;
  final bool isListening;
  final Function() onVoiceStart;
  final Function() onVoiceStop;
  final bool micAvailable;

  const InputWidget({
    required this.textEditingController,
    required this.onSubmitted,
    required this.isListening,
    required this.onVoiceStart,
    required this.onVoiceStop,
    required this.micAvailable,
    super.key,
  });

  @override
  State<InputWidget> createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(28),
            ),
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // IconButton(
              //   onPressed: !widget.isListening
              //       ? widget.onVoiceStart
              //       : widget.onVoiceStop,
              //   padding: const EdgeInsets.only(bottom: 8),
              //   icon:
              //       //  widget.isListening
              //       //     ? const ListeningIcon()
              //       //     :
              //       Icon(
              //     micIcon,
              //     color: Theme.of(context).hintColor,
              //   ),
              // ),
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  textInputAction: TextInputAction.newline,
                  decoration: InputDecoration(
                    fillColor: Theme.of(context).colorScheme.onBackground,
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.only(
                        left: 16, right: 16, bottom: 16, top: 0),
                    suffixIcon: IconButton(
                      constraints: const BoxConstraints(),
                      onPressed: () {
                        widget.textEditingController.clear();
                      },
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(28),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.3),
                      ),
                    ),
                    hintText:
                        widget.isListening ? 'Listening...' : 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(28),
                      ),
                      borderSide: BorderSide(
                        width: 0.5,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      ),
                    ),
                  ),
                  controller: widget.textEditingController,
                  onSubmitted: (value) {
                    widget.onSubmitted.call();
                  },
                ),
              ),
              IconButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
                padding: const EdgeInsets.only(left: 0, right: 4),
                icon: const Icon(Icons.send_rounded),
                color: Colors.white,
                onPressed: () {
                  if (!widget.isListening) {
                    widget.onSubmitted.call();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
