/* Inspired by https://github.com/spring-io/antora-ui-spring/ */

;(function () {
  'use strict'

  activateSwitch(document.getElementById('theme-switcher-checkbox'))

  function activateSwitch (control) {
    if (!control) return
    control.checked = document.documentElement.classList.contains('theme-dark')
    control.addEventListener('change', onThemeChange.bind(control))
  }

  function onThemeChange () {
    document.documentElement.classList.toggle('theme-dark', this.checked)
    document.documentElement.setAttribute('data-theme', this.checked ? 'dark' : 'light')
    saveTheme(this.checked ? 'dark' : 'light')
  }

  function saveTheme (theme) {
    window.localStorage && window.localStorage.setItem('theme', theme)
  }
})()
