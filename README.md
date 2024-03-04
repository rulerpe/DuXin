
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

This project is insprired by my dad a non-tech savvy, not proficient in English, senior immgrant. People like him has a strong need to understand their mail letter. Thats why I created Duxin a letter translator and summarizer with a intuitive application designed to help non-tech savvy seniors and non English speaker effortlessly understand their mail in their native language.

The app ths build mobile first, it's easier to take photo with a phone, but there also a option to upload image from local files.

<p align="right">(<a target="_blank" href="#readme-top">back to top</a>)</p>



### Built With

* [![React][React.js]][React-url]
* [![TypeScript][TypeScript]][TypeScript-url]
* [![Ruby-on-Rails][Ruby-on-Rails]][Ruby-on-Rails-url]

The backend Rails api lives in this repo, [click here to checkout the frontend React repo](https://github.com/rulerpe/DuXin-Frontend)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- **Instant Mail Scanning:** Utilize your device's camera to capture a picture of the mail letter you wish to understand. Using [AWS Textract](https://aws.amazon.com/textract/) for OCR to extract text from the image.

- **Automated Summary:** Provide a concise summary of the letter's contents, highlighting essential information at a glance. Using [LangChain](https://github.com/andreibondarev/langchainrb) to build prompt then send to [OpenAI API](https://openai.com/blog/openai-api).

- **Accurate Translation:** Receive translations of the summarized content in your native language. Using [LangChain](https://github.com/andreibondarev/langchainrb) and [OpenAI API](https://openai.com/blog/openai-api)

- **User-Friendly Interface:** Designed with simplicity in mind, large font, and clear instructions. No complex signup, only need phone number for OTP signup with [Twilio API](https://www.twilio.com/en-us/user-authentication-identity/verify).

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## How it Works
1. **Language:** Automaticly pick up broswer lanaguage or option to select language
2. **Scan:** Use camera to scan the mail letter
3. **Summarize:** The app then processes the scanned image to extract text, generate a summary
4. **Translate:** Automatically translated into chosen language
5. **Read:** Display translated summary for easy reading
- **optional:** sigup with just phone number to track and manange summary history.

(Signup is using OTP from Twilio, it is current still work in prgress, but you can signin with a test account to check the feature out. Test phone number: 1234567890, test otp code: 123456)

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
