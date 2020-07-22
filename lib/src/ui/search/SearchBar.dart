part of 'SearchForm.dart';

class _SearchBar extends StatefulWidget {
  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  WordSearchBloc _wordSearchBloc;

  @override
  void initState() {
    super.initState();
    _wordSearchBloc = BlocProvider.of<WordSearchBloc>(context);
  }

  @override
  void dispose() {
    _wordSearchBloc.textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _wordSearchBloc.textController,
      autocorrect: false,
      onChanged: (text) {
        _wordSearchBloc.add(TextChanged(query: text));
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search),
        suffixIcon: GestureDetector(
          child: Icon(Icons.clear),
          onTap: _onClearTapped,
        ),
        border: InputBorder.none,
        hintText: 'Enter a search term',
      ),

    );
  }

  void _onClearTapped() {
    _wordSearchBloc.textController.text = '';
    _wordSearchBloc.add(TextChanged(query: ''));
  }
}
