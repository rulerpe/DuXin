import { Routes, Route } from 'react-router-dom'
import HomePage from './pages/HomePage'
import LoginPage from './pages/LoginPage'
import SummaryPage from './pages/SummaryPage'
import CameraPage from './pages/CameraPage'

const AppRoutes = () => {
  return (
    <Routes>
      <Route path="/" element={<HomePage />}></Route>
      <Route path="/login" element={<LoginPage />}></Route>
      <Route path="/summary" element={<SummaryPage />}></Route>
      <Route path="/camera" element={<CameraPage />}></Route>
    </Routes>
  )
}

export default AppRoutes
