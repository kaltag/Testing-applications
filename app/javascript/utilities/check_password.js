document.addEventListener('turbolinks:load', function () {
  const password = document.getElementById('user_password')
  const passwordConfirmation = document.getElementById('user_password_confirmation')

  const passwordCheck = () => {
    if (passwordConfirmation.value === '') {
      passwordConfirmation.style.backgroundColor = "white";
    } else if (passwordConfirmation.value === password.value) {
      passwordConfirmation.style.backgroundColor = "green";
    } else {
      passwordConfirmation.style.backgroundColor = "red";
    }
  }
  passwordConfirmation.addEventListener('input', () => passwordCheck())
})
