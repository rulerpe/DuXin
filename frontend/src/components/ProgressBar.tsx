import styles from '../styles/ProgressBar.module.css';

interface ProgressBarProps {
  currentStage: number;
  stages: string[];
}

const ProgressBar = ({ currentStage, stages }: ProgressBarProps) => {
  const stagePercentage = 100 / stages.length;
  const progress = stagePercentage * currentStage;
  const isComplete = progress >= 100;

  const progressBarClasses = `${styles.progressBarFill} ${isComplete ? styles.progressBarComplete : ''}`;

  return (
    <div className={styles.progressBarContainer}>
      <div
        className={progressBarClasses}
        style={{ width: `${progress}%` }}
      ></div>
    </div>
  );
};

export default ProgressBar;
