import 'package:flutterfire_ui/i10n.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Mailinizi Girin';

  @override
  String get passwordInputLabel => 'Şifrenizi Girin';

  @override
  String get signInActionText => "Giriş yap";

  @override
  String get registerActionText => "Kayıt Ol";

  @override
  String get signInButtonText => "Giriş yap";

  @override
  String get signInWithGoogleButtonText => "Google ile giriş yap";

  @override
  String get registerButtonText => "Kayıt ol";

  // @override
  // String get linkEmailButtonText => "";
  @override
  String get signInText => "Giriş yap";

  @override
  String get signInHintText => "Zaten hesabın var mı?";

  @override
  String get registerText => "Kaydol";

  @override
  String get registerHintText => "Hesabın yok mu?";

  // @override
  // String get signInHintText => "Hesabın";
  @override
  String get forgotPasswordButtonLabel => "Şifremi unuttum";

  @override
  String get forgotPasswordViewTitle => "Şifre sıfırlama";

  @override
  String get forgotPasswordHintText =>
      "Emailinizi girin ve size gönderilen maildeki linke tıklayarak şifrenizi sıfırlayın";

  @override
  String get resetPasswordButtonLabel => "Şifreyi sıfırla";

  @override
  String get passwordResetEmailSentText =>
      "Sana bir şifre sıfırlama maili gönderdik maildeki linke tıklayıp şifreni sıfırlayabilirsin.";

  @override
  String get goBackButtonLabel => "Geri dön";

  // Errors
  // String get confirmPasswordIsRequiredErrorText;
  // String get confirmPasswordDoesNotMatchErrorText;
  @override
  String get confirmPasswordInputLabel => "Şifrenizi onaylayın";

  @override
  String get unknownError => "Bilinmeyen hata";

  @override
  String get smsAutoresolutionFailedError => "Sms çözümleme hatası";

  @override
  String get emailIsRequiredErrorText => "Email girin";

  @override
  String get isNotAValidEmailErrorText => "Geçerli bir email girin";

  @override
  String get userNotFoundErrorText => "Kullanıcı bulunamadı";

  // @override
  // String get emailTakenErrorText;

  @override
  String get accessDisabledErrorText => "İzin reddedildi";

  @override
  String get wrongOrNoPasswordErrorText => "Hatalı veya geçersiz şifre";

  @override
  String get phoneNumberIsRequiredErrorText => "Telefon numarası girin";

  @override
  String get phoneNumberInvalidErrorText => "Geçersiz telefon numarası";

  @override
  String get passwordIsRequiredErrorText => "Şifre gerekli";

  @override
  String get confirmPasswordIsRequiredErrorText => "Şifrenizi onaylayın";

  @override
  String get confirmPasswordDoesNotMatchErrorText => "Şifreler eşleşmiyor";

  @override
  String get codeRequiredErrorText => "Kod gerekli";

  // String get emailInputLabel => 'E-mail';
  // String get passwordInputLabel => 'Şifre';
  // String get signInActionText => 'Giriş yap';
  // String get registerActionText => 'Kayıt ol';
  // String get signInButtonText => 'Giriş yap';
  // String get registerButtonText => 'Kayıt ol';
  String get linkEmailButtonText => 'İleri';
  String get signInWithPhoneButtonText => 'Telefon ile giriş yap';
  // String get signInWithGoogleButtonText => 'Google ile giriş yap';
  String get signInWithAppleButtonText => 'Apple ile giriş yap';
  String get signInWithTwitterButtonText => 'Twitter ile giriş yap';
  String get signInWithFacebookButtonText => 'Facebook ile giriş yap';
  String get phoneVerificationViewTitleText => 'Telefon numaranızı girin';
  String get verifyPhoneNumberButtonText => 'İleri';
  String get verifyCodeButtonText => 'Doğrula';
  String get verifyingPhoneNumberViewTitle => 'SMS ile gelen kodu girin';
  // String get unknownError => 'Bilinmeyen bir hata meydana geldi';
  // String get smsAutoresolutionFailedError => 'SMS =>odu otomatik olarak eklenemedi. Lütfen kodu manuel olarak girin';
  String get smsCodeSentText => 'SMS kodu gönderildi';
  String get sendingSMSCodeText => 'SMS kodu gönderiliyor...';
  String get verifyingSMSCodeText => 'SMS kodu doğrulanıyor...';
  String get enterSMSCodeText => 'SMS kodunu girin';
  // String get emailIsRequiredErrorText => 'E-mail gerekli';
  // String get isNotAValidEmailErrorText => 'Geçerli bir e-mail adresi girin';
  // String get userNotFoundErrorText => 'Hesap bulunamadı';
  String get emailTakenErrorText => 'Bu email ile bir hesap mevcut';
  // String get accessDisabledErrorText => 'Bu =>esaba erişim geçici olarak devre dışı bırakıldı.';
  // String get wrongOrNoPasswordErrorText => 'Şifre =>eçersiz veya kullanıcının bir şifresi yok';
  // String get signInText => 'Giriş yap';
  // String get registerText => 'Kayıt ol';
  // String get registerHintText => 'Hesabın yok mu?';
  // String get signInHintText => 'Zaten bir hesabın var mı?';
  String get signOutButtonText => 'Çıkış yap';
  String get phoneInputLabel => 'Telefon numarası';
  // String get phoneNumberInvalidErrorText => 'Telefon numarası geçersiz';
  // String get phoneNumberIsRequiredErrorText => 'Telefon numarası gerekli';
  String get profile => 'Profil';
  String get name => 'İsim';
  String get deleteAccount => 'Hesabı sil';
  // String get passwordIsRequiredErrorText => 'Şifre gerekli';
  // String get confirmPasswordIsRequiredErrorText => 'Şifrenizi onaylayın';
  // String get confirmPasswordDoesNotMatchErrorText => 'Şifreler uyuşmadı';
  // String get confirmPasswordInputLabel => 'Şifreni onayla';
  // String get forgotPasswordButtonLabel => 'Şifrenizi mi unuttunuz?';
  // String get forgotPasswordViewTitle => 'Şifremi unuttum';
  // String get resetPasswordButtonLabel => 'Şifreyi sıfırla';
  String get verifyItsYouText => 'Siz olduğunuzu doğrulayın';
  String get differentMethodsSignInTitleText =>
      'Giriş =>apmak için aşağıdaki yöntemlerden birini kullanın';
  String get findProviderForEmailTitleText =>
      'Devam etmek için email adresinizi girin';
  String get continueText => 'Devam et';
  String get countryCode => 'Kod';
  // String get codeRequiredErrorText => 'Ülke kodu gerekli';
  String get invalidCountryCode => 'Geçersiz kod';
  String get chooseACountry => 'Bir ülke seçin';
  String get enableMoreSignInMethods =>
      'Daha fazla oturum açma yöntemi etkinleştir';
  String get signInMethods => 'Oturum açma yöntemleri';
  String get provideEmail => 'Email ve şifrenizi girin';
  // String get goBackButtonLabel => 'Geri git';
  // String get passwordResetEmailSentText => 'Şifrenizi sıfırlamak için size email ile bir link gönderdik. Lütfen emailinizi kontrol edin.';
  // String get forgotPasswordHintText => 'Email adresinizi verin ve size şifrenizi sıfırlamanız için bir bağlantı gönderelim';
  String get emailLinkSignInButtonLabel => 'Sihirli bağlantı ile giriş yap';
  String get signInWithEmailLinkViewTitleText =>
      'Sihirli bağlantı ile giriş yap';
  String get signInWithEmailLinkSentText =>
      'Sana sihirli bir link ile bir email gönderdik. Emailinizi kontrol edin ve oturum açmak için bağlantıyı takip edin';
  String get sendLinkButtonLabel => 'Sihirli bağlantı gönder';
  String get arrayLabel => 'array';
  String get booleanLabel => 'boolean';
  String get mapLabel => 'map';
  String get nullLabel => 'null';
  String get numberLabel => 'number';
  String get stringLabel => 'string';
  String get typeLabel => 'type';
  String get valueLabel => 'value';
  String get cancelLabel => 'iptal';
  String get updateLabel => 'güncelle';
  String get northInitialLabel => 'K';
  String get southInitialLabel => 'G';
  String get westInitialLabel => 'D';
  String get eastInitialLabel => 'B';
  String get timestampLabel => 'timestamp';
  String get longitudeLabel => 'longitude';
  String get latitudeLabel => 'latitude';
  String get geopointLabel => 'geopoint';
  String get referenceLabel => 'reference';
}
