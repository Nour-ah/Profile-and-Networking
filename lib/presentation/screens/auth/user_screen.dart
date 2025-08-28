// presentation/screens/auth/user_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../cubit/user_cubit/user_state.dart';
import '../../../cubit/user_cubit/usercubit.dart';
import '../../widgets/user_card.dart';
import '../../widgets/basescaffold.dart';

class UsersScreen extends StatefulWidget {
  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().loadUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "All Users",
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            if (state.users.isEmpty) {
              return const Center(child: Text("No users found"));
            }

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;

                if (isWide) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 3,
                    ),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return UserCard(
                        name: user.name,
                        bio: user.bio,
                        imageUrl: user.profilePic,
                        email: "",
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return UserCard(
                        name: user.name,
                        bio: user.bio,
                        imageUrl: user.profilePic,
                        email: "",
                      );
                    },
                  );
                }
              },
            );
          } else if (state is UserError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("No users"));
        },
      ),
    );
  }
}
