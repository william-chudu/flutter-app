part of '../index.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key, required this.label});

  final LanguageLabel label;

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final accountController = TextEditingController(text: '0328381259');
  final passwordController = TextEditingController(text: '123123');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final signInStream = StreamController<Progress>();

  @override
  void initState() {
    super.initState();
  }

  void onTapSignIn() {
    if (accountController.text.trim().isEmpty || passwordController.text.isEmpty) {
      return;
    }

    if (formKey.currentState?.validate() != true) {
      return;
    }

    signInStream.sink.add(Progress.loading);

    context.read<AuthenticationBloc>().add(
          SignInEvent(
            param: ParamSignIn(
              username: accountController.text,
              password: passwordController.text,
            ),
          ),
        );
  }

  @override
  void dispose() {
    signInStream.close();
    accountController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputBox(
              label: widget.label.emailOrPhone,
              inputController: accountController,
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                return Utils.string.validateMobile(text);
              },
            ),
            const SizedBox(height: 10),
            InputBox(
              label: widget.label.password,
              inputController: passwordController,
              isObscured: true,
              validator: (text) {
                if (text == null) {
                  return 'Password is not null';
                }
                if (text.length < 5) {
                  return 'Password should contain more than 5 characters';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            StreamBuilder<Progress>(
              stream: signInStream.stream,
              initialData: Progress.initial,
              builder: (context, snapshot) {
                final isDisabled = snapshot.data == Progress.loading;
                final isLoading = snapshot.data == Progress.loading;
                return ButtonFilledWidget(
                  onTap: onTapSignIn,
                  isDisabled: isDisabled,
                  isLoading: isLoading,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Center(
                    child: Text(
                      widget.label.signIn,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
