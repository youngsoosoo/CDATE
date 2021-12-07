<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>키워드로 장소검색하기</title>
    
</head>
<style>
#mapwrap{position:relative;overflow:hidden;}
.category, .category *{margin:0;padding:0;color:#000;}   
.category {position:absolute;overflow:hidden;top:10px;left:10px;width:150px;height:50px;z-index:10;border:1px solid black;font-family:'Malgun Gothic','맑은 고딕',sans-serif;font-size:12px;text-align:center;background-color:#fff;}
.category .menu_selected {background:#FF5F4A;color:#fff;border-left:1px solid #915B2F;border-right:1px solid #915B2F;margin:0 -1px;} 
.category li{list-style:none;float:left;width:50px;height:45px;padding-top:5px;cursor:pointer;} 
.category .ico_comm {display:block;margin:0 auto 2px;width:22px;height:26px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png') no-repeat;} 
.category .ico_coffee {background-position:-10px 0;}  
.category .ico_store {background-position:-10px -36px;}   
.category .ico_carpark {background-position:-10px -72px;} 

.customoverlay {position:relative;bottom:100px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 }
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
.body {position: relative;overflow: hidden;background: white;}
.desc {position: relative;margin: 13px 0 0 90px;height: 75px;}
.img {position: absolute;top: 6px;left: 5px;width: 73px;height: 71px;border: 1px solid #ddd;color: #888;overflow: hidden;}
.close {position: absolute;top: 10px;right: 10px;color: #888;width: 17px;height: 17px;background: url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/overlay_close.png');}
.close:hover {cursor: pointer;}
</style>
<script>
function fn_review() {
	var w = (window.screen.width/2)- 200;
	var h = (window.screen.height/2)- 200;
	var url = "review.jsp";
	window.open(url, "review", "width=500, height=500, left="+w+", top="+h);
}
</script>
<body>
<jsp:include page="/Header1.jsp" flush="false"/>
	<br><br><br><br>
<div style="text-align:center">
<form onsubmit="search(); return false;">
	키워드 : <input type="text" value="" id="keyword" size="15"> 
    <button type="submit">검색하기</button> 
</form>
</div>
<div id="mapwrap" style="width:100%;height:700px;text-align:center;"> 
    <!-- 지도가 표시될 div -->
    <div id="map"   style="width:100%;height:700px;"></div>
    <!-- 지도 위에 표시될 마커 카테고리 -->
    <div class="category">
        <ul>
            <li id="coffeeMenu" onclick="changeMarker('coffee')">
                <span class="ico_comm ico_coffee"></span>
                카페
            </li>
            <li id="storeMenu" onclick="changeMarker('store')">
                <span class="ico_comm ico_store"></span>
                놀거리
            </li>
            <li id="carparkMenu" onclick="changeMarker('carpark')">
                <span class="ico_comm ico_carpark"></span>
                맛집
            </li>
        </ul>
    </div>
</div>
<div id="map" style="width:100%;height:350px;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14d0355f8e5b04f2089caf762e49cfab&libraries=services"></script>
<script>
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({zIndex:1});

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(); 




//키워드 검색을 요청하는 함수입니다
function search() {

    var keyword = document.getElementById('keyword').value;

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch( keyword, placesSearchCB); 
} 


// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB (data, status, pagination) {
	if (status === kakao.maps.services.Status.OK) {

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        var bounds = new kakao.maps.LatLngBounds();

        for (var i=0; i<data.length; i++) {
            display(data[i]);    
            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
        }       

        // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
        map.setBounds(bounds);
    } 
}

// 지도에 마커를 표시하는 함수입니다
function display(place) {
	position: new kakao.maps.LatLng(place.y, place.x) 
}











//커피숍 마커가 표시될 좌표 배열입니다
var coffeePositions = [ 
new kakao.maps.LatLng(37.538039227194716, 127.00194612915838), //이태원 사유
new kakao.maps.LatLng(37.53336285189585, 126.99316351677554), //이태원 키에리
new kakao.maps.LatLng(37.56297789267969, 126.92549048486828), // 연남 발트
new kakao.maps.LatLng(37.57191831965359, 126.98723406421648), // 인사동 지유카페
new kakao.maps.LatLng(37.538158950595985, 126.66112740386629),// 청라 캐제
new kakao.maps.LatLng(37.443745015343374, 126.70387665937908),//구월동 댓
new kakao.maps.LatLng(37.4949600979105, 126.72320093665492)   // 부평 아날로그             
];

//놀거리 마커가 표시될 좌표 배열입니다
var storePositions = [
new kakao.maps.LatLng(37.55534691132315, 126.92270553499866), //홍대 더 이스케이프
new kakao.maps.LatLng(37.554196345889686, 126.92696479883055), // 플라비 향수 팔찌 은반지
new kakao.maps.LatLng(37.55190368734083, 126.9239992059499), //미디엄카페 스튜디오 그림
new kakao.maps.LatLng(37.55398635405459, 126.92262772042346),//레드버튼 보드게임카페
new kakao.maps.LatLng(37.55346578652984, 126.9257602476691), //레이저엑스 서바이벌 총
new kakao.maps.LatLng(37.555032076534154, 126.92349523978845),//코칭 심리카페
new kakao.maps.LatLng(37.55370911172103, 126.92234508028814) // 심신프리 힐링카페
];

//맛집 마커가 표시될 좌표 배열입니다
var carparkPositions = [
new kakao.maps.LatLng(37.560459744586524, 126.92570803631475), //연남취향
new kakao.maps.LatLng(37.560459744586524, 126.92570803631475), //마포곱창타운
new kakao.maps.LatLng(37.561743793713276, 126.92591332003495), //유니의 우아한 식당
new kakao.maps.LatLng(37.56229807986552, 126.92619007121881), //올랑올랑
new kakao.maps.LatLng(37.560148379945375, 126.92488495774052),//빌라 더 다이닝
new kakao.maps.LatLng(37.56104573086809, 126.92624789757491), //졸리연남
new kakao.maps.LatLng(37.56059021778733, 126.92543627209473)  //에그써티          다 연남           
];    

var markerImageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/category.png';  // 마커이미지의 주소입니다. 스프라이트 이미지 입니다
coffeeMarkers = [], // 커피숍 마커 객체를 가지고 있을 배열입니다
storeMarkers = [], // 편의점 마커 객체를 가지고 있을 배열입니다
carparkMarkers = []; // 주차장 마커 객체를 가지고 있을 배열입니다


createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
createStoreMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
createCarparkMarkers(); // 주차장 마커를 생성하고 주차장 마커 배열에 추가합니다

changeMarker(''); // 지도에 커피숍 마커가 보이도록 설정합니다    


//마커이미지의 주소와, 크기, 옵션으로 마커 이미지를 생성하여 리턴하는 함수입니다
function createMarkerImage(src, size, options) {
var markerImage = new kakao.maps.MarkerImage(src, size, options);
return markerImage;            
}

//좌표와 마커이미지를 받아 마커를 생성하여 리턴하는 함수입니다
function createMarker(position, image) {
var marker = new kakao.maps.Marker({
    position: position,
    image: image
});

return marker;  
}   

//커피숍 마커를 생성하고 커피숍 마커 배열에 추가하는 함수입니다
function createCoffeeMarkers() {

for (var i = 0; i < coffeePositions.length; i++) {  
    
    var imageSize = new kakao.maps.Size(22, 26),
        imageOptions = {  
            spriteOrigin: new kakao.maps.Point(10, 0),    
            spriteSize: new kakao.maps.Size(36, 98)  
        };     
    
    // 마커이미지와 마커를 생성합니다
    var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
        marker = createMarker(coffeePositions[0], markerImage);  
    
    marker1 = createMarker(coffeePositions[1], markerImage);  
    
    marker2 = createMarker(coffeePositions[2], markerImage);  
    
    marker3 = createMarker(coffeePositions[3], markerImage);  
    
    marker4 = createMarker(coffeePositions[4], markerImage);  
    
    marker5 = createMarker(coffeePositions[5], markerImage);  
    
    marker6 = createMarker(coffeePositions[6], markerImage);  
    
    // 생성된 마커를 커피숍 마커 배열에 추가합니다
    coffeeMarkers.push(marker);
    coffeeMarkers.push(marker1);
    coffeeMarkers.push(marker2);
    coffeeMarkers.push(marker3);
    coffeeMarkers.push(marker4);
    coffeeMarkers.push(marker5);
    coffeeMarkers.push(marker6);
    
  //마커 클릭 이벤트
    kakao.maps.event.addListener(marker, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content,
    	    map: map,
    	    position: coffeePositions[0]      
    	});
    });
    kakao.maps.event.addListener(marker1, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content1,
    	    map: map,
    	    position: coffeePositions[1]      
    	});
    });
    kakao.maps.event.addListener(marker2, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content2,
    	    map: map,
    	    position: coffeePositions[2]      
    	});
    });
    kakao.maps.event.addListener(marker3, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content3,
    	    map: map,
    	    position: coffeePositions[3]      
    	});
    });
    kakao.maps.event.addListener(marker4, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content4,
    	    map: map,
    	    position: coffeePositions[4]      
    	});
    });
    kakao.maps.event.addListener(marker5, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content5,
    	    map: map,
    	    position: coffeePositions[5]      
    	});
    });
    kakao.maps.event.addListener(marker6, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: content6,
    	    map: map,
    	    position: coffeePositions[6]      
    	});
    });
}     
}

//커피숍 마커들의 지도 표시 여부를 설정하는 함수입니다
function setCoffeeMarkers(map) {        
for (var i = 0; i < coffeeMarkers.length; i++) {  
    coffeeMarkers[i].setMap(map);
}        
}

//편의점 마커를 생성하고 편의점 마커 배열에 추가하는 함수입니다
function createStoreMarkers() {
for (var i = 0; i < storePositions.length; i++) {
    
    var imageSize = new kakao.maps.Size(22, 26),
        imageOptions = {   
            spriteOrigin: new kakao.maps.Point(10, 36),    
            spriteSize: new kakao.maps.Size(36, 98)  
        };       
 
    // 마커이미지와 마커를 생성합니다
    var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
        marker = createMarker(storePositions[0], markerImage); 
    
	marker1 = createMarker(storePositions[1], markerImage);  
    
    marker2 = createMarker(storePositions[2], markerImage);  
    
    marker3 = createMarker(storePositions[3], markerImage);  
    
    marker4 = createMarker(storePositions[4], markerImage);  
    
    marker5 = createMarker(storePositions[5], markerImage);  
    
    marker6 = createMarker(storePositions[6], markerImage);  
    
    
    // 생성된 마커를 편의점 마커 배열에 추가합니다
    storeMarkers.push(marker);    
    storeMarkers.push(marker1); 
    storeMarkers.push(marker2); 
    storeMarkers.push(marker3); 
    storeMarkers.push(marker4); 
    storeMarkers.push(marker5); 
    storeMarkers.push(marker6); 
    
    
  //마커 클릭 이벤트
    kakao.maps.event.addListener(marker, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent,
    	    map: map,
    	    position: storePositions[0]      
    	});
    });
    kakao.maps.event.addListener(marker1, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent1,
    	    map: map,
    	    position: storePositions[1]      
    	});
    });
    kakao.maps.event.addListener(marker2, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent2,
    	    map: map,
    	    position: storePositions[2]      
    	});
    });
    kakao.maps.event.addListener(marker3, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent3,
    	    map: map,
    	    position: storePositions[3]      
    	});
    });
    kakao.maps.event.addListener(marker4, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent4,
    	    map: map,
    	    position: storePositions[4]      
    	});
    });
    kakao.maps.event.addListener(marker5, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent5,
    	    map: map,
    	    position: storePositions[5]      
    	});
    });
    kakao.maps.event.addListener(marker6, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: acontent6,
    	    map: map,
    	    position: storePositions[6]      
    	});
    });
}        
}

//편의점 마커들의 지도 표시 여부를 설정하는 함수입니다
function setStoreMarkers(map) {        
for (var i = 0; i < storeMarkers.length; i++) {  
    storeMarkers[i].setMap(map);
}        
}

//주차장 마커를 생성하고 주차장 마커 배열에 추가하는 함수입니다
function createCarparkMarkers() {
for (var i = 0; i < carparkPositions.length; i++) {
    
    var imageSize = new kakao.maps.Size(22, 26),
        imageOptions = {   
            spriteOrigin: new kakao.maps.Point(10, 72),    
            spriteSize: new kakao.maps.Size(36, 98)  
        };       
 
    // 마커이미지와 마커를 생성합니다
    var markerImage = createMarkerImage(markerImageSrc, imageSize, imageOptions),    
        marker = createMarker(carparkPositions[0], markerImage);  

	marker1 = createMarker(carparkPositions[1], markerImage);  
    
    marker2 = createMarker(carparkPositions[2], markerImage);  
    
    marker3 = createMarker(carparkPositions[3], markerImage);  
    
    marker4 = createMarker(carparkPositions[4], markerImage);  
    
    marker5 = createMarker(carparkPositions[5], markerImage);  
    
    marker6 = createMarker(carparkPositions[6], markerImage);  
    
    
    // 생성된 마커를 맛집 마커 배열에 추가합니다
    carparkMarkers.push(marker);    
    carparkMarkers.push(marker1); 
    carparkMarkers.push(marker2); 
    carparkMarkers.push(marker3); 
    carparkMarkers.push(marker4); 
    carparkMarkers.push(marker5); 
    carparkMarkers.push(marker6); 
    
    
  //마커 클릭 이벤트
    kakao.maps.event.addListener(marker, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent,
    	    map: map,
    	    position: carparkPositions[0]     
    	});
    });
    kakao.maps.event.addListener(marker1, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent1,
    	    map: map,
    	    position: carparkPositions[1]    
    	});
    });
    kakao.maps.event.addListener(marker2, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent2,
    	    map: map,
    	    position: carparkPositions[2]
    	});
    });
    kakao.maps.event.addListener(marker3, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent3,
    	    map: map,
    	    position: carparkPositions[3]
    	});
    });
    kakao.maps.event.addListener(marker4, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent4,
    	    map: map,
    	    position: carparkPositions[4]  
    	});
    });
    kakao.maps.event.addListener(marker5, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent5,
    	    map: map,
    	    position: carparkPositions[5]
    	});
    });
    kakao.maps.event.addListener(marker6, 'click', function() {
    	overlay = new kakao.maps.CustomOverlay({
    	    content: bcontent6,
    	    map: map,
    	    position: carparkPositions[6] 
    	});
    });
      
}                
}

//주차장 마커들의 지도 표시 여부를 설정하는 함수입니다
function setCarparkMarkers(map) {        
for (var i = 0; i < carparkMarkers.length; i++) {  
    carparkMarkers[i].setMap(map);
}        
}

//카페의 커스텀 오버레이를 생성합니다
var overlay = new kakao.maps.CustomOverlay({
    content: content,
    map: map,
    position: coffeePositions[0]      
});

var content = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/sayoo.kr" target="_blank">' +
'    <span class="title">사유</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'    <a onclick="fn_review()">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20211125_277%2F1637798708016RHn3D_JPEG%2Fupload_3555521f3df22e6001f300ba0e6548b4.jpeg" width="73" height="70">' +
'        </div>' + 
'    </a>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 용산구 이태원로54길 5</div>' + 
'            <div class="jibun ellipsis">설명 : 이태원에 위치한 작은 유럽같은 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

//커스텀 오버레이를 생성합니다
var overlay1 = new kakao.maps.CustomOverlay({
    content: content1,
    map: map,
    position: coffeePositions[1]
});

var content1 = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/kyeri_official" target="_blank">' +
'    <span class="title">키에리</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA5MjZfMjc4%2FMDAxNTM3OTcwOTY2NTM5.SzzCWDBhejOV4eSHerQd526ZmfiVvgOWBLUsuCmsqhcg.NOAieDU_9epsBbpzcGYqDtn3B6qBH8cSk5kOGep1_ZYg.JPEG.victory2929%2FIMG_3852.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 용산구 이태원로26길 16-8 1층</div>' + 
'            <div class="jibun ellipsis">설명 : 이태원에 위치한 비건 디저트 집</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var overlay2 = new kakao.maps.CustomOverlay({
    content: content2,
    map: map,
    position: coffeePositions[2]
});

var content2 = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/valt.official" target="_blank">' +
'    <span class="title">발트</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20211114_117%2F1636867627670shSIH_JPEG%2Fupload_84ddd39af52caafc8eed42246d8b3c79.jpeg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 동교로 262-3 2층</div>' + 
'            <div class="jibun ellipsis">설명 : 연남동에 위치한 모던 인더스트리얼 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var overlay3 = new kakao.maps.CustomOverlay({
    content: content3,
    map: map,
    position: coffeePositions[3]
});

var content3 = '<div class="customoverlay">' +
'  <a href="http://www.gutea.co.kr" target="_blank">' +
'    <span class="title">지유명차</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_90%2F1441025127884mw3fb_JPEG%2F156155408557789_0.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 종로구 인사동길 12 인사코리아(상가內1층105호)</div>' + 
'            <div class="jibun ellipsis">설명 : 인사동에 위치한 차를 마시며 힐링할 수 있는 차 집</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var overlay4 = new kakao.maps.CustomOverlay({
    content: content4,
    map: map,
    position: coffeePositions[4]
});

var content4 = '<div class="customoverlay">' +
'  <a href="http://www.instagram.com/kase_coffee" target="_blank">' +
'    <span class="title">캐제</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA4MTlfMTY2%2FMDAxNjI5MzU2MDIzNTkw.aDESDWCbXXOnqj42xnFf-eS17YlWkeP31CATo7ItlPMg.-XJLMXxZl4UWF52aj1RF3BLaAos5eZTgOKQQyA5ojXog.JPEG.dalsong007%2F20210819%25A3%25DF112849.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">인천 서구 담지로86번길 5-21</div>' + 
'            <div class="jibun ellipsis">설명 : 청라에 위치한 유니크한 공간과<br> 차별화된 스페셜 음료가 준비되어 있는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var overlay5 = new kakao.maps.CustomOverlay({
    content: content5,
    map: map,
    position: coffeePositions[5]
});

var content5 = '<div class="customoverlay">' +
'  <a href="http://instagram.com/thatcoffee_" target="_blank">' +
'    <span class="title">댓</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191108_282%2F1573194539324pBi7b_JPEG%2FrflW842SR5pT5giMOTdh4gYb.jpeg.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">인천 남동구 인하로511번길 10-7 1층, 2층</div>' + 
'            <div class="jibun ellipsis">설명 : 구월동에 위치한 올 블랙 인테리어로<br> 인스타 감성을 느끼게 해주는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var overlay6 = new kakao.maps.CustomOverlay({
    content: content6,
    map: map,
    position: coffeePositions[6]
});

var content6 = '<div class="customoverlay">' +
'  <a href="http://instagram.com/analog_2013" target="_blank">' +
'    <span class="title">아날로그</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20201026_151%2F1603697924347PYqm2_JPEG%2Fupload_fb46c44a6b67aab1df66029060a7a6e0.jpeg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">부인천 부평구 부평대로40번길 4-1 1층</div>' + 
'            <div class="jibun ellipsis">설명 : 부평에 위치한 편안하고 따뜻한 감성을 담아<br> 휴식을 취할 수 있는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';





//놀거리의 커스텀 오버레이를 생성합니다
var aoverlay = new kakao.maps.CustomOverlay({
    content: acontent,
    map: map,
    position: storePositions[0]      
});

var acontent = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/the_q.escape" target="_blank">' +
'    <span class="title">더큐 이스케이프</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200712_222%2F1594554149021GGrHl_JPEG%2FZD9BifGwD0fXw-w0FJNAulYH.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 홍익로6길 15 4층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 이색 데이트를 할 수 있는 방탈출 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

//놀거리의 커스텀 오버레이를 생성합니다
var aoverlay1 = new kakao.maps.CustomOverlay({
    content: acontent1,
    map: map,
    position: storePositions[1]
});

var acontent1 = '<div class="customoverlay">' +
'  <a href="https://blog.naver.com/dudrl2323" target="_blank">' +
'    <span class="title">플라비</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210309_96%2F1615269710597k9jUl_JPEG%2Fmi2dq-8Qb-Lx3BzgZ7UeZhaf.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 와우산로27길 23 지하1층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 커플 아이템을 만들 수 있는 공방</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var aoverlay2 = new kakao.maps.CustomOverlay({
    content: acontent2,
    map: map,
    position: storePositions[2]
});

var acontent2 = '<div class="customoverlay">' +
'  <a href="http://instagram.com/medium.cafe.studio" target="_blank">' +
'    <span class="title">미디엄 카페</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA4MDNfODQg%2FMDAxNjI4MDAwOTAzMTQ5.k3OkI7yJWbGSUHrspIDTUD4fHwUuJx6FFAJl99GI2H8g.aMzKX3ZodcWAE4h65stsvZqPomVZriFY6RxwjnGa_A0g.JPEG.isaac0331%2FIMG_2255.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 와우산로18길 38 2층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 그림그리기와 커피를 함께 즐길 수 있는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var aoverlay3 = new kakao.maps.CustomOverlay({
    content: acontent3,
    map: map,
    position: storePositions[3]
});

var acontent3 = '<div class="customoverlay">' +
'  <a href="http://www.redbutton.co.kr" target="_blank">' +
'    <span class="title">레드버튼</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210507_134%2F1620346804749Gszzf_JPEG%2FRBA2GnlYzPJMfvSNbAVU4Joe.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 홍익로 19 3층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 보드게임을 즐길 수 있는 보드게임 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var aoverlay4 = new kakao.maps.CustomOverlay({
    content: acontent4,
    map: map,
    position: storePositions[4]
});

var acontent4 = '<div class="customoverlay">' +
'  <a href="http://www.instagram.com/laserarena.kr" target="_blank">' +
'    <span class="title">레이저엑스</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20210126_178%2F1611658888432SQEN4_JPEG%2FbU_KaAd4kPhHqaI42YRaMEBz.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 와우산로 111 태화프라자 5층 레이저엑스</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 서바이벌을 즐길 수 있는<br> 서바이벌 게임장</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var aoverlay5 = new kakao.maps.CustomOverlay({
    content: acontent5,
    map: map,
    position: storePositions[5]
});

var acontent5 = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/coaching_love" target="_blank">' +
'    <span class="title">코칭</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20180330_157%2F1522377415130wXYs2_JPEG%2FskmeswiPuXEeX5zhhGeE4vTY.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 어울마당로 118 6층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 심리 분석을 할 수 있는<br> 심리 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var aoverlay6 = new kakao.maps.CustomOverlay({
    content: acontent6,
    map: map,
    position: storePositions[6]
});

var acontent6 = '<div class="customoverlay">' +
'  <a href="http://www.simsinfree.com" target="_blank">' +
'    <span class="title">심신프리</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20200901_56%2F1598934619502RC59G_PNG%2F%25C0%25FC%25BD%25C5%25B8%25B6%25BB%25E7%25C1%25F6.png" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울특별시 마포구 어울마당로 98-1 더샘매장 3층</div>' + 
'            <div class="jibun ellipsis">설명 : 홍대에 위치한 편안하게 꿀잠과 휴식을 즐길 수 있는<br> 힐링 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';





//맛집의 커스텀 오버레이를 생성합니다
var boverlay = new kakao.maps.CustomOverlay({
    content: bcontent,
    map: map,
    position: carparkPositions[0]      
});

var bcontent = '<div class="customoverlay">' +
'  <a href="https://map.naver.com/v5/search/%EC%97%B0%EB%82%A8%EC%B7%A8%ED%96%A5/place/1206369946?c=14128372.3146709,4517514.9426455,15,0,0,3,dh&placePath=%3Fentry%253Dbmp" target="_blank">' +
'    <span class="title">연남취향</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMDEyMDlfMTY2%2FMDAxNjA3NTE3MTA5MDE5.YPkH_alzYhK9Q0aZ_gP-2jkF1Rlz6-Cc04P3NUelbG4g.4vvuLML0E2pwYoyhZIdWA4U7mb_h7GPb7gPLqc_E4EAg.PNG.v2eoh%2F%253F%25A0%259C%25EB%25AA%25A9%25EC%259D%2584-%253F%259E%2585%253F%25A0%25A5%253F%2595%25B4%25EC%25A3%25BC%25EC%2584%25B8%253F%259A%2594.-46.png" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 연희로1길 36</div>' + 
'            <div class="jibun ellipsis">설명 : 연남동에 위치한 맛있는 양식을 즐길 수 있는 맛집</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';


var boverlay1 = new kakao.maps.CustomOverlay({
    content: bcontent1,
    map: map,
    position: carparkPositions[1]  
});

var bcontent1 = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/kyeri_official" target="_blank">' +
'    <span class="title">마포곱창타운</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAxODA5MjZfMjc4%2FMDAxNTM3OTcwOTY2NTM5.SzzCWDBhejOV4eSHerQd526ZmfiVvgOWBLUsuCmsqhcg.NOAieDU_9epsBbpzcGYqDtn3B6qBH8cSk5kOGep1_ZYg.JPEG.victory2929%2FIMG_3852.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 용산구 이태원로26길 16-8 1층</div>' + 
'            <div class="jibun ellipsis">설명 : 이태원에 위치한 비건 디저트 집</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var boverlay2 = new kakao.maps.CustomOverlay({
    content: bcontent2,
    map: map,
    position: carparkPositions[2]  
});

var bcontent2 = '<div class="customoverlay">' +
'  <a href="https://www.instagram.com/valt.official" target="_blank">' +
'    <span class="title">유니의 우아한 식당</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20211114_117%2F1636867627670shSIH_JPEG%2Fupload_84ddd39af52caafc8eed42246d8b3c79.jpeg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 마포구 동교로 262-3 2층</div>' + 
'            <div class="jibun ellipsis">설명 : 연남동에 위치한 모던 인더스트리얼 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var boverlay3 = new kakao.maps.CustomOverlay({
    content: bcontent3,
    map: map,
    position: carparkPositions[3]  
});

var bcontent3 = '<div class="customoverlay">' +
'  <a href="http://www.gutea.co.kr" target="_blank">' +
'    <span class="title">올랑올랑</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20150831_90%2F1441025127884mw3fb_JPEG%2F156155408557789_0.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">서울 종로구 인사동길 12 인사코리아(상가內1층105호)</div>' + 
'            <div class="jibun ellipsis">설명 : 인사동에 위치한 차를 마시며 힐링할 수 있는 차 집</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var boverlay4 = new kakao.maps.CustomOverlay({
    content: bcontent4,
    map: map,
    position: carparkPositions[4]  
});

var bcontent4 = '<div class="customoverlay">' +
'  <a href="http://www.instagram.com/kase_coffee" target="_blank">' +
'    <span class="title">빌라 더 다이닝</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=http%3A%2F%2Fblogfiles.naver.net%2FMjAyMTA4MTlfMTY2%2FMDAxNjI5MzU2MDIzNTkw.aDESDWCbXXOnqj42xnFf-eS17YlWkeP31CATo7ItlPMg.-XJLMXxZl4UWF52aj1RF3BLaAos5eZTgOKQQyA5ojXog.JPEG.dalsong007%2F20210819%25A3%25DF112849.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">인천 서구 담지로86번길 5-21</div>' + 
'            <div class="jibun ellipsis">설명 : 청라에 위치한 유니크한 공간과<br> 차별화된 스페셜 음료가 준비되어 있는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var boverlay5 = new kakao.maps.CustomOverlay({
    content: bcontent5,
    map: map,
    position: carparkPositions[5]  
});

var bcontent5 = '<div class="customoverlay">' +
'  <a href="http://instagram.com/thatcoffee_" target="_blank">' +
'    <span class="title">졸리연남</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fldb-phinf.pstatic.net%2F20191108_282%2F1573194539324pBi7b_JPEG%2FrflW842SR5pT5giMOTdh4gYb.jpeg.jpg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">인천 남동구 인하로511번길 10-7 1층, 2층</div>' + 
'            <div class="jibun ellipsis">설명 : 구월동에 위치한 올 블랙 인테리어로<br> 인스타 감성을 느끼게 해주는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';

var boverlay6 = new kakao.maps.CustomOverlay({
    content: bcontent6,
    map: map,
    position: carparkPositions[6]  
});

var bcontent6 = '<div class="customoverlay">' +
'  <a href="http://instagram.com/analog_2013" target="_blank">' +
'    <span class="title">에그써티</span>' +
'  </a>' +
'	 <div class="close" onclick="closeOverlay()" title="닫기"></div>' + 
'    <div class="body">' + 
'        <div class="img">' +
'            <img src="https://search.pstatic.net/common/?autoRotate=true&quality=95&type=w750&src=https%3A%2F%2Fmyplace-phinf.pstatic.net%2F20201026_151%2F1603697924347PYqm2_JPEG%2Fupload_fb46c44a6b67aab1df66029060a7a6e0.jpeg" width="73" height="70">' +
'        </div>' + 
'        <div class="desc">' + 
'            <div class="ellipsis">부인천 부평구 부평대로40번길 4-1 1층</div>' + 
'            <div class="jibun ellipsis">설명 : 부평에 위치한 편안하고 따뜻한 감성을 담아<br> 휴식을 취할 수 있는 카페</div>' + 
'        </div>' + 
'    </div>' + 
'</div>';




// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

//카테고리를 클릭했을 때 type에 따라 카테고리의 스타일과 지도에 표시되는 마커를 변경합니다
function changeMarker(type){

var coffeeMenu = document.getElementById('coffeeMenu');
var storeMenu = document.getElementById('storeMenu');
var carparkMenu = document.getElementById('carparkMenu');

// 커피숍 카테고리가 클릭됐을 때
if (type === 'coffee') {

    // 커피숍 카테고리를 선택된 스타일로 변경하고
    coffeeMenu.className = 'menu_selected';
    
    // 편의점과 주차장 카테고리는 선택되지 않은 스타일로 바꿉니다
    storeMenu.className = '';
    carparkMenu.className = '';
    
    // 커피숍 마커들만 지도에 표시하도록 설정합니다
    setCoffeeMarkers(map);
    setStoreMarkers(null);
    setCarparkMarkers(null);
    
} else if (type === 'store') { // 편의점 카테고리가 클릭됐을 때

    // 편의점 카테고리를 선택된 스타일로 변경하고
    coffeeMenu.className = '';
    storeMenu.className = 'menu_selected';
    carparkMenu.className = '';
    
    // 편의점 마커들만 지도에 표시하도록 설정합니다
    setCoffeeMarkers(null);
    setStoreMarkers(map);
    setCarparkMarkers(null);
    
} else if (type === 'carpark') { // 주차장 카테고리가 클릭됐을 때
 
    // 주차장 카테고리를 선택된 스타일로 변경하고
    coffeeMenu.className = '';
    storeMenu.className = '';
    carparkMenu.className = 'menu_selected';
    
    // 주차장 마커들만 지도에 표시하도록 설정합니다
    setCoffeeMarkers(null);
    setStoreMarkers(null);
    setCarparkMarkers(map);  
}    
} 

</script>
</body>
</html>