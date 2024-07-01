// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import "channels"

import $ from 'jquery'
global.$ = $

Rails.start()
Turbolinks.start()

// リストの初期文字グレーにする処理
document.addEventListener("DOMContentLoaded", function() {
  const selectElements = document.querySelectorAll(".initial_char");

  selectElements.forEach(function(selectElement) {
    // 初期状態のプレースホルダーをグレーに設定
    selectElement.style.color = "#a9a9a9";

    // イベントリスナーを追加して選択時に色を変更
    selectElement.addEventListener("change", function() {
      if (selectElement.value === "") {
        selectElement.style.color = "#a9a9a9"; // プレースホルダーが選択された場合
      } else {
        selectElement.style.color = "#000000"; // その他の選択肢が選択された場合
      }
    });
  });
});