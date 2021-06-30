// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//

import '@uppy/core/dist/style.css'
import '@uppy/dashboard/dist/style.css'

require("@rails/ujs").start()
require("turbolinks").start()
require("@rails/activestorage").start()
require("@uppy/core")

const AwsS3Multipart = require('@uppy/aws-s3-multipart')
const Uppy = require('@uppy/core')
const Dashboard = require('@uppy/dashboard')
const Spanish = require('@uppy/locales/lib/es_ES')

const fillForm = (result) => {
  console.log(result)
  // do something
}

const setupUppy = (element) => {
  let trigger = element.querySelector('[data-behavior="uppy-trigger"]')
  trigger.addEventListener("click", (event) => event.preventDefault())

  let uppy = Uppy({
    debug: true,
    autoProceed: true,
    allowMultipleUploads: false,
    restrictions: {
      allowedFileTypes: ['.xlsx']
    }
  })

  uppy.use(Dashboard, {
    trigger: trigger,
    locale: Spanish
  })

  uppy.use(AwsS3Multipart, {
    companionUrl: '/',
  })

  uppy.on('complete', (result) => {
    if (!result.successful.length > 0) {
      return
    }

    let token = document.head.querySelector('meta[name="csrf-token"]').content;
    let file = result.successful[0];
    let url = file.uploadURL;

    fetch('/upload/participants', { method: 'post',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ authenticity_token: token, url: url })
    }).then(res => res.json())
      .then(res => {
        fillForm(res)
        uppy.close();
      })
  })
}

document.addEventListener('turbolinks:load', () => {
  document.querySelectorAll('[data-uppy]').forEach(element => setupUppy(element))
})

