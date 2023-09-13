<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
        body {
            font-family: Arial, sans-serif;
            line-height: 1.6;
            margin: 20px;
            padding: 0;
        }

        h1 {
        text-align :center;
            font-size: 24px;
        }

        form {
            max-width: 600px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        form div {
            margin-bottom: 10px;
        }

        label {
            display: block;
            font-weight: bold;
        }

        input[type="text"],
        input[type="file"] {
            width: 100%;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
         #content,#content1,#content2 {
        width: 590px;
        height: 150px; /* 높이를 조절하여 보여질 줄의 개수를 설정합니다. */
        padding: 10px; /* 원하는 여백을 설정합니다. */
        border: 1px solid #ccc;
        border-radius: 4px;
        resize: none; /* 사용자가 크기를 조절하지 못하도록 설정합니다. */
    }

        input[type="file"] {
            padding-top: 10px;
        }

        #thumbnail_view {
            display: inline-block;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 4px;
            margin-bottom: 10px;
        }

        #thumbnail_view img {
            max-width: 100%;
            max-height: 150px;
        }

        button {
            background-color: gray;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
        }

        button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        button:hover {
            background-color: #45a049;
        }

        .error-message {
            color: red;
        }
    </style>
    
<script src="https://code.jquery.com/jquery-3.7.0.min.js" integrity="sha256-2Pmvv0kuTBOenSvLm6bvfBSSHrUJ+3A7x6P5Ebd07/g=" crossorigin="anonymous"></script>
<script type="text/javascript">
function add(){
   var file1 = document.getElementById("file1").value;
	var title = document.getElementById("title").value;
   var price  = document.getElementById("price").value;
   var content = document.getElementById("content").value;
   var file2  = document.getElementById("file2").value;
   var file3 = document.getElementById("file3").value;
   

     if (title == "") {
       alert("'글 제목' 입력은 필수입니다");
       return false;
     } else if (price == "") {
       alert("'가격' 입력은 필수입니다");
       return false;
     }else if (content == "") {
      alert("'글쓰기' 입력은 필수입니다");
       return false;
     } else if (file2 == "") {
       alert("'첫번째사진' 은 필수입니다");
       return false;
       } else if (file3 == "") {
       alert("'두번째사진' 은 필수입니다");
       return false;
       } else if (1 == "") {
      alert("'메인사진' 은 필수입니다");
      return false;
     } 
   
   if (!confirm("글을 모두 작성하셨나요?")) {
       return false;
   }
   $('#btnUpload').prop('disabled', true);
   var form = $('#addform')[0];
    var formData = new FormData(form);
   $.ajax({
      url:'/carrot/add',
       data: formData,
       enctype: 'multipart/form-data',
         method: 'post',
         cache: false,
         dataType: 'json',
         processData: false,
         contentType: false,
         timeout: 3600,
      success:function(res) {
         alert(res.added ? '저장 성공':' 저장 실패');

      },
      error:function(xhr,status,err) {
         alert('에러:' + err);
          $('#btnUpload').prop('disabled', false);
      }
   });
   return false;
}

function preview(evt) {
    var reader = new FileReader();

    reader.onload = function (event) {
        var thumbnailContainer = document.getElementById("thumbnail_view");
        thumbnailContainer.innerHTML = "";

        var img = document.createElement("img");
        img.src = event.target.result;
        thumbnailContainer.appendChild(img);
    };

    reader.readAsDataURL(evt.target.files[0]);
}


</script>
<meta charset="utf-8">
<title>추가 폼</title>
</head>
<body>
<h1>물품 추가</h1>
<form id="addform" onsubmit="return add();">
    <div>
        <label for="img">메인이미지</label>
        <input type="file" id="file1" name="file1" onchange="preview(event);">
    </div>
   <div id="thumbnail_view">
                <span>Preview Image</span>
            </div>
        <input type="hidden" id="userid" name="userid" value="${userid}">
        <input type="hidden" id="state" name="state" value="판매중">
        <input type="hidden" id="number" name="number" value =0>
    <div>
        <label>글 제목</label>
        <input type="text" id="title" name="title">
    </div>
    <div>
        <label>가격</label>
        <input type="text" id="price" name="price">
    </div>
    <div>
       <label for="img">이미지1</label>
        <input type="file" id="file2" name="file2" onchange="preview1(event);">
        </div>
      <div id="thumbnail_view1">
                <span>Preview Image</span>
            </div>
      <div>
       <label for="img">이미지2</label>
        <input type="file" id="file3" name="file3" onchange="preview1(event);">
        </div>
      <div id="thumbnail_view2">
                <span>Preview Image</span>
            </div>     
      <div>
       <label for="img">이미지3</label>
        <input type="file" id="file4" name="file4" onchange="preview1(event);">
        </div>
      <div id="thumbnail_view3">
                <span>Preview Image</span>
            </div>
      <div>
       <label for="img">이미지4</label>
        <input type="file" id="file5" name="file5" onchange="preview1(event);">
        </div>
      <div id="thumbnail_view4">
                <span>Preview Image</span>
            </div>
    <div>
        <label>글쓰기<a style="color: red; font-size: 5px;">*이미지파일이 존재하면 이미지파일이 먼저 나옵니다*</a></label>
        <textarea id="content" name="content"></textarea>
    </div>
    <div>
        <button id="btnUpload" type="submit">확인</button>
    </div>
</form>
</body>
</html>