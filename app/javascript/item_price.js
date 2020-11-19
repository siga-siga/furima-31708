function itemPrice() {

  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    
    const addTaxDom = document.getElementById("add-tax-price");
    const tax = 10
    const taxValue = (( inputValue * tax ) / 100 )
    addTaxDom.innerHTML = Math.floor( taxValue )

    const addProfitDom = document.getElementById("profit");
    addProfitDom.innerHTML = Math.ceil( inputValue - taxValue )
  })
}

window.addEventListener('load', itemPrice)