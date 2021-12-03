import 'package:bloc_migration/home/bloc/home_bloc.dart';
import 'package:bloc_migration/services/fakenetwork.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Sample'),
      ),
      body: BlocProvider(
        create: (context) => HomeBloc(RepositoryProvider.of<FakeNetworkService>(context))
          ..add(
            LoadHomeEvent(),
          ),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoadedState) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Text('Welcome to the app! Press the button.'),
                  ),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(RunLongRunningEvent()),
                    child: Text('LONG RUNNING OPERATION'),
                  ),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                      RunLongRunningStreamedEvent(),
                    ),
                    child: Text('LONG RUNNING STREAMED OPERATION'),
                  ),
                  ElevatedButton(
                    onPressed: () => BlocProvider.of<HomeBloc>(context).add(
                      RunLongRunningStreamedComplexEvent(),
                    ),
                    child: Text('LONG RUNNING STREAMED OPERATION WITH COMPLEX OBJECT'),
                  ),
                ],
              );
            }
            if (state is HomeLoadingState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: CircularProgressIndicator()),
                  Text(state.loadingStatus),
                  if (state.icon != null)
                    Icon(
                      state.icon,
                      size: 30,
                    )
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
