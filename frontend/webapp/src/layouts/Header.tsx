import { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { User } from '../types'
import { apiService } from '../services/apiService'
import { useUser } from '../contexts/UserContext'
import { isAxiosError } from 'axios'

const Header = () => {
  const { user, setUser } = useUser()
  useEffect(() => {
    const getUser = async () => {
      try {
        const getUserResponse = await apiService.getUser()
        console.log('getUserResponse.user', getUserResponse.user)
        setUser(getUserResponse.user)
      } catch (error) {
        // if no authuraized user if found, create a temp user account
        if (isAxiosError(error) && error.response?.status === 401) {
          try {
            const tempUserResponse = await apiService.createTempUser()
            setUser(tempUserResponse.user)
          } catch (error) {
            console.error('Failed to create temp user', error)
          }
        } else {
          console.error('Failed to fetch user', error)
        }
      }
    }
    getUser()
  }, [])
  return (
    <header
      style={{
        backgroundColor: '#f0f0f0',
        padding: '20px',
        textAlign: 'center',
      }}
    >
      <h1>Duxin Application</h1>
      <nav>
        <Link to="/" style={{ margin: '10px' }}>
          Home
        </Link>
        <Link to="/login" style={{ margin: '10px' }}>
          Login
        </Link>
        <Link to="/summary" style={{ margin: '10px' }}>
          Summary
        </Link>
        <Link to="/camera" style={{ margin: '10px' }}>
          Camera
        </Link>
      </nav>
    </header>
  )
}

export default Header
