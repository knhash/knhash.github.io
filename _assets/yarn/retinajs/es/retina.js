const hasWindow = typeof window !== 'undefined';
const environment = Math.round(hasWindow ? window.devicePixelRatio || 1 : 1);
const srcReplace = /(\.[A-z]{3,4}\/?(\?.*)?)$/;
const inlineReplace = /url\(('|")?([^)'"]+)('|")?\)/i;
const selector = '[data-rjs]';
const processedAttr = 'data-rjs-processed';
function arrayify(object) {
  return Array.prototype.slice.call(object);
}
function chooseCap(cap) {
  const numericCap = parseInt(cap, 10);
  if (environment < numericCap) {
    return environment;
  } else {
    return numericCap;
  }
}
function forceOriginalDimensions(image) {
  if (!image.hasAttribute('data-no-resize')) {
    if (image.offsetWidth === 0 && image.offsetHeight === 0) {
      image.setAttribute('width', image.naturalWidth);
      image.setAttribute('height', image.naturalHeight);
    } else {
      image.setAttribute('width', image.offsetWidth);
      image.setAttribute('height', image.offsetHeight);
    }
  }
  return image;
}
function setSourceIfAvailable(image, retinaURL) {
  const imgType = image.nodeName.toLowerCase();
  const testImage = document.createElement('img');
  testImage.addEventListener('load', () => {
    if (imgType === 'img') {
      forceOriginalDimensions(image).setAttribute('src', retinaURL);
    } else {
      image.style.backgroundImage = `url(${retinaURL})`;
    }
  });
  testImage.setAttribute('src', retinaURL);
  image.setAttribute(processedAttr, true);
}
function dynamicSwapImage(image, src, rjs = 1) {
  const cap = chooseCap(rjs);
  if (src && cap > 1) {
    const newSrc = src.replace(srcReplace, `@${cap}x$1`);
    setSourceIfAvailable(image, newSrc);
  }
}
function manualSwapImage(image, src, hdsrc) {
  if (environment > 1) {
    setSourceIfAvailable(image, hdsrc);
  }
}
function getImages(images) {
  if (!images) {
    return typeof document !== 'undefined' ? arrayify(document.querySelectorAll(selector)) : [];
  } else {
    return typeof images.forEach === 'function' ? images : arrayify(images);
  }
}
function cleanBgImg(img) {
  return img.style.backgroundImage.replace(inlineReplace, '$2');
}
function retina(images) {
  getImages(images).forEach(img => {
    if (!img.getAttribute(processedAttr)) {
      const isImg = img.nodeName.toLowerCase() === 'img';
      const src = isImg ? img.getAttribute('src') : cleanBgImg(img);
      const rjs = img.getAttribute('data-rjs');
      const rjsIsNumber = !isNaN(parseInt(rjs, 10));
      if (rjs === null) {
        return;
      }
      if (rjsIsNumber) {
        dynamicSwapImage(img, src, rjs);
      } else {
        manualSwapImage(img, src, rjs);
      }
    }
  });
}
if (hasWindow) {
  window.addEventListener('load', () => {
    retina();
  });
  window.retinajs = retina;
}

export default retina;
//# sourceMappingURL=retina.js.map
