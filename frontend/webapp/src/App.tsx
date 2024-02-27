import { BrowserRouter as Router } from 'react-router-dom'
import Header from './layouts/Header'
import Routes from './routes'
import './App.css'

const App = () => {
  return (
    <Router>
      <div className="app">
        <Header />
        <main>
          <Routes />
        </main>
      </div>
    </Router>
  )
}

export default App
