import React, { useState, useRef, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import Webcam from 'react-webcam';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import {
  faCamera,
  faImages,
  faSpinner,
} from '@fortawesome/free-solid-svg-icons';
import styles from '../styles/CameraPage.module.css';
import { apiService } from '../services/apiService';
import usePrepareImage from '../hooks/usePrepareImage';

const CameraPage = () => {
  const webcamRef = useRef<Webcam>(null);
  const navigate = useNavigate();
  const [isWebcamInitializing, setIsWebcamInitializing] =
    useState<boolean>(true);
  const [uploading, setUploading] = useState(false);
  const [unpreparedImage, setUnpreparedImage] = useState<string | File>('');

  const { preparedImage } = usePrepareImage(unpreparedImage);

  useEffect(() => {
    const uploadImage = async () => {
      if (preparedImage) {
        try {
          setUploading(true);
          const uploadImageResponse =
            await apiService.uploadImage(preparedImage);
          console.log('upload image success', uploadImageResponse);
          navigate('/summary');
        } catch (error) {
          console.log(error);
        } finally {
          setUploading(false);
        }
      }
    };
    uploadImage();
  }, [preparedImage]);

  const capture = async (): Promise<void> => {
    const imageSrc = webcamRef.current?.getScreenshot();
    if (imageSrc) {
      await handleImageUpload(imageSrc);
    }
  };

  const handleImageChange = async (
    event: React.ChangeEvent<HTMLInputElement>,
  ): Promise<void> => {
    if (event.target.files && event.target.files[0]) {
      const file = event.target.files[0];
      await handleImageUpload(file);
    }
  };

  const handleImageUpload = (imageSrc: string | File) => {
    setUnpreparedImage(imageSrc);
  };

  const handleUserMedia = () => {
    console.log('handleUserMedia');
    setIsWebcamInitializing(false);
  };

  return (
    <>
      {isWebcamInitializing && (
        <FontAwesomeIcon icon={faSpinner} spin={true} size="3x" />
      )}
      <Webcam
        audio={false}
        ref={webcamRef}
        screenshotFormat="image/jpeg"
        onUserMedia={handleUserMedia}
        className={styles.webcam}
      />
      <div className={styles.buttonContainer}>
        {uploading ? (
          <div className={styles.spinnerContainer}>
            <FontAwesomeIcon icon={faSpinner} spin={true} size="3x" />
          </div>
        ) : (
          <>
            <div className={styles.fillerButton}></div>
            <button onClick={capture} className={styles.captureButton}>
              <FontAwesomeIcon icon={faCamera} size="3x" />
            </button>

            <label className={styles.fileUploadButton}>
              <FontAwesomeIcon icon={faImages} size="2x" />
              <input
                type="file"
                accept="image/*"
                onChange={handleImageChange}
                className={styles.fileInput}
              />
            </label>
          </>
        )}
      </div>
    </>
  );
};

export default CameraPage;
