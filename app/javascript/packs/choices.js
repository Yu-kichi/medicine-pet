import * as Choices from 'choices.js'
document.addEventListener('turbolinks:load', function () {
  new Choices('.choices-remove-button', {
    removeItemButton: true,
    itemSelectText: '選択してください',
    searchResultLimit: 6,
    noResultsText: "見つかりません",
  });
});