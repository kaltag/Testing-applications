document.addEventListener('turbolinks:load', function () {
  $('.form-inline-link').on('click', formInlineLinkHandler)

  const errors = document.querySelector('.resource-errors')

  if (errors) {
      const resourceId = errors.dataset.resourceId
      formInlineHandler(resourceId)
  }
})

function formInlineLinkHandler(event) {
  event.preventDefault()

  const testId = this.dataset.testId
  formInlineHandler(testId)
}

function formInlineHandler(testId) {
  let link = document.querySelector('.form-inline-link[data-test-id="' + testId + '"]')
  let $testTitle = $('.test-title[data-test-id="' + testId + '"]')
  let $formInline = $('.form-inline[data-test-id="' + testId + '"]')

  $formInline.toggle()
  $testTitle.toggle()

  if ($formInline.is(':visible')) {
    if (link) { link.textContent = 'Отмена' }
  } else {
    if (link) { link.textContent = 'Изменить'}
  }
}
