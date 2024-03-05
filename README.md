
<a name="readme-top"></a>

<br />
<div align="center">

<h1 align="center">Duxin (Letter Translator and Summarizer)</h3>

  <p align="center">
    Empowering non English speaker with seamless mail translation and summarization
    <br />
    <a href="https://www.duxinapp.com"><strong>View Demo</strong></a>
  </p>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

This project was inspired by my dad, a senior immigrant who is not tech-savvy and not proficient in English. People like him have a significant need to understand their mail letters. That's why I created Duxin, a letter translator and summarizer. Duxin is an intuitive application designed to help non-tech-savvy seniors and non-English speakers effortlessly understand their mail in their native language.

The app was built with a mobile-first approach, recognizing that it's more convenient to take photos with a phone. However, there is also an option to upload images from local files, ensuring versatility and accessibility for all users.

<p align="right">(<a target="_blank" href="#readme-top">back to top</a>)</p>



### Built With

* [![React][React.js]][React-url]
* [![TypeScript][TypeScript]][TypeScript-url]
* [![Ruby-on-Rails][Ruby-on-Rails]][Ruby-on-Rails-url]

The backend Rails api lives in this repo, [click here to checkout the frontend React repo](https://github.com/rulerpe/DuXin-Frontend)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- **Instant Mail Scanning:** Utilize your device's camera to capture a picture of the mail letter you wish to understand. This feature leverages [AWS Textract](https://aws.amazon.com/textract/) for OCR technology, extracting text directly from the image for processing.

- **Automated Summary:** Provide a concise summary of the letter's contents, highlighting essential information at a glance. This is achieved by using [LangChain](https://github.com/andreibondarev/langchainrb) to construct prompts that are then processed by the [OpenAI API](https://openai.com/blog/openai-api), ensuring a high-quality summary.

- **Accurate Translation:** Receive translations of the summarized content into your native language, facilitating understanding without the barrier of language. This function combines the capabilities of [LangChain](https://github.com/andreibondarev/langchainrb) with the [OpenAI API](https://openai.com/blog/openai-api) for reliable and precise translations.

- **User-Friendly Interface:** The application is designed with simplicity and accessibility in mind, featuring a large font and clear instructions to guide users through each step. Simplifying the signup process, users only need a phone number to register, utilizing the [Twilio API](https://www.twilio.com/en-us/user-authentication-identity/verify) for OTP (One-Time Password) verification.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## How it Works
1. **Language Selection:** The app automatically detects your browser's language setting for immediate convenience, with the option to manually select a different language if desired.
2. **Scan:** Utilize your device's camera to scan the physical mail letter you wish to understand.
3. **Summarize:** The app then processes the scanned image to extract text, generate a summary.
4. **Translate:** Automatically translated into chosen language.
5. **Read:**  The translated summary is displayed on your screen for easy reading.
- **optional:** Sign up with just your phone number to track and manage your summary history.

**Note:** Signup functionality leverages OTP verification via Twilio and is currently a work in progress. However, you can sign in with a test account to explore this feature. Use the test phone number: 1234567890, and test OTP code: 123456 for access.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Supported Languages
Currently support English, Spanish, French and Chinese. more are coming

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

Jun Chen (Peter) - [LinkedIn](https://www.linkedin.com/in/jun-peter-chen-189399117/) - peterchen424321@gmail.com

Project Link: [https://github.com/rulerpe/DuXine](https://github.com/rulerpe/DuXin)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[TypeScript]: https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=TypeScript&logoColor=FFF
[TypeScript-url]: https://www.typescriptlang.org/
[Ruby-on-Rails]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Ruby-on-Rails-url]: https://rubyonrails.org/
