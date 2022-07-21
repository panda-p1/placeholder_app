import 'package:flutter/material.dart';
import 'package:placeholder_app/data/album/album.dart';

class AlbumTableView extends StatelessWidget {
  final List<Album> albums;
  final Widget Function(Album) itemBuilder;
  const AlbumTableView(this.albums, {Key? key,
    required this.itemBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Table(
      children: _getTableRows(),
    );
  }

  List<TableRow> _getTableRows() {
    final List<List<Album?>> pairs = [[]];

    for(var index = 0; index < albums.length; index++) {
      final album = albums[index];

      if(pairs.last.isEmpty || pairs.last.length == 1) {
        pairs.last.add(album);
        continue;
      }

      pairs.add([album]);
    }

    if(pairs.last.length == 1) {
      pairs.last.add(null);
    }

    return pairs.map((pair) => TableRow(
      children: pair.map((album) {
        if(album == null) {
          return const SizedBox();
        }
        return itemBuilder(album);
      }).toList(),
    )).toList();
  }

}
