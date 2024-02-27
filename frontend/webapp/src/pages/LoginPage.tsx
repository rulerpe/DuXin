import React, { useState } from 'react'

const LoginPage = () => {
  const [phoneNumber, setPhoneNumber] = useState('')
  const [otp, setOtp] = useState('')
  const [otpSent, setOtpSent] = useState(false)

  const API_URL = 'https://localhost:3001'

  const handlePhoneNumberSubmit = async (
    e: React.FormEvent<HTMLFormElement>,
  ) => {
    e.preventDefault()

    const usersUrl = `${API_URL}/users`
    const response = await fetch(usersUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        user: {
          phone_number: phoneNumber,
        },
      }),
      credentials: 'include',
    })
    if (!response.ok) {
      throw new Error('Network response was not ok')
    }
    const responseJson = await response.json()
    console.log(responseJson)
    setOtpSent(true)
  }

  const handleOtpSubmit = async (e: React.FormEvent<HTMLFormElement>) => {
    e.preventDefault()

    const verifyUrl = `${API_URL}/otp/verify`
    const response = await fetch(verifyUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({
        phone_number: phoneNumber,
        otp_code: otp,
      }),
      credentials: 'include',
    })
    if (!response.ok) {
      throw new Error('Network response was not ok')
    }
    const responseJson = await response.json()
    console.log(responseJson)
  }
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
  )
}

export default LoginPage
