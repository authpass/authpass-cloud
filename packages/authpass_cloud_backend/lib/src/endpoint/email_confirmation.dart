String emailConfirmationPage() {
  // language=html
  return '''<!DOCTYPE html>
<head>
<meta charset="utf-8">
<title>AuthPass: Confirm email address</title>
<script src="https://www.google.com/recaptcha/api.js" async defer></script>
</head>
<body>
    <form action="?" method="POST">
      <div class="g-recaptcha" data-sitekey="your_site_key"></div>
      <br/>
      <input type="submit" value="Submit">
    </form>
</body>
  ''';
}
