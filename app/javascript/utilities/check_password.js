document.addEventListener('turbolinks:load', function () {
  const password = document.getElementById('user_password')
  const passwordConfirmation = document.getElementById('user_password_confirmation')

  const passwordCheck = () => {
    if (passwordConfirmation.value === '') {
      return passwordConfirmation.style.backgroundColor = "white"
    }
    if (passwordConfirmation.value === password.value) {
      passwordConfirmation.style.backgroundColor = "green"
    } else {
      passwordConfirmation.style.backgroundColor = "red"
    }
  }
  if (passwordConfirmation) {
    passwordConfirmation.addEventListener('input', () => passwordCheck())
  }
})
