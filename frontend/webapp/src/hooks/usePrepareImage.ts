import { useEffect, useState } from 'react';
import imageCompression from 'browser-image-compression';

const usePrepareImage = (imageSrc: string | File) => {
  const compressOptions = {
    maxSizeMB: 1,
    maxWidthOrHeight: 1000,
    useWebWorker: true,
  };
  const [preparedImage, setPreparedImage] = useState<FormData>();
  useEffect(() => {
    const compressImage = async () => {
      let imageFile: File;
      if (typeof imageSrc === 'string') {
        const response = await fetch(imageSrc);
        const blob = await response.blob();
        imageFile = new File([blob], 'upload.jpg', {
          type: blob.type,
          lastModified: Date.now(),
        });
      } else {
        imageFile = imageSrc;
      }
      const compressedFile = await imageCompression(imageFile, compressOptions);
      const formData = new FormData();
      formData.append('image', compressedFile);
      setPreparedImage(formData);
    };
    if (imageSrc) {
      compressImage();
    }
  }, [imageSrc]);
  return { preparedImage };
};
export default usePrepareImage;
