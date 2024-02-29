import styles from '../styles/Button.module.css';

interface FileInputButtonProps {
  label: string;
  htmlFor: string;
}

const FileInputButton = ({ label, htmlFor }: FileInputButtonProps) => {
  return (
    <label htmlFor={htmlFor} className={styles.button}>
      {label}
    </label>
  );
};

export default FileInputButton;
