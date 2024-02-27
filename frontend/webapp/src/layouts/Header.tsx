import React, { useEffect, useState } from 'react'
import { Link } from 'react-router-dom'
import { User, GetUserResponse, CreateTempUserResponse } from '../types'
import { apiService } from '../services/apiService'

const Header = () => {
  const [user, setUser] = useState<User>()
  useEffect(() => {
    const getUser = async () => {
      try {
        const user = await apiService.getUser()
        setUser(user.user)
      } catch (error) {
        const e = error as Error
        console.log(`failed getuser ${e.message}`)
        if (e.message.includes('Unauthorized')) {
          try {
            const tempUser = await apiService.createTempUser()
            setUser(tempUser.user)
          } catch (error) {
            console.log('create temp user failed', error)
          }
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
