defmodule RecaptchaTemplateTest do
  use ExUnit.Case, async: true

  test "supplying options to display/1 renders them in the g-recaptcha div" do
    template_string =
      Recaptcha.Template.display(
        theme: "dark",
        type: "audio",
        tabindex: 1,
        size: "compact",
        callback: "enableBtn",
        badge: "inline"
      )

    assert template_string =~ "data-theme=\"dark\""
    assert template_string =~ "data-type=\"audio\""
    assert template_string =~ "data-tabindex=\"1\""
    assert template_string =~ "data-size=\"compact\""
    assert template_string =~ "data-callback=\"enableBtn\""
    assert template_string =~ "data-badge=\"inline\""
  end

  test "supplying a public key in options to display/1 overrides it in the g-recaptcha-div" do
    template_string = Recaptcha.Template.display(public_key: "override_test_public_key")

    assert template_string =~ "data-sitekey=\"override_test_public_key\""
  end

  test "supplying noscript option displays the noscript fallback" do
    template_string = Recaptcha.Template.display(noscript: true)

    assert template_string =~ "<noscript>"
    assert template_string =~ "https://www.google.com/recaptcha/api/fallback?k=test_public_key"
  end

  test "supplying a hl in options to display/1 overrides it in the script tag" do
    template_string = Recaptcha.Template.display(hl: "en")
    assert template_string =~ "https://www.google.com/recaptcha/api.js?hl=en"
  end

  test "supplying a onload in options to display/1 adds it to the script tag" do
    template_string1 = Recaptcha.Template.display(onload: "onLoad")
    template_string2 = Recaptcha.Template.display(onload: "onLoad", hl: "en")
    assert template_string1 =~ "https://www.google.com/recaptcha/api.js?onload=onLoad&hl"
    assert template_string2 =~ "https://www.google.com/recaptcha/api.js?onload=onLoad&hl=en"
  end

  test "supplying a invisible recaptcha on option size equal invisible" do
    template_string = Recaptcha.Template.display(size: "invisible")
    assert template_string =~ "grecaptcha.execute()"

    template_string = Recaptcha.Template.display(size: "compact")
    refute template_string =~ "grecaptcha.execute()"
  end

  test "supplying an option to change the callback even if you are using invisible recaptcha" do
    template_string = Recaptcha.Template.display()
    assert template_string =~ "data-callback=\"\""

    template_string = Recaptcha.Template.display(size: "invisible")
    assert template_string =~ "data-callback=\"recaptchaCallback\""

    template_string = Recaptcha.Template.display(size: "invisible", callback: "myCallback")
    assert template_string =~ "data-callback=\"myCallback\""
  end
end
