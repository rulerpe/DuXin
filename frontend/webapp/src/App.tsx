import { BrowserRouter as Router } from 'react-router-dom'
import Header from './layouts/Header'
import Routes from './routes'
import { UserProvider } from './contexts/UserContext'
import './App.css'

const App = () => {
  return (
    <UserProvider>
      <Router>
        <div className="app">
          <Header />
          <main>
            <Routes />
          </main>
        </div>
      </Router>
    </UserProvider>
  )
}

export default App
