import React, { useState, useRef } from 'react'
import Webcam from 'react-webcam'
import imageCompression from 'browser-image-compression'
import { apiService } from '../services/apiService'

const CameraPage = () => {
  const webcamRef = useRef<Webcam>(null)
  const [image, setImage] = useState('')
  const [uploading, setUploading] = useState(false)

  const capture = async (): Promise<void> => {
    const imageSrc = webcamRef.current?.getScreenshot()
    if (imageSrc) {
      await handleImageUpload(imageSrc)
    }
  }

  const handleImageChange = async (
    event: React.ChangeEvent<HTMLInputElement>,
  ): Promise<void> => {
    if (event.target.files && event.target.files[0]) {
      const file = event.target.files[0]
      await handleImageUpload(file)
    }
  }

  const handleImageUpload = async (imageSrc: string | File): Promise<void> => {
    try {
      console.log('Imagesrc: ', typeof imageSrc)
      setUploading(true)
      const options = {
        maxSizeMB: 1,
        maxWidthOrHeight: 1000,
        useWebWorker: true,
      }

      // Prepare the file to be uploaded
      let imageFile: File
      if (typeof imageSrc === 'string') {
        const response = await fetch(imageSrc)
        const blob = await response.blob()
        imageFile = new File([blob], 'upload.jpg', {
          type: blob.type,
          lastModified: Date.now(),
        })
      } else {
        imageFile = imageSrc
      }
      const compressedFile = await imageCompression(imageFile, options)

      const formData = new FormData()
      formData.append('image', compressedFile)

      const uploadImageResponse = await apiService.uploadImage(formData)
      console.log('upload image success', uploadImageResponse)
    } catch (error) {
      console.log(error)
    } finally {
      setUploading(false)
    }
  }

  return (
    <div>
      <Webcam audio={false} ref={webcamRef} screenshotFormat="image/jpeg" />
      <button onClick={capture}>Capture Photo</button>
      <input type="file" accept="image/*" onChange={handleImageChange} />
      {uploading && <p>Uploading...</p>}
      {/* {image && <img src={image} alt="Selected or Captured" />} */}
    </div>
  )
}

export default CameraPage
