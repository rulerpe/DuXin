import { useTranslation } from 'react-i18next';
import styles from '../styles/LanguageSelector.module.css';
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome';
import { faChevronDown } from '@fortawesome/free-solid-svg-icons';

interface LanguageSelectorProps {
  onLanguageChange?: (language: string) => void;
  isDisabled?: boolean;
}

const LanguageSelector = ({
  onLanguageChange,
  isDisabled,
}: LanguageSelectorProps) => {
  const { i18n } = useTranslation();

  const changeLanguage = (language: string) => {
    i18n.changeLanguage(language);
    if (onLanguageChange) {
      onLanguageChange(language);
    }
  };

  return (
    <div className={styles.dropdownContainer}>
      <select
        className={styles.dropdown}
        name="languageSelector"
        id="languageSelector"
        onChange={(e) => changeLanguage(e.target.value)}
        value={i18n.language}
        disabled={isDisabled}
      >
        <option value="zh">中文</option>
        <option value="en">English</option>
      </select>

      <FontAwesomeIcon icon={faChevronDown} className={styles.dropdownArrow} />
    </div>
  );
};

export default LanguageSelector;
