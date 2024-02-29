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
      extracting_text: 'Extracting text',
      summarizing_text: 'Summarizing text',
      translating_text: 'Translating text',
      summary_translation_completed: 'Summary translation completed',
      summaryTitle: 'Title',
      summaryBody: 'Summary',
      summaryAction: 'Suggested action',
      signinPhoneNumber:
        'Enter phone number to sign in, a one time pass code will send to the phone',
      submitPhoneNumber: 'Submit',
      invalidPhoneNumber: 'Invalid phone number',
      submitPhoneNumberFailed: 'Phone number submit failed',
      signinOTP: 'Enter pass code',
      submitOTP: 'Verify',
      invalidOTP: 'Invalid pass code',
      submitOTPFailed: 'Pass code submit failed',
    },
  },
  zh: {
    translation: {
      appName: '读信',
      welcomText: '总结并翻译拍摄的信件',
      navigateToCamera: '拍照',
      capturePhoto: '拍照',
      selectPhoto: '文件',
      extracting_text: '正在读取信件',
      summarizing_text: '正在总结信件',
      translating_text: '正在翻译信件',
      summary_translation_completed: '完成',
      summaryTitle: '标题',
      summaryBody: '概要',
      summaryAction: '建议行动',
      signinPhoneNumber: '请输入手机号码登陆，验证码会用短信发送至你的手机号码',
      submitPhoneNumber: '发送',
      invalidPhoneNumber: '手机号码无效，请重新输入',
      submitPhoneNumberFailed: '发送失败',
      signinOTP: '请输入验证码',
      submitOTP: '验证',
      invalidOTP: '验证码无效，请重新输入',
      submitOTPFailed: '发送失败',
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
