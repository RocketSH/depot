import React, { useState, useEffect } from "react";

const UploadAndDisplayImage = () => {
  const [image, setImage] = useState(null);
  const [imgDataURL, setImgDataURL] = useState(null);

  const resetHandler = (e) => {
    e.target = null;
    setImgDataURL(null);
  }
  const changeHandler = (e) => {
    const image = e.target.files[0];
    if (image) {
      setImage(image);
    } else
    return;
  }
  useEffect(() => {
    let reader, isCancel = false;
    if (image) {
      reader = new FileReader();
      reader.onload = (e) => {
        const { result } = e.target;
        if (result && !isCancel) {
          setImgDataURL(result);
        }
      }
      reader.readAsDataURL(image);
    }
    return () => {
      isCancel = true;
      if (reader && reader.readyState === 1) {
        reader.abort();
      }
    }
  }, [image])


  return (
    <>
      <p>
        <label htmlFor="product_image" className="image-upload-btn">
          <input
          type="file"
          id="product_image"
          name="product[image]"
          accept=".png, .jpg, .jpeg"
          size="5"
          multiple={false}
          onChange={changeHandler}
        />
          Select your image
        </label>
      </p>
      { imgDataURL ?
        <p className="image-upload-wrap">
          {
            <img className="preview-image" src={imgDataURL} alt="preview" />
          }         
          <button className="remove-image" onClick={resetHandler}>X</button>
        </p> :
      null }
    </>
  );
};

export default UploadAndDisplayImage;
