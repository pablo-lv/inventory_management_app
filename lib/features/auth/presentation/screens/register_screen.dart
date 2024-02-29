import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:inventory_management_app/config/config.dart';
import 'package:inventory_management_app/features/auth/presentation/providers/auth_provider.dart';
import 'package:inventory_management_app/features/shared/shared.dart';
import '../providers/register_form_provider.dart';


class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: GeometricalBackground( 
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox( height: 80 ),
                // Icon Banner
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: (){
                        if ( !context.canPop() ) return;
                        context.pop();
                      }, 
                      icon: const Icon( Icons.arrow_back_rounded, size: 40, color: Colors.white )
                    ),
                    const Spacer(flex: 1),
                    Icon(Icons.supervisor_account_outlined,
                    color: Colors.white,
                    size: 70
                    ),
                    const Spacer(flex: 2),
                  ],
                ),

                const SizedBox( height: 50 ),
    
                Container(
                  height: size.height - 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: const _RegisterForm(),
                )
              ],
            ),
          )
        )
      ),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message))
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final registerForm = ref.watch(registerFormProvider);

    final textStyles = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          // const SizedBox( height: 10 ),
          Text('Nueva cuenta', style: textStyles.titleMedium ),
          const SizedBox( height: 10 ),

          CustomTextFormField(
            label: 'Nombre completo',
            keyboardType: TextInputType.text,
            onChanged: ref.read(registerFormProvider.notifier).onFullNameChange,
            errorMessage: registerForm.isFormPosted ? registerForm.fullName.errorMessage : null,
          ),
          const SizedBox( height: 10 ),

          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: ref.read(registerFormProvider.notifier).onEmailChange,
            errorMessage: registerForm.isFormPosted ? registerForm.email.errorMessage : null,
          ),
          const SizedBox( height: 10 ),

          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onPasswordChange,
            errorMessage: registerForm.isFormPosted ? registerForm.password.errorMessage : null,
          ),
    
          const SizedBox( height: 10 ),

          CustomTextFormField(
            label: 'Repita la contraseña',
            obscureText: true,
            onChanged: ref.read(registerFormProvider.notifier).onConfirmPasswordChange,
            errorMessage: registerForm.isFormPosted ? registerForm.confirmPassword.errorMessage : null,
          ),
    
          const SizedBox( height: 10 ),

          SizedBox(
            width: double.infinity,
            height:60,
            child: CustomFilledButton(
              text: 'Crear',
              buttonColor: buttonColor,
              onPressed: registerForm.isPosting ? null :
              ref.read(registerFormProvider.notifier).onFormSubmit,
            )
          ),

          const Spacer( flex: 2 ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                onPressed: (){
                  if ( context.canPop()){
                    return context.pop();
                  }
                  context.go('/login');
                  
                }, 
                child: const Text('Ingresa aquí')
              )
            ],
          ),

          const Spacer( flex: 1),
        ],
      ),
    );
  }
}