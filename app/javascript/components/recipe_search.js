import Typed from 'typed.js';

const loadDynamicSearchText = () => {
  new Typed('#home #search_query', {
    strings: ["Beef brocoli", "Pizza 4 fromages", "Gâteau au chocolat", "Pasta a la boloñesa", "Bean burger", "Strawberry Rhubarb Pie"],
    typeSpeed: 70,
    loop: true,
    attr: 'value',
    bindInputFocusEvents: true,
    shuffle: true,
    backSpeed: 10
  });
}

export { loadDynamicSearchText };