import 'package:flutter/material.dart';
import 'package:my_movie/src/models/actores_model.dart';
import 'package:my_movie/src/models/pelicula_model.dart';
import 'package:my_movie/src/pages/video_page.dart';
import 'package:my_movie/src/providers/peliculas_provider.dart';

class PeliculaDetalle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Pelicula pelicula = ModalRoute.of(context).settings.arguments;
  
    return Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            _crearAppbar(pelicula),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 50.0),
                _posterTitulo(pelicula, context),
                _botonTrailer(context, pelicula),
                SizedBox(height: 15.0),
                _descripcion(pelicula),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text('ACTORES', style: TextStyle(fontSize: 50, color: Colors.blueGrey)),
                ),
                _crearCasting(pelicula)
              ]),
            )
          ],
        )
    );
  }

  Widget _botonTrailer(BuildContext context, Pelicula pelicula){
    final provider = PeliculasProvider(); 
    return FutureBuilder(
      future: provider.getTrailer(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot){
        if(snapshot.hasData){
          if(snapshot.data == '') return Container();
          return Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 25.0, right: 25.0),
            child: RaisedButton(
              child: Text('Ver Trailer'),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              color: Colors.blueAccent,
              textColor: Colors.white,
              onPressed: (){
                Navigator.push(context, PageRouteBuilder(
                  pageBuilder: (_,__,___) => VideoPage(video: snapshot.data)
                ));
              },
            ),
          );
        }
        else{
          return Container();
        }
      },
    );
  }

  Widget _crearAppbar(Pelicula pelicula){
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 300.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          pelicula.title, 
          style: TextStyle(
            color: Colors.white, 
            fontSize: 16.0
          )
        ),
        background: FadeInImage(
          image: NetworkImage(
            pelicula.getBackgroundImg()
          ),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover
        ),
      ),
    );
  }

  Widget _posterTitulo(Pelicula pelicula, BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          Hero(
            tag: pelicula.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image(
                image: NetworkImage(pelicula.getPosterImg()),
                height: 200.0,
              ),
            ),
          ),
          SizedBox(width: 20.0,),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(pelicula.title, style: Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
                Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
                Row(
                  children: <Widget>[
                    Icon(Icons.star_border),
                    Text(pelicula.voteAverage.toString(), style: Theme.of(context).textTheme.subhead)
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _descripcion(Pelicula pelicula){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      child: Text(
        pelicula.overview,
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize: 20.0)
      ),
    );
  }

  Widget _crearCasting(Pelicula pelicula){
    final peliProvider = new PeliculasProvider();
    return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      //En este punto el snapshot es una lista de actores
      builder: (BuildContext context, AsyncSnapshot<List> snapshot){
        if(snapshot.hasData){
          return _crearActoresPageView(snapshot.data);
        }
        else
        {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _crearActoresPageView(List<Actor> actores){
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false, //para que mantega el momento al hacer scroll
        itemCount: actores.length,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 1
        ),
        itemBuilder: (context, i) => _actorTarjeta(actores[i]),
      ),
    );
  }

  Widget _actorTarjeta(Actor actor){
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(
                actor.getFoto()
              ),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(actor.name, overflow: TextOverflow.ellipsis,)
        ],
      ),
    );
  }

}