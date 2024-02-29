import { useEffect } from 'react';
import { useNavigate, Link } from 'react-router-dom';
import { isAxiosError } from 'axios';
import { apiService } from '../services/apiService';
import { useUser } from '../contexts/UserContext';
import { useTranslation } from 'react-i18next';
import styles from '../styles/Header.module.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faChevronLeft, faUser } from '@fortawesome/free-solid-svg-icons';

const Header = () => {
  const navigate = useNavigate();
  const { setUser } = useUser();
  const { t, i18n } = useTranslation();
  useEffect(() => {
    const getUser = async () => {
      try {
        const getUserResponse = await apiService.getUser();
        console.log('getUserResponse.user', getUserResponse.user);
        setUser(getUserResponse.user);
        i18n.changeLanguage(getUserResponse.user.language);
      } catch (error) {
        // if no authuraized user if found, create a temp user account
        if (isAxiosError(error) && error.response?.status === 401) {
          try {
            const tempUserResponse = await apiService.createTempUser(
              i18n.language,
            );
            setUser(tempUserResponse.user);
          } catch (error) {
            console.error('Failed to create temp user', error);
          }
        } else {
          console.error('Failed to fetch user', error);
        }
      }
    };
    getUser();
  }, []);
  const onBack = () => {
    if (window.history.length > 1) {
      navigate(-1);
    } else {
      navigate('/');
    }
  };
  return (
    <header className={styles.header}>
      <button onClick={onBack} className={styles.iconButton}>
        <FontAwesomeIcon icon={faChevronLeft} />
      </button>
      <Link to="/">
        <h1 className={styles.title}>{t('appName')}</h1>
      </Link>

      <Link to="/login">
        <button className={styles.iconButton}>
          <FontAwesomeIcon icon={faUser} />
        </button>
      </Link>
    </header>
  );
};

export default Header;
