import { useTranslation } from 'react-i18next';
import { useNavigate } from 'react-router-dom';
import { STAGES } from '../types';
import useActionCable from '../hooks/useActionCable';
import ProgressBar from '../components/ProgressBar';
import Button from '../components/Button';

const SummaryPage = () => {
  const navigate = useNavigate();
  const { currentStage, translatedSummary } = useActionCable(
    'SummaryTranslationChannel',
  );

  const { t } = useTranslation();

  const handleButtonClick = () => {
    navigate('/camera');
  };

  return (
    <>
      {currentStage === 'summary_translation_completed' && translatedSummary ? (
        <>
          <h2>{t('summaryTitle')}</h2>
          <p>{translatedSummary.title}</p>
          <h2>{t('summaryBody')}</h2>
          <p>{translatedSummary.body}</p>
          <h2>{t('summaryAction')}</h2>
          <p>{translatedSummary.action}</p>
          <br />
          <Button label={t('navigateToCamera')} onClick={handleButtonClick} />
        </>
      ) : (
        <>
          <ProgressBar
            stages={Object.keys(STAGES)}
            currentStage={STAGES[currentStage]}
          />
          <br />
          <p>{t(`${currentStage}`)}</p>
        </>
      )}
    </>
  );
};

export default SummaryPage;
