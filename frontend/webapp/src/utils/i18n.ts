import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import LanguageDetector from 'i18next-browser-languagedetector';

const resources = {
  en: {
    translation: {
      appName: 'Duxin',
      welcomText: 'Take a picture of a letter, see summary and translation',
      navigateToCamera: 'Take a picture',
      capturePhoto: 'Capture photo',
      selectPhoto: 'Select photo',
    },
  },
  zh: {
    translation: {
      appName: '读信',
      welcomText: '总结并翻译拍摄的信件',
      navigateToCamera: '拍照',
      capturePhoto: '拍照',
      selectPhoto: '文件',
    },
  },
};

i18n
  .use(LanguageDetector)
  .use(initReactI18next)
  .init({
    resources,
    fallbackLng: 'en',
    interpolation: {
      escapeValue: false,
    },
  });

export default i18n;
