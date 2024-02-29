import { BrowserRouter as Router } from 'react-router-dom';
import Routes from './routes';
import { UserProvider } from './contexts/UserContext';
import Layout from './components/Layout';
import 'normalize.css';
import './utils/i18n';

const App = () => {
  return (
    <UserProvider>
      <Router>
        <Layout>
          <Routes />
        </Layout>
      </Router>
    </UserProvider>
  );
};

export default App;
