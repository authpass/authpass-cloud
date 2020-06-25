import 'package:authpass_cloud_backend/src/env/env.dart';

String emailConfirmationPage(Env env, String token) {
  // language=html
  return '''<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AuthPass: Confirm email address</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.0/css/bulma.min.css">
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
<script>
function onReturnCallback() {
  document.forms[0].submit();
}
</script>
<style>
body {
background-color: white;
}
</style>
</head>
<body>
<div class="modal is-active">
  <div class="modal-background"></div>
  <div class="modal-content">
  <div class="box content">
    <form action="?" method="POST">
      <input type="hidden" name="token" value="$token" />
      <h2>Confirm your email address</h2>
      <p>Click the checkbox to confirm your email address.</p>
      <div class="g-recaptcha" data-sitekey="${env.secrets.recaptchaSiteKey}" data-callback="onReturnCallback"></div>
    </form>
    </div>
  </div>
</div>
</body>
  ''';
}
