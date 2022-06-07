// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

import Uppy from "@uppy/core";
import XHRUpload from "@uppy/xhr-upload";
import Dashboard from "@uppy/dashboard";
import DragDrop from "@uppy/drag-drop";
import AwsS3 from "@uppy/aws-s3";
import "@uppy/core/dist/style.css";
import "@uppy/dashboard/dist/style.css";

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
const images = require.context("../images", true);
// const imagePath = (name) => images(name, true)

const notice = document.getElementById("notice");
if (notice) {
  setTimeout((notice.style.display = "none"), 5000);
}

function initUppy(uppy_node) {
  var uppy = new Uppy({
    id: uppy_node.dataset["uppyInstance"],
    autoProceed: true,
    allowMultipleUploadBatches: true,
    locale: French,
    restrictions: {
      maxFileSize: uppy_node.dataset["maxFileSize"] * 1024 * 1024,
      maxNumberOfFiles: null,
      minNumberOfFiles: null,
      allowedFileTypes: uppy_node.dataset["allowedFiles"].split(","),
    },
  });

  if (uppy_node.dataset["uppyGui"] == "dash") {
    uppy.use(Dashboard, {
      target: uppy_node,
      inline: true,
      replaceTargetContent: true,
      showProgressDetails: true,
      width: 1200,
      height: 400,
    });
  } else {
    uppy.use(DragDrop, {
      target: uppy_node,
      width: "100%",
      height: "100%",
      note: null,
    });
  }
  uppy.use(AwsS3, {
    companionUrl: uppy_node.dataset["presignUrl"],
  });
  uppy.on("upload-success", function (file, data) {
    // construct uploaded file data in the format that Shrine expects
    var uploadedFileData = JSON.stringify({
      id: file.meta["key"].match(/^cache\/(.+)/)[1], // object key without prefix
      storage: "cache",
      metadata: {
        size: file.size,
        filename: file.name,
        mime_type: file.type,
      },
    });
    fetch(uppy_node.dataset["postUrl"], {
      method: "POST",
      credentials: "same-origin",
      body: JSON.stringify({
        // square brackets are used to make the value of data attribute as JSON attribute
        [uppy_node.dataset["railsModel"]]: {
          [uppy_node.dataset["imageAttribute"]]: uploadedFileData,
        },
      }),
      headers: {
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')
          .content,
        "Content-Type": "application/json",
      },
    })
      .then((response) => response.json())
      .then((data) => {});
  });
}
function initAllUppies() {
  const allUppies = document.querySelectorAll("[data-form-type='uppy']");
  allUppies.forEach(function (one_uppy) {
    initUppy(one_uppy);
  });
}
if (document.body.contains(document.querySelector("[data-form-type='uppy']"))) {
  initAllUppies();
}
