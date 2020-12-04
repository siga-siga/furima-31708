if (location.pathname.match("items/new")){
  document.addEventListener("DOMContentLoaded", () => {
    //console.log("読み込み完了");
    const inputElement = document.getElementById("items_tag_word");
    inputElement.addEventListener("keyup", () => {
      const keyword = document.getElementById("items_tag_word").value;
      const XHR = new XMLHttpRequest();
      XHR.open("GET", `search/?keyword=${keyword}`, true);
      XHR.responseType = "json";
      XHR.send();
      XHR.onload = () => {
        //console.log("非同期通信成功");
        const searchResult = document.getElementById("search-result");
        searchResult.innerHTML = "";
        if (XHR.response) {
          const tagName = XHR.response.keyword;
          tagName.forEach((tag) => {
            const childElement = document.createElement("div");
            childElement.setAttribute("class", "child");
            childElement.setAttribute("id", tag.id);
            childElement.innerHTML = tag.word;
            searchResult.appendChild(childElement);
            const clickElement = document.getElementById(tag.id);
            clickElement.addEventListener("click", () => {
              document.getElementById("items_tag_word").value = clickElement.textContent;
              clickElement.remove();
            });
          });
        };
      };
    });
  });
};