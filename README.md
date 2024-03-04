
<a name="readme-top"></a>

<br />
<div align="center">

<h1 align="center">Duxin (Leter Translator and Summarizer)</h3>

  <p align="center">
    Empowering non English speaker with seamless mail translation and summarization
    <br />
    <a href="https://www.duxinapp.com"><strong>View Demo</strong></a>
  </p>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

This project is insprired by my dad a non-tech savvy, not proficient in English, senior immgrant. People like him has a strong need to understand their mail letter. Thats why I created Duxin a letter translator and summarizer with a intuitive application designed to help non-tech savvy seniors and non English speaker effortlessly understand their mail in their native language.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Built With

* [![React][React.js]][React-url]
* [![TypeScript][TypeScript]][TypeScript-url]
* [![Ruby-on-Rails][Ruby-on-Rails]][Ruby-on-Rails-url]

The backend Rails api lives in this repo, [click here to checkout the frontend React repo](https://github.com/rulerpe/DuXin-Frontend)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Features

- **Instant Mail Scanning:** Utilize your device's camera to capture a picture of the mail letter you wish to understand. Using AWS Textract for OCR to extract text from the image.

- **Automated Summary:** Provide a concise summary of the letter's contents, highlighting essential information at a glance. Using LangChain to build prompt then send to OpenAI API.

- **Accurate Translation:** Receive translations of the summarized content in your native language. Using LangChain and OpenAI API

- **User-Friendly Interface:** Designed with simplicity in mind, large font, and clear instructions. No complex sign up, only need phone number using Twilio.

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## How it Works
1. **Language:** Automaticly pick up broswer lanaguage or option to select language
2. **Scan:** Use camera to scan the mail letter
3. **Summarize:** The app then processes the scanned image to extract text, generate a summary
4. **Translate:** Automatically translated into chosen language
5. **Read:** Display translated summary for easy reading
- **optional:** sigup with just phone number to track and manange summary history.

(Signup is using OTP from Twilio, it is current still work in prgress, but you can sigin with test account to check the feature out. Test phone number: 1234567890, test otp code: 123456)

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Supported Languages
Currently support English, Spanish, French and Chinese. more are coming

<p align="right">(<a href="#readme-top">back to top</a>)</p>

## Contact

Jun Chen (Peter) - [LinkedIn](https://www.linkedin.com/in/jun-peter-chen-189399117/) - peterchen424321@gmail.com

Project Link: [https://github.com/rulerpe/DuXine](https://github.com/rulerpe/DuXin)

<p align="right">(<a href="#readme-top">back to top</a>)</p>


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/github_username/repo_name.svg?style=for-the-badge
[contributors-url]: https://github.com/github_username/repo_name/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/github_username/repo_name.svg?style=for-the-badge
[forks-url]: https://github.com/github_username/repo_name/network/members
[stars-shield]: https://img.shields.io/github/stars/github_username/repo_name.svg?style=for-the-badge
[stars-url]: https://github.com/github_username/repo_name/stargazers
[issues-shield]: https://img.shields.io/github/issues/github_username/repo_name.svg?style=for-the-badge
[issues-url]: https://github.com/github_username/repo_name/issues
[license-shield]: https://img.shields.io/github/license/github_username/repo_name.svg?style=for-the-badge
[license-url]: https://github.com/github_username/repo_name/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/linkedin_username
[product-screenshot]: images/screenshot.png
[Next.js]: https://img.shields.io/badge/next.js-000000?style=for-the-badge&logo=nextdotjs&logoColor=white
[Next-url]: https://nextjs.org/
[React.js]: https://img.shields.io/badge/React-20232A?style=for-the-badge&logo=react&logoColor=61DAFB
[React-url]: https://reactjs.org/
[TypeScript]: https://img.shields.io/badge/TypeScript-3178C6?style=for-the-badge&logo=TypeScript&logoColor=FFF
[TypeScript-url]: https://www.typescriptlang.org/
[Ruby-on-Rails]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Ruby-on-Rails-url]: https://rubyonrails.org/
[Angular.io]: https://img.shields.io/badge/Angular-DD0031?style=for-the-badge&logo=angular&logoColor=white
[Angular-url]: https://angular.io/
[Svelte.dev]: https://img.shields.io/badge/Svelte-4A4A55?style=for-the-badge&logo=svelte&logoColor=FF3E00
[Svelte-url]: https://svelte.dev/
[Laravel.com]: https://img.shields.io/badge/Laravel-FF2D20?style=for-the-badge&logo=laravel&logoColor=white
[Laravel-url]: https://laravel.com
[Bootstrap.com]: https://img.shields.io/badge/Bootstrap-563D7C?style=for-the-badge&logo=bootstrap&logoColor=white
[Bootstrap-url]: https://getbootstrap.com
[JQuery.com]: https://img.shields.io/badge/jQuery-0769AD?style=for-the-badge&logo=jquery&logoColor=white
[JQuery-url]: https://jquery.com 