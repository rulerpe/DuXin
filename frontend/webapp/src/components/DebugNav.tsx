import { Link } from 'react-router-dom';

const DebugNav = () => {
  return (
    <div
      style={{
        position: 'fixed',
        bottom: '0',
        left: 0,
        width: '100%',
        backgroundColor: 'gray',
      }}
    >
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
    </div>
  );
};

export default DebugNav;
