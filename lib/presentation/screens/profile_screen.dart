// presentation/screens/profile_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../cubit/profile_cubit/profile_cubit.dart';
import '../../cubit/profile_cubit/profile_state.dart';
import '../widgets/basescaffold.dart';
import '../widgets/gradient_button.dart';
import '../widgets/profile_avatar.dart';
import 'auth/user_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().loadProfile();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      title: "My Profile",
      actions: [
        IconButton(
          icon: Icon(Icons.people),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => UsersScreen()),
            );
          },
        )
      ],
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileUpdated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          } else if (state is ProfileLoaded) {
            _nameController.text = state.user.name;
            _bioController.text = state.user.bio;
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (state is ProfileLoaded) {
            final user = state.user;

            return LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 600;

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: isWide ? 500 : double.infinity,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Center(
                            child: ProfileAvatar(
                              name: user.name,
                              imageUrl: user.profilePic,
                              size: isWide ? 150 : 100,
                              onTap: _pickImage,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: "Full Name",
                              border: OutlineInputBorder(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: _bioController,
                            decoration: const InputDecoration(
                              labelText: "Bio",
                              border: OutlineInputBorder(),
                            ),
                            maxLines: 3,
                          ),
                          const SizedBox(height: 20),
                          GradientButton(
                            text: "💾 Save Changes",
                            onPressed: () {
                              context.read<ProfileCubit>().updateProfile(
                                    user.copyWith(
                                      name: _nameController.text.trim(),
                                      bio: _bioController.text.trim(),
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return const Center(child: Text("No profile loaded"));
        },
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      context.read<ProfileCubit>().updateProfileImage(File(picked.path));
    }
  }
}
