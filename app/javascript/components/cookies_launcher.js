import CookiesEuBanner from '../utils/cookies-eu-banner';

const cookiesLauncher = () => {
  new CookiesEuBanner(function () {
    // Facebook Pixel Code
    var fbsrc = document.getElementById("fbsrc");
    if(!fbsrc) {
      fbsrc = document.createElement("noscript");
      fbsrc.type = "html";
      fbsrc.id = "fbsrc"
      fbsrc.innerHTML = `<img height="1" width="1" style="display:none" src="https://www.facebook.com/tr?id=468882930863898&ev=PageView&noscript=1" />`;

      var hfb = document.getElementsByTagName("head")[0];
      hfb.parentNode.appendChild(fbsrc);

      !function(f,b,e,v,n,t,s)
      {if(f.fbq)return;n=f.fbq=function(){n.callMethod?
      n.callMethod.apply(n,arguments):n.queue.push(arguments)};
      if(!f._fbq)f._fbq=n;n.push=n;n.loaded=!0;n.version='2.0';
      n.queue=[];t=b.createElement(e);t.async=!0;
      t.src=v;s=b.getElementsByTagName(e)[0];
      s.parentNode.insertBefore(t,s)}(window, document,'script',
      'https://connect.facebook.net/en_US/fbevents.js');
      fbq('init', '468882930863898');
      fbq('track', 'PageView');
    }
    // End Facebook Pixel Code

    // Google Analytics
    var gasrc = document.getElementById("gasrc");
    if(!gasrc) {
      gasrc = document.createElement("script");
      gasrc.type = "text/javascript";
      gasrc.id = "gasrc";
      gasrc.src = "https://www.googletagmanager.com/gtag/js?id=G-L9FVDSPSXV";
      gasrc.async = true;
  
      var h = document.getElementsByTagName("head")[0];
      h.parentNode.appendChild(gasrc);

      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', 'G-L9FVDSPSXV');
    }
    // End Google Analytics Code
  }, true);
}

export { cookiesLauncher };