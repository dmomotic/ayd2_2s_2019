import 'package:flutter/material.dart';
import 'package:my_movie/src/providers/peliculas_provider.dart';
import 'package:my_movie/src/search/search_delegate.dart';
import 'package:my_movie/src/widgets/card_swiper_widget.dart';
import 'package:my_movie/src/widgets/movie_horizontal_widget.dart';

class HomePage extends StatelessWidget {

  final peliculasProvider = new PeliculasProvider();

  @override
  Widget build(BuildContext context) {

  final String _email = ModalRoute.of(context).settings.arguments ?? '';
    peliculasProvider.getPolulares();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Peliculas en cine'),
        backgroundColor: Colors.deepOrangeAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch());
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],
        ),
      ),
      drawer: _drawer(context, _email)
    );
  }

  Widget _swiperTarjetas(){
    return FutureBuilder(
      future: peliculasProvider.getEnCines(),
      //El snapshot contiene todas las peliculas procesadas, es una lista de peliculas
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if(snapshot.hasData){
          return CardSwiper( peliculas: snapshot.data );
        }
        else{
          return Container(
            height: 400.0,
            child: Center(
              child: CircularProgressIndicator()
            ),
          );
        }
      },
    );
  }

  Widget _drawer(BuildContext context, String email){
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("User email"),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage("https://cdn3.iconfinder.com/data/icons/vector-icons-6/96/256-512.png"),
            ),
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage("https://image.freepik.com/free-photo/river-foggy-mountains-landscape_1204-511.jpg")
              )
            ),
          ),
          ListTile(
            title: Text("Ocultar"),
            trailing: Icon(Icons.arrow_back),
            onTap: () => Navigator.of(context).pop(),
          ),
          Divider(),
          ListTile(
            title: Text("Cerrar sesion"),
            trailing: Icon(Icons.cancel),
            onTap: () => Navigator.pushReplacementNamed(context, 'login'),
          )
        ],
      )
    );
  }

  Widget _footer(BuildContext context){
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
          ),
          SizedBox(height: 5.0),
          StreamBuilder(
            stream: peliculasProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if(snapshot.hasData){
                return MovieHorizontal(
                  peliculas: snapshot.data, 
                  siguientePagina: peliculasProvider.getPolulares
                );
              }
              else{
                return Center(
                  child: CircularProgressIndicator()
                );
              }
            },
          ),

        ],
      ),
    );
  }

}