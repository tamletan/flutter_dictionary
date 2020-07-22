import 'dart:math' show pi;

import 'package:flutter/cupertino.dart' show CupertinoPageRoute;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;

import '../blocs/word_search_bloc.dart';
import '../models/search/word_search_event.dart';
import '../models/search/word_search_state.dart'
    show SearchStateSuccess, WordSearchState;
import 'WordScreen.dart';

class SearchBar extends StatefulWidget {
  @override
  State<SearchBar> createState() => SearchBarState();
}

class SearchBarState extends State<SearchBar> {
  WordSearchBloc _wordSearchBloc;
  final FocusNode _focusNode = FocusNode();

  OverlayEntry _overlayEntry;

  @override
  void initState() {
    super.initState();
    _wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        this._overlayEntry = this._createOverlayEntry();
        Overlay.of(context).insert(this._overlayEntry);
      } else {
        this._overlayEntry.remove();
      }
    });
  }

  @override
  void dispose() {
//    _wordSearchBloc.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: TextField(
        controller: _wordSearchBloc.textController,
        focusNode: this._focusNode,
        autocorrect: false,
        onChanged: (text) => _wordSearchBloc.add(TextChanged(query: text)),
        style: TextStyle(color: Colors.white, fontSize: 18),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search, color: Colors.white),
          suffixIcon: GestureDetector(
            child: Icon(Icons.clear, color: Colors.white),
            onTap: _onClearTapped,
          ),
          border: InputBorder.none,
          hintText: 'Enter a search term',
          hintStyle: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  void _onClearTapped() {
    _wordSearchBloc.textController.text = '';
    _wordSearchBloc.add(TextChanged(query: ''));
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
      builder: (context) => Positioned(
        left: offset.dx + 5,
        top: offset.dy + size.height + 5,
        width: size.width - 10,
        child: Material(
          elevation: 4,
          child: BlocBuilder<WordSearchBloc, WordSearchState>(
            bloc: _wordSearchBloc,
            builder: (BuildContext context, WordSearchState state) {
              if (state is SearchStateSuccess &&
                  state.items.results.data.isNotEmpty)
                return LimitedBox(
                    maxHeight: 58 * 4 + 10.0,
                    child: buildListResult(state.items.results.data));
              return SizedBox();
            },
          ),
        ),
      ),
    );
  }

  Widget buildListResult(List<String> items) {
    return ListView.builder(
      itemExtent: 58.0,
      shrinkWrap: true,
      padding: EdgeInsets.all(0),
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return buildItem(items[index], index, context);
      },
    );
  }

  Widget buildItem(String item, int index, BuildContext context) {
    return Ink(
      color: Colors.blue,
      child: ListTile(
        title: Text(item, style: TextStyle(color: Colors.white, fontSize: 18)),
        leading: Icon(Icons.search, color: Colors.white),
        trailing: buildTrailingIcon(item, context),
        onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (_) => SafeArea(child: WordScreen(word: item)))),
      ),
    );
  }

  Transform buildTrailingIcon(String query, BuildContext context) {
    return Transform.rotate(
      angle: 270 * pi / 180,
      child: IconButton(
          icon: Icon(Icons.call_made, color: Colors.white),
          onPressed: () {
            _wordSearchBloc
              ..textController.text = query
              ..add(TextChanged(query: query));
          }),
    );
  }
}
