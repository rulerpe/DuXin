export async function get<T>(url: string, options?: RequestInit): Promise<T> {
  const response = await fetch(url, {
    ...options,
    method: 'GET',
    credentials: 'include',
  })
  if (!response.ok) {
    throw new Error(response.statusText)
  }
  return response.json() as Promise<T>
}

export async function post<T, U>(
  url: string,
  body: U,
  isFile: boolean = false,
  options?: RequestInit,
): Promise<T> {
  const response = await fetch(url, {
    method: 'POST',
    headers: {
      //   'Content-Type': isFile ? 'multipart/form-data' : 'application/json',
      ...options?.headers,
    },
    body: isFile ? (body as FormData) : JSON.stringify(body),
    credentials: 'include',
  })
  if (!response.ok) {
    throw new Error(response.statusText)
  }
  return response.json() as Promise<T>
}
