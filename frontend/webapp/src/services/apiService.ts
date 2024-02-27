import * as http from '../utils/https'
import { v4 as uuidv4 } from 'uuid'
import { GetUserResponse, CreateTempUserResponse } from '../types'

const BASE_URL = 'https://localhost:3001'

export const apiService = {
  async getUser(): Promise<GetUserResponse> {
    const userDataUrl = `${BASE_URL}/user_data`
    return http.get<GetUserResponse>(userDataUrl)
  },

  async createTempUser(): Promise<CreateTempUserResponse> {
    const tempUserUrl = `${BASE_URL}/temp_user`
    const tempUserId = uuidv4()
    const payload = {
      phone_number: tempUserId,
    }
    return http.post<CreateTempUserResponse, { phone_number: string }>(
      tempUserUrl,
      payload,
    )
  },

  async getSummary(): Promise<any> {
    const summaryUrl = `${BASE_URL}/summary_translations`
    return http.get<any>(summaryUrl)
  },

  async uploadImage(payload: FormData): Promise<any> {
    const uploadImageUrl = `${BASE_URL}/upload_image`
    return http.post<any, FormData>(uploadImageUrl, payload, true)
  },
}
