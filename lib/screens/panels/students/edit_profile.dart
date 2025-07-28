import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text("Editer Profil"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          children: [
            ProfilePic(
              image: 'https://i.postimg.cc/cCsYDjvj/user-2.png',
              imageUploadBtnPress: () {},
            ),
            const Divider(),
            Form(
              child: Column(
                children: [
                  UserInfoEditField(
                    text: "Nom",
                    child: TextFormField(
                      initialValue: "Annette Black",
                      decoration: InputDecoration(
                        // ✅ Bordure par défaut (champ inactif)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),

                        // ✅ Bordure quand le champ est focus
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 0.5, // ✅ plus épais quand focus
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.indigo.withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Email",
                    child: TextFormField(
                      initialValue: "annette@gmail.com",
                      decoration: InputDecoration(
                        // ✅ Bordure par défaut (champ inactif)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),

                        // ✅ Bordure quand le champ est focus
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 0.5, // ✅ plus épais quand focus
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.indigo.withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "TelePhone",
                    child: TextFormField(
                      initialValue: "(316) 555-0116",
                      decoration: InputDecoration(
                        // ✅ Bordure par défaut (champ inactif)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),

                        // ✅ Bordure quand le champ est focus
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 0.5, // ✅ plus épais quand focus
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.indigo.withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Ancien Mot de passe",
                    child: TextFormField(
                      obscureText: true,
                      initialValue: "demopass",
                      decoration: InputDecoration(
                        // ✅ Bordure par défaut (champ inactif)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),

                        // ✅ Bordure quand le champ est focus
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 0.5, // ✅ plus épais quand focus
                          ),
                        ),
                        suffixIcon: const Icon(Icons.visibility_off, size: 20),
                        filled: true,
                        fillColor: Colors.indigo.withValues(alpha: 0.05),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                  UserInfoEditField(
                    text: "Nouveau Mot de passe",
                    child: TextFormField(
                      decoration: InputDecoration(
                        // ✅ Bordure par défaut (champ inactif)
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.grey,
                            width: 0.5,
                          ),
                        ),

                        // ✅ Bordure quand le champ est focus
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            color: Colors.indigoAccent,
                            width: 0.5, // ✅ plus épais quand focus
                          ),
                        ),

                        hintText: "Nouveau mot de passe",
                        filled: true,
                        fillColor: Colors.indigo.withValues(alpha: 0.06),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0 * 1.5,
                          vertical: 16.0,
                        ),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    child: const Text("Annuler.."),
                  ),
                ),
                const SizedBox(width: 10.0),
                SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BF6D),
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 48),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                    ),
                    onPressed: () {},
                    child: const Text("Sauvegarder "),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
          color: Theme.of(
            context,
          ).textTheme.bodyLarge!.color!.withValues(alpha: 0.08),
        ),
      ),
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(radius: 50, backgroundImage: NetworkImage(image)),
          InkWell(
            onTap: imageUploadBtnPress,
            child: CircleAvatar(
              radius: 13,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(Icons.add, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoEditField extends StatelessWidget {
  const UserInfoEditField({super.key, required this.text, required this.child});

  final String text;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0 / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text, style: Theme.of(context).textTheme.titleSmall),
          const SizedBox(height: 16.0 / 2),
          child,
        ],
      ),
    );
  }
}
