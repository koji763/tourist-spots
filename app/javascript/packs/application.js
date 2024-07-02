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

// // リストの初期文字グレーにする処理
// document.addEventListener("DOMContentLoaded", function() {
//   const selectElements = document.querySelectorAll(".initial_char");

//   selectElements.forEach(function(selectElement) {
//     // 初期状態のプレースホルダーをグレーに設定
//     selectElement.style.color = "#a9a9a9";

//     // イベントリスナーを追加して選択時に色を変更
//     selectElement.addEventListener("change", function() {
//       if (selectElement.value === "") {
//         selectElement.style.color = "#a9a9a9"; // プレースホルダーが選択された場合
//       } else {
//         selectElement.style.color = "#000000"; // その他の選択肢が選択された場合
//       }
//     });
//   });
// });


// const buttonOpen = document.getElementById("modalOpen");
// const buttonClose = document.querySelector(".modalClose");
// const modal = document.getElementById("modal");

// console.log(buttonOpen, buttonClose, modal);

// buttonOpen.addEventListener("click", () => {
//   modal.style.display = "block";
// });

// buttonClose.addEventListener("click", () => {
//   modal.style.display = "none";
// });

// プレビューメッソド
document.addEventListener('DOMContentLoaded', function() {
  let fileList = []; // アップロードされたファイルを保持する配列

  // プレビューの設定
  function readURL(input) {
    const newFiles = Array.from(input.files); // 新しくアップロードされたファイル
    fileList = fileList.concat(newFiles); // 既存のファイルリストと新しいファイルをマージ

    const previewZone = document.getElementById('preview-zone');
    previewZone.innerHTML = ''; // 既存のプレビューをクリア

    fileList.forEach((file, index) => {
      const reader = new FileReader();
      const uniqueId = 'file-' + index; // 一意の識別子を生成

      reader.onload = function(e) {
        const img = document.createElement('img');
        img.src = e.target.result;
        img.width = 100;
        img.height = 100;
        img.classList.add('preview-img');

        const removeButton = document.createElement('button');
        removeButton.type = 'button';
        removeButton.innerHTML = '&times;';
        removeButton.classList.add('remove-btn');
        removeButton.dataset.fileId = uniqueId; // 一意の識別子を設定

        removeButton.onclick = function() {
          img.remove();
          removeButton.remove();

          // 指定されたファイルを fileList から削除
          fileList = fileList.filter((_, i) => 'file-' + i !== this.dataset.fileId);

          // ファイルリストを再設定
          const dataTransfer = new DataTransfer();
          fileList.forEach(f => dataTransfer.items.add(f));
          input.files = dataTransfer.files; // input の files プロパティを更新
        };

        previewZone.appendChild(img);
        previewZone.appendChild(removeButton);
      };

      reader.readAsDataURL(file);
    });

    input.value = ''; // 同じファイルを再度アップロードできるようにクリア
  }

  document.getElementById('tourist_spot_images').addEventListener('change', function() {
    readURL(this);
  });
});

