import React, { useState, useEffect } from "react";

const UploadAndDisplayImage = () => {
  const [file, setFile] = useState(null);
  const [fileDataURL, setFileDataURL] = useState(null);

  const resetHandler = () => {
  }
  const changeHandler = (e) => {
    const file = e.target.files[0];
    setFile(file);
    console.log(file);
  }
  useEffect(() => {
    let fileReader, isCancel = false;
    if (file) {
      fileReader = new FileReader();
      fileReader.onload = (e) => {
        const { result } = e.target;
        if (result && !isCancel) {
          setFileDataURL(result);
        }
      }
      fileReader.readAsDataURL(file);
    }
    return () => {
      isCancel = true;
      if (fileReader && fileReader.readyState === 1) {
        fileReader.abort();
      }
    }
  }, [file])


  return (
    <>
      <form>
        <p>
          <label htmlFor="image"></label>
          <input
            type="file"
            id="image"
            accept=".png, .jpg, .jpeg"
            size="5"
            onChange={changeHandler}
          />
        </p>
      </form>
      { fileDataURL ?
        <p className="image-upload-wrap">
          {
            <img className="preview-image" src={fileDataURL} alt="preview" />
          }         
          <button className="remove-image" onClick={resetHandler}>Reset</button>
        </p> :
      null }
    </>
  );
};

export default UploadAndDisplayImage;
