export interface User {
  id: number
  email: string
  password_digest: string
  created_at: Date
  updated_at: Date
  username: string
  phone_number: string
  verified: boolean
  failed_attempts: number
  locked_at: string
  user_type: 'USER' | 'TEMP'
  document_count: number
  language: string
}
export interface GetUserResponse {
  message: string
  user: User
}
export interface CreateTempUserResponse extends GetUserResponse {}
