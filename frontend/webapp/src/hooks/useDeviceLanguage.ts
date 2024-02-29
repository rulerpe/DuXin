import { useState, useEffect } from 'react';
///////delete
const useDeviceLanguage = (): string => {
  const [language, setLanguage] = useState('');

  useEffect(() => {
    const deviceLanguage =
      navigator.language || (navigator.languages && navigator.languages[0]);
    setLanguage(deviceLanguage);
  }, []);
  return language;
};

export default useDeviceLanguage;
