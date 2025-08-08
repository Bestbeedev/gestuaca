import 'package:flutter/material.dart';

import '../../../stores/states.dart';

class MyAccount extends StatelessWidget {
  const MyAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScreenInfo();
  }
}



class ProfileScreenInfo extends StatefulWidget {
  const ProfileScreenInfo({super.key});

  @override
  State<ProfileScreenInfo> createState() => _ProfileScreenInfoState();
}

class _ProfileScreenInfoState extends State<ProfileScreenInfo> {
  Map<String, dynamic>? _user;

  Future<void> _checkSession() async {
    await Future.delayed(const Duration(seconds: 0)); // animation/splash delay
    final user = await Store.getUser();
    setState(() {
      _user = user;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkSession();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
        title: Text(
          'Mon Compte',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
        child: Column(
          children: [
            const ProfilePic(image: "https://i.postimg.cc/cCsYDjvj/user-2.png"),
            Text(
              _user != null ? _user!['name'] : "Loading...",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const Divider(height: 16.0 * 2),
            Info(
              infoKey: "Email",
              info: _user != null ? _user!['email'] : "Loading...",
            ),
            const Info(
              infoKey: "Telephone",
              info: "+2295550108",
            ),
            const Info(
              infoKey: "Numero Matricule",
              info: "12345678944499",
            ),
            Info(
              infoKey: "Filiere",
              info: 'SSRI',
            ),
            Info(
              infoKey: "Niveau",
              info: 'Licence 2',
            ),
            const SizedBox(height: 16.0),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BF6D),
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 48),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/edit-profile');
                  },
                  child: const Text("Editer mon profil"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//const Color(0xFF00BF6D)

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
    required this.image,
    this.isShowPhotoUpload = false,
    this.imageUploadBtnPress,
  });

  final String image;
  final bool isShowPhotoUpload;
  final VoidCallback? imageUploadBtnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color:
          Theme.of(context).textTheme.bodyLarge!.color!.withValues(alpha: 0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(image),
          ),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 20,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class Info extends StatelessWidget {
  const Info({
    super.key,
    required this.infoKey,
    required this.info,
  });

  final String infoKey, info;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            infoKey,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .color!
                  .withValues(alpha: 0.8),
            ),
          ),
          Text(info),
        ],
      ),
    );
  }
}
