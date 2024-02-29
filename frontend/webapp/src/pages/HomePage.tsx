import { useState } from 'react';
import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import LanguageSelector from '../components/LanguageSelector';
import Button from '../components/Button';
import { apiService } from '../services/apiService';
import { useUser } from '../contexts/UserContext';

const HomePage = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
  const [isLoading, setIsLoading] = useState<boolean>(false);
  const { setUser } = useUser();

  const handleButtonClick = () => {
    navigate('/camera');
  };
  const handleLanguageChange = async (language: string) => {
    console.log('language change', language);
    try {
      setIsLoading(true);
      const response = await apiService.updateUserLanguage(language);
      setUser(response.user);
      console.log('Update language success');
    } catch (error) {
      console.error('Change language failed');
    } finally {
      setIsLoading(false);
    }
  };
  return (
    <>
      <h2>{t('welcomText')}</h2>
      <Button
        label={t('navigateToCamera')}
        onClick={handleButtonClick}
        isLoading={isLoading}
      />
      <LanguageSelector
        onLanguageChange={handleLanguageChange}
        isDisabled={isLoading}
      />
    </>
  );
};

export default HomePage;
