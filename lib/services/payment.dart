import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kkiapay_flutter_sdk/kkiapay_flutter_sdk.dart';

import '../screens/panels/students/students_layout.dart';
import '../stores/states.dart';

void callback(response, context) {
  switch (response['status']) {
    case PAYMENT_CANCELLED:
      Navigator.pop(context);
      debugPrint(PAYMENT_CANCELLED);
      break;

    case PAYMENT_INIT:
      debugPrint(PAYMENT_INIT);
      break;

    case PENDING_PAYMENT:
      debugPrint(PENDING_PAYMENT);
      break;

    case PAYMENT_SUCCESS:
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessScreen(
            amount: response['requestData']['amount'],
            transactionId: response['transactionId'],
          ),
        ),
      );
      break;

    default:
      debugPrint(UNKNOWN_EVENT);
      break;
  }
}

Future<void> initializePayment(BuildContext context) async {
  final user = await Store.getUser();
  final apiKey = "818d7ea06b8d11f0badb8da75a0fda2e";

  final kkiapay = KKiaPay(
    amount: 80000,
    countries: ["BJ", "CI", "SN", "TG"],
    phone: "22961000000",
    name: user?['name'] ?? "Test User",
    email: user?['email'] ?? "emailtest@mail.com",
    reason: 'Transaction reason',
    data: 'Fake data',
    sandbox: true,
    apikey: apiKey,
    callback: callback,
    theme: defaultTheme,
    partnerId: 'AxXxXXxId',
    paymentMethods: ["momo", "card"],
  );

  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => kkiapay),
  );
}

class PaymentStudents extends StatelessWidget {
  const PaymentStudents({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text('Paiement de Scolarité',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              )),
        ),
        body: KkiapaySample(),
      ),
    );
  }
}

class KkiapaySample extends StatelessWidget {
  const KkiapaySample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Paiement Sécurisé',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff222F5A),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choisissez votre méthode de paiement',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildPaymentButton(
                context,
                label: 'Payer via l\'application',
                icon: Icons.phone_android,
                onPressed: () async {
                  await initializePayment(context);
                },
              ),
              const SizedBox(height: 20),
              _buildPaymentButton(
                context,
                label: 'Payer via le web',
                icon: Icons.public,
                onPressed: () {
                  KkiapayFlutterSdkPlatform.instance.pay(
                    KKiaPay(
                      amount: 80000,
                      countries: ["BJ", "CI", "SN", "TG"],
                      phone: "22961000000",
                      name: "Test User",
                      email: "emailtest@mail.com",
                      reason: 'Transaction reason',
                      data: 'Fake data',
                      sandbox: true,
                      apikey: "818d7ea06b8d11f0badb8da75a0fda2e",
                      callback: callback,
                      theme: defaultTheme,
                      partnerId: 'AxXxXXxId',
                      paymentMethods: ["momo", "card"],
                    ),
                    context,
                    callback,
                  );
                },
              ),
              const SizedBox(height: 30),
              const Text(
                'Paiement 100% sécurisé',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentButton(
      BuildContext context, {
        required String label,
        required IconData icon,
        required VoidCallback onPressed,
      }) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
              if (states.contains(WidgetState.pressed)) {
                return Colors.indigo;
              } else if (states.contains(WidgetState.hovered)) {
                return Colors.indigo;
              }
              return Colors.indigo;
            },
          ),
          foregroundColor: WidgetStateProperty.all(Colors.white),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          elevation: WidgetStateProperty.all(4),
          shadowColor: WidgetStateProperty.all(Colors.black26),
          padding: WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

class SuccessScreen extends StatefulWidget {
  final int amount;
  final String transactionId;

  const SuccessScreen({
    super.key,
    required this.amount,
    required this.transactionId,
  });

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    Store.setHasPaidScolarite(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Success',
            style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Payment Successful!',
              style: TextStyle(fontSize: 20, fontWeight:
              FontWeight
                  .bold),
            ),
            const SizedBox(height: 20),
            Text('Amount: \$${widget.amount.toStringAsFixed(2)}'),
            Text('Transaction ID: ${widget.transactionId}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const StudentsLayout()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Continuer',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),),
            ),
          ],
        ),
      ),
    );
  }
}