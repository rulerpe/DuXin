import React, { useState } from 'react';
import { useUser } from '../contexts/UserContext';
import { apiService } from '../services/apiService';
import { useTranslation } from 'react-i18next';

const LoginPage = () => {
  const [phoneNumber, setPhoneNumber] = useState('');
  const [otp, setOtp] = useState('');
  const [otpSent, setOtpSent] = useState(false);
  const { user, setUser } = useUser();
  const { i18n } = useTranslation();

  // Create new user, and trigger OTP verfication
  const handlePhoneNumberSubmit = async (
    e: React.FormEvent<HTMLFormElement>,
  ) => {
    e.preventDefault();
    const response = await apiService.createUser(phoneNumber, i18n.language);
    console.log(response);
    setOtpSent(true);
  };

  // verify otp for new user account, if temp user was previously used
  // send the temp user id alone, to transfer history to new user account.
  const handleOtpSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    console.log('user', user);
    const otpVerifyResponse = await apiService.OtpVerify(
      phoneNumber,
      otp,
      user,
    );
    console.log(otpVerifyResponse);
    setUser(otpVerifyResponse.user);
  };

  return (
    <div>
      <h2>Login page</h2>
      {!otpSent ? (
        <form onSubmit={handlePhoneNumberSubmit}>
          <label>
            Phone Number:
            <input
              type="text"
              value={phoneNumber}
              onChange={(e) => setPhoneNumber(e.target.value)}
              required
            />
          </label>
          <button type="submit">Send OTP</button>
        </form>
      ) : (
        <form onSubmit={handleOtpSubmit}>
          <label>
            OTP:
            <input
              type="text"
              value={otp}
              onChange={(e) => setOtp(e.target.value)}
              required
            />
          </label>
          <button type="submit">Verify OTP</button>
        </form>
      )}
    </div>
  );
};

export default LoginPage;
