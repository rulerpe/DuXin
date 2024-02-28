import { apiService } from '../services/apiService';
import { STAGES } from '../types';
import useActionCable from '../hooks/useActionCable';

const SummaryPage = () => {
  const { currentStage, translatedSummary } = useActionCable(
    'SummaryTranslationChannel',
  );

  const getSummary = async () => {
    const summaryResponse = await apiService.getSummary();
    console.log(summaryResponse);
  };

  return (
    <div>
      <h2>Summary page</h2>
      <h2>Process Status</h2>
      <p>{STAGES[currentStage]}</p>
      {currentStage === 'summary_translation_success' && translatedSummary && (
        <>
          <h3>Translated Summary</h3>
          <ul>
            <li>{translatedSummary?.title}</li>
            <li>{translatedSummary?.body}</li>
            <li>{translatedSummary?.action}</li>
          </ul>
        </>
      )}
      <button onClick={getSummary}>Get Summary</button>
    </div>
  );
};

export default SummaryPage;
