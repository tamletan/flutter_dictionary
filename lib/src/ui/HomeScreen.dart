import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocBuilder;
import 'package:flutter_svg/svg.dart';

import '../blocs/word_search_bloc.dart';
import '../models/search/word_search_event.dart';
import '../models/search/word_search_state.dart'
    show SearchStateSuccess, WordSearchState;

class HomeScreen extends StatefulWidget {
  final String title;

  HomeScreen({Key key, this.title}) : super(key: key);

  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final textController = TextEditingController();
  WordSearchBloc _wordSearchBloc = WordSearchBloc();
  final FocusNode _focusNode = FocusNode();
  final _style = TextStyle(color: Colors.white, fontSize: 18);
  OverlayEntry _overlayEntry;
  final LayerLink _layerLink = LayerLink();

  @override
  void initState() {
    super.initState();

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
  Widget build(BuildContext context) {
    var logo = SvgPicture.asset("assets/logo.svg");
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (currentFocus != _focusNode) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: logo,
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48.0),
            child: BlocProvider<WordSearchBloc>(
              create: (context) => _wordSearchBloc,
              child: buildSearchBar(),
            ),
          ),
        ),
        body: buildHorizontalListView(),
      ),
    );
  }

  Widget buildSearchBar() {
    return CompositedTransformTarget(
      link: this._layerLink,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: TextField(
          controller: textController,
          focusNode: this._focusNode,
          autocorrect: false,
          autofocus: false,
          onChanged: (text) => _wordSearchBloc.add(TextChanged(query:  text)),
          style: _style,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.search, color: Colors.white),
            suffixIcon: GestureDetector(
              child: Icon(Icons.clear, color: Colors.white),
              onTap: () {
                textController.text = '';
                _wordSearchBloc.add(TextChanged(query: ''));
              },
            ),
            border: InputBorder.none,
            hintText: 'Enter a search term',
            hintStyle: _style,
          ),
        ),
      ),
    );
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;

    return OverlayEntry(
      builder: (context) => Positioned(
        width: size.width - 10,
        child: CompositedTransformFollower(
          link: this._layerLink,
          offset: Offset(5, 58),
          showWhenUnlinked: false,
          child: Material(
            elevation: 4,
            child: BlocBuilder<WordSearchBloc, WordSearchState>(
              bloc: _wordSearchBloc,
              builder: (BuildContext context, WordSearchState state) {
                if (state is SearchStateSuccess &&
                    state.items.results.data.isNotEmpty)
                  return LimitedBox(
                      maxHeight: 58.0 * 4,
                      child: buildListResult(state.items.results.data));
                return SizedBox();
              },
            ),
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
      itemBuilder: (BuildContext context, int index) =>
          buildItemResult(items[index], index, context),
    );
  }

  Widget buildItemResult(String item, int index, BuildContext context) {
    return Ink(
      color: Color(0xFF02BB9F),
      child: ListTile(
        title: Text(item, style: _style),
        leading: Icon(Icons.search, color: Colors.white),
        trailing: buildTrailingIcon(item, context),
        onTap: () async {
          await Navigator.pushNamed(context, 'word/$item');
        },
      ),
    );
  }

  Transform buildTrailingIcon(String query, BuildContext context) {
    return Transform.rotate(
      angle: 270 * pi / 180,
      child: IconButton(
          icon: Icon(Icons.call_made, color: Colors.white),
          onPressed: () {
            textController.text = query;
            _wordSearchBloc.add(TextChanged(query: query));
          }),
    );
  }

  Widget buildHorizontalListView() {
    return ListView(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: <Widget>[
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          color: Theme.of(context).primaryColorDark,
          child: ListTile(
            title: Text(
              "Favorite",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.pushNamed(context, 'fav'),
          ),
        )
      ],
    );
  }
}
