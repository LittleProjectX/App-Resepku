import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/addResep/bindings/add_resep_binding.dart';
import '../modules/addResep/views/add_resep_view.dart';
import '../modules/all_resep/bindings/all_resep_binding.dart';
import '../modules/all_resep/views/all_resep_view.dart';
import '../modules/auth_gate/bindings/auth_gate_binding.dart';
import '../modules/auth_gate/views/auth_gate_view.dart';
import '../modules/author/bindings/author_binding.dart';
import '../modules/author/views/author_view.dart';
import '../modules/detail/bindings/detail_binding.dart';
import '../modules/detail/views/detail_view.dart';
import '../modules/detailUser/bindings/detail_user_binding.dart';
import '../modules/detailUser/views/detail_user_view.dart';
import '../modules/editProfile/bindings/edit_profile_binding.dart';
import '../modules/editProfile/views/edit_profile_view.dart';
import '../modules/edit_password/bindings/edit_password_binding.dart';
import '../modules/edit_password/views/edit_password_view.dart';
import '../modules/firstUserData/bindings/first_user_data_binding.dart';
import '../modules/firstUserData/views/first_user_data_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/instruction/bindings/instruction_binding.dart';
import '../modules/instruction/views/instruction_view.dart';
import '../modules/loadImage/bindings/load_image_binding.dart';
import '../modules/loadImage/views/load_image_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/main/bindings/main_binding.dart';
import '../modules/main/views/main_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/save_resep/bindings/save_resep_binding.dart';
import '../modules/save_resep/views/save_resep_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/started/bindings/started_binding.dart';
import '../modules/started/views/started_view.dart';
import '../modules/update_password/bindings/update_password_binding.dart';
import '../modules/update_password/views/update_password_view.dart';
import '../modules/wait_reset_password/bindings/wait_reset_password_binding.dart';
import '../modules/wait_reset_password/views/wait_reset_password_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.AUTH_GATE;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.STARTED,
      page: () => const StartedView(),
      binding: StartedBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.AUTH_GATE,
      page: () => const AuthGateView(),
      binding: AuthGateBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL,
      page: () => const DetailView(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => const SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_USER,
      page: () => const DetailUserView(),
      binding: DetailUserBinding(),
    ),
    GetPage(
      name: _Paths.FIRST_USER_DATA,
      page: () => const FirstUserDataView(),
      binding: FirstUserDataBinding(),
    ),
    GetPage(
      name: _Paths.LOAD_IMAGE,
      page: () => const LoadImageView(),
      binding: LoadImageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_RESEP,
      page: () => const AddResepView(),
      binding: AddResepBinding(),
    ),
    GetPage(
      name: _Paths.ALL_RESEP,
      page: () => const AllResepView(),
      binding: AllResepBinding(),
    ),
    GetPage(
      name: _Paths.AUTHOR,
      page: () => const AuthorView(),
      binding: AuthorBinding(),
    ),
    GetPage(
      name: _Paths.SAVE_RESEP,
      page: () => const SaveResepView(),
      binding: SaveResepBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PASSWORD,
      page: () => const EditPasswordView(),
      binding: EditPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ABOUT,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    GetPage(
      name: _Paths.INSTRUCTION,
      page: () => const InstructionView(),
      binding: InstructionBinding(),
    ),
    GetPage(
      name: _Paths.WAIT_RESET_PASSWORD,
      page: () => const WaitResetPasswordView(),
      binding: WaitResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.UPDATE_PASSWORD,
      page: () => const UpdatePasswordView(),
      binding: UpdatePasswordBinding(),
    ),
  ];
}
