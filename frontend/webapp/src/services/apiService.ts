import * as http from '../utils/https';
import axios, { AxiosError } from 'axios';
import { v4 as uuidv4 } from 'uuid';
import {
  User,
  GetUserResponse,
  CreateTempUserResponse,
  OtpVerifPayload,
  OtpVerifyResponse,
  CreateUserResponse,
} from '../types';

const BASE_URL = 'https://localhost:3001';

axios.defaults.baseURL = BASE_URL;
axios.defaults.withCredentials = true;

export const apiService = {
  // get current user based on token in httponly cookie
  async getUser(): Promise<GetUserResponse> {
    const response = await axios.get<GetUserResponse>(`/user_data`);
    return response.data;
  },

  // Start creating new user with phone number,
  // trigger back send OTP code to phone number.
  async createUser(phoneNumber: string): Promise<CreateUserResponse> {
    const createUserUrl = `/users`;
    const payload = {
      user: { phone_number: phoneNumber },
    };
    const response = await axios.post<CreateUserResponse>(
      createUserUrl,
      payload,
    );
    return response.data;
  },

  // Verify OTP code to finish creating user
  async OtpVerify(
    phoneNumber: string,
    otpCode: string,
    tempUser: User | null,
  ): Promise<OtpVerifyResponse> {
    const otpVerifyUrl = `/otp/verify`;
    const payload: OtpVerifPayload = {
      phone_number: phoneNumber,
      otp_code: otpCode,
      temp_uuid: tempUser?.user_type === 'TEMP' ? tempUser.phone_number : '',
    };
    const response = await axios.post<OtpVerifyResponse>(otpVerifyUrl, payload);

    return response.data;
  },

  async createTempUser(): Promise<CreateTempUserResponse> {
    const tempUserUrl = `/temp_user`;
    const tempUserId = uuidv4();
    const payload = {
      user: { phone_number: tempUserId },
    };
    const response = await axios.post<CreateTempUserResponse>(
      tempUserUrl,
      payload,
    );
    return response.data;
  },

  async getSummary(): Promise<any> {
    const summaryUrl = `${BASE_URL}/summary_translations`;
    const response = await axios.get<any>(summaryUrl);
    return response.data;
  },

  async uploadImage(payload: FormData): Promise<any> {
    const uploadImageUrl = `${BASE_URL}/upload_image`;
    const config = {
      headers: {
        'Content-Type': 'multipart/form-data',
      },
    };
    const response = await axios.post<any>(uploadImageUrl, payload, config);
    return response.data;
  },
};
