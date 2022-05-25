import React from "react";
import ReactDOM from "react-dom";
import UploadAndDisplayImage from "UploadAndDisplayImage";

document.addEventListener("turbolinks:load", () => {
  const element = document.getElementById("image-upload");
  if (!element) return;
  ReactDOM.render(<UploadAndDisplayImage />, element);
});
