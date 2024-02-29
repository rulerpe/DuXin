import React, { useState, useEffect, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useUser } from '../contexts/UserContext';
import { apiService } from '../services/apiService';
import Button from '../components/Button';
import styles from '../styles/LoginPage.module.css';

type SetStateAction = React.Dispatch<React.SetStateAction<string>>;

const LoginPage = () => {
  const [phoneNumber, setPhoneNumber] = useState<string>('');
  const [otp, setOtp] = useState<string>('');
  const [otpSent, setOtpSent] = useState<boolean>(false);
  const [error, setError] = useState<string>('');
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const { user, setUser } = useUser();
  const { t, i18n } = useTranslation();
  const navigate = useNavigate();
  const otpInputRef = useRef<HTMLInputElement>(null);

  // Validation functions
  const validatePhoneNumber = (number: string): boolean =>
    number.startsWith('+1') && number.length === 12;
  const validateOtp = (otp: string): boolean => otp.length === 6;

  const handleInputChange =
    (setter: SetStateAction) => (e: React.ChangeEvent<HTMLInputElement>) => {
      setter(e.target.value);
      setError('');
    };

  // Create new user, and trigger OTP verfication
  const handlePhoneNumberSubmit = async () => {
    let formattedPhoneNumber = phoneNumber.trim();
    if (!formattedPhoneNumber.startsWith('+1')) {
      formattedPhoneNumber = `+1${formattedPhoneNumber}`;
    }
    if (!validatePhoneNumber(formattedPhoneNumber)) {
      setError(t('invalidPhoneNumber'));
      return;
    }
    setPhoneNumber(formattedPhoneNumber);

    try {
      setIsLoading(true);
      await apiService.createUser(formattedPhoneNumber, i18n.language);
      setOtpSent(true);
    } catch (error) {
      setError(t('submitPhoneNumberFailed'));
    } finally {
      setIsLoading(false);
    }
  };

  // verify otp for new user account, if temp user was previously used
  // send the temp user id alone, to transfer history to new user account.
  const handleOtpSubmit = async () => {
    if (!validateOtp(otp)) {
      setError(t('invalidOTP'));
      return;
    }
    try {
      setIsLoading(true);
      const otpVerifyResponse = await apiService.OtpVerify(
        phoneNumber,
        otp,
        user,
      );
      setUser(otpVerifyResponse.user);
      navigate('/');
    } catch (error) {
      setError(t('submitOTPFailed'));
    } finally {
      setIsLoading(false);
    }
  };

  // Handle Enter key press
  const handleKeyDown = (
    e: React.KeyboardEvent<HTMLInputElement>,
    action: () => void,
  ) => {
    if (e.key === 'Enter') {
      action();
    }
  };
  useEffect(() => {
    if (otpSent && otpInputRef.current) {
      otpInputRef.current.focus();
    }
  }, [otpSent]);

  return (
    <>
      {!otpSent ? (
        <>
          <h2>{t('signinPhoneNumber')}</h2>
          <input
            id="sendPhoneNumber"
            placeholder="(702)123-4567"
            className={`${styles.inputField} ${error ? styles.inputError : ''}`}
            type="number"
            value={phoneNumber}
            onChange={handleInputChange(setPhoneNumber)}
            onKeyDown={(e) => handleKeyDown(e, handlePhoneNumberSubmit)}
            autoFocus
          />
          <p className={styles.errorMessage}>{error}</p>
          <Button
            label={t('submitPhoneNumber')}
            onClick={handlePhoneNumberSubmit}
            isLoading={isLoading}
          />
        </>
      ) : (
        <>
          <h2>{t('signinOTP')}</h2>
          <input
            id="sendOtp"
            placeholder="123456"
            className={`${styles.inputField} ${error ? styles.inputError : ''}`}
            type="number"
            value={otp}
            onChange={handleInputChange(setOtp)}
            onKeyDown={(e) => handleKeyDown(e, handleOtpSubmit)}
            autoFocus
          />
          <p className={styles.errorMessage}>{error}</p>
          <Button
            label={t('submitOTP')}
            onClick={handleOtpSubmit}
            isLoading={isLoading}
          />
        </>
      )}
    </>
  );
};

export default LoginPage;
