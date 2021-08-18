import 'dart:convert';

import 'package:authpass_cloud_backend/src/env/env.dart';

String pageScaffold(
  Env env, {
  String Function()? script,
  required String Function() body,
}) {
  // language=html
  return '''<!DOCTYPE html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>AuthPass: Confirm email address</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bulma@0.9.3/css/bulma.min.css">
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=UA-91100035-7"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());

  gtag('config', 'UA-91100035-7');
</script>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
${script?.call() ?? ''}
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
    ${body()}
  </div>
  </div>
</div>
</body>
  ''';
}

String emailConfirmationPage(Env env, String? token) {
  return pageScaffold(
    env,
    script: () => '''
<script>
function onReturnCallback() {
  document.forms[0].submit();
}
</script>
''',
    body: () => '''
    <form action="?" method="POST">
      <input type="hidden" name="token" value="$token" />
      <h2>Confirm your email address</h2>
      <p>Click the checkbox to confirm your email address.</p>
      <div class="g-recaptcha" data-sitekey="${env.config.secrets.recaptchaSiteKey}" data-callback="onReturnCallback"></div>
    </form>
  ''',
  );
}

String emailConfirmationSuccess(Env env) {
  return pageScaffold(env,
      body: () => ''' 
<p>Successfully confirmed your email address. Please go back to AuthPass app. 
You are now successfully authenticated.</p>
''');
}

String emailConfirmationTokenError(Env env) {
  return pageScaffold(env,
      body: () => '''
<p>
<strong>Invalid email token</strong>: Token was not found, or it was already confirmed.
</p>
<p>
  If the problem persists <a href="https://forum.authpass.app/c/user-help/error-reports/11" target="_blank">please contact support</a>.
</p>
''');
}

const _htmlEscape = HtmlEscape(HtmlEscapeMode.element);

String genericErrorContent(Env env, String message, {String? title}) {
  return pageScaffold(env,
      body: () => '''
          <h2>${title ?? 'Error while processing request'}</h2>
          <p>${_htmlEscape.convert(message)}</p>''');
}
