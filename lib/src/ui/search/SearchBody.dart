part of 'SearchForm.dart';

class _SearchBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordSearchBloc, WordSearchState>(
      bloc: BlocProvider.of<WordSearchBloc>(context),
      builder: (BuildContext context, WordSearchState state) {
        if (state is SearchStateEmpty) return Text('Please enter to begin');
        if (state is SearchStateLoading) return CircularProgressIndicator();
        if (state is SearchStateError) return Text(state.error);
        if (state is SearchStateSuccess)
          return state.items.results.data.isEmpty
              ? Text('No Results')
              : Expanded(
                  child: _SearchResults(items: state.items.results.data));
        return SizedBox();
      },
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List<String> items;

  const _SearchResults({Key key, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return _SearchResultItem(item: items[index]);
      },
    );
  }
}

class _SearchResultItem extends StatelessWidget {
  final String item;

  const _SearchResultItem({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item),
      leading: Icon(Icons.search),
      trailing: buildTrailingIcon(item, context),
      onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(
              builder: (_) => SafeArea(child: WordScreen(word: item)))),
    );
  }

  Transform buildTrailingIcon(String q, BuildContext context) {
    return Transform.rotate(
      angle: 270 * pi / 180,
      child: IconButton(
          icon: Icon(Icons.call_made),
          onPressed: () {
            BlocProvider.of<WordSearchBloc>(context)
              ..textController.text = q
              ..add(TextChanged(query: q));
          }),
    );
  }
}
