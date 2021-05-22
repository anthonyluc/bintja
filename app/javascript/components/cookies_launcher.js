import CookiesEuBanner from '../utils/cookies-eu-banner';

const cookiesLauncher = () => {
  new CookiesEuBanner(function () {
   
  }, true);
}

export { cookiesLauncher };