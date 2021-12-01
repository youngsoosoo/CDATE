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
<body>
<jsp:include page="/Header1.jsp" flush="false"/>
	<br><br><br><br>
<div id="sea" style="text-align:center">
<form onsubmit="search(); return false;">
	키워드 : <input type="text" value="" id="keyword" size="15"> 
    <button type="submit">검색하기</button> 
    <br>
</form>
</div>
<div id="mapwrap" style="width:100%;height:700px;text-align:center;"> 
    <!-- 지도가 표시될 div -->
    <div id="map" style="width:100%;height:700px;"></div>
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

//커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}
});

var content = '<div class="customoverlay">' +
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


//커스텀 오버레이를 생성합니다
var overlay = new kakao.maps.CustomOverlay({
    content: content,
    map: map,
    position: coffeePositions[1]      
});

// 커스텀 오버레이를 닫기 위해 호출되는 함수입니다 
function closeOverlay() {
    overlay.setMap(null);     
}

createCoffeeMarkers(); // 커피숍 마커를 생성하고 커피숍 마커 배열에 추가합니다
createStoreMarkers(); // 편의점 마커를 생성하고 편의점 마커 배열에 추가합니다
createCarparkMarkers(); // 주차장 마커를 생성하고 주차장 마커 배열에 추가합니다

changeMarker(); // 지도에 커피숍 마커가 보이도록 설정합니다    


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
        marker = createMarker(coffeePositions[i], markerImage);  
    
    // 생성된 마커를 커피숍 마커 배열에 추가합니다
    coffeeMarkers.push(marker);
    
    
    
  	//마커 클릭 이벤트
    kakao.maps.event.addListener(marker, 'click', function() {
        overlay.setMap(map);
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
        marker = createMarker(storePositions[i], markerImage);  

    // 생성된 마커를 편의점 마커 배열에 추가합니다
    storeMarkers.push(marker);    
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
        marker = createMarker(carparkPositions[i], markerImage);  

    // 생성된 마커를 주차장 마커 배열에 추가합니다
    carparkMarkers.push(marker);        
}                
}

//주차장 마커들의 지도 표시 여부를 설정하는 함수입니다
function setCarparkMarkers(map) {        
for (var i = 0; i < carparkMarkers.length; i++) {  
    carparkMarkers[i].setMap(map);
}        
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