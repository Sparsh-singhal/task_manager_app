import 'package:go_router/go_router.dart';
import 'package:task_manager_app/history.dart';
import 'package:task_manager_app/homepage.dart';
import 'package:task_manager_app/add_task.dart';
import 'package:task_manager_app/update_task.dart';

GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/add',
    builder: (context, state) => const AddTask(),
  ),
  GoRoute(
    path: '/update',
    builder: (context, state) => const UpdateTask(),
  ),
  GoRoute(
    path: '/history',
    builder: (context, state) => const History(),
  ),
  GoRoute(
    path: '/',
    builder: (context, state) => const MyHomePage(),
  ),
]);
