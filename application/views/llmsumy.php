<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="/assets/css/base.css" type="text/css">
    <script type="text/javascript" src="/assets/js/jquery-3.4.1.min.js"></script>
    <script type="text/javascript" src="/assets/js/jquery-ui.min.js"></script>
    <script src="/assets/plugins/gsap/gsap.min.js" type="text/javascript"></script>
    <!-- daterange picker -->
	<link rel="stylesheet" href="/assets/plugins/daterange/daterangepicker.min.css">
    <script src="/assets/plugins/daterange/moment.js"></script>
	<script src="/assets/plugins/daterange/jquery.daterangepicker.js"></script>
    <!-- swiper slider -->
    <link rel="stylesheet" type="text/css" href="/assets/plugins/swiper/swiper.min.css">
    <script type="text/javascript" src="/assets/plugins/swiper/swiper.min.js"></script>
    <!-- Highcharts -->
    <script src="https://code.highcharts.com/highcharts.js"></script>
    <script src="https://code.highcharts.com/highcharts-more.js"></script>
    <script src="https://code.highcharts.com/modules/dumbbell.js"></script>

    <script src="https://code.highcharts.com/modules/lollipop.js"></script>
    <script src="https://code.highcharts.com/modules/drilldown.js"></script>
    <script src="https://code.highcharts.com/highcharts-3d.js"></script>
    
    <script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
    <script src="https://code.highcharts.com/modules/variable-pie.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <link rel="stylesheet" href="/assets/css/page.css" type="text/css">
    <style>
        .main_notice_today .table_srch_box .ipt_group:first-child{margin-left:0;}
        .main_notice_today .table_srch_box .ipt_group .ipt_txt{margin-right:0;}
        .main_notice_today .table_srch_box.frst_box .ipt_group .input{width:calc(100% - 170px)}
        .table_srch_box{flex-wrap:wrap;gap:10px;}
        .table_srch_box .ipt_group{flex-wrap:wrap;gap:20px;width:100%;}
        .table_srch_box .ipt_group > .ipt_txt{width:150px;}
        .table_srch_box .ipt_group .f_list{display:grid;gap:20px;width:calc(100% - 195px);grid-template-columns:repeat(4,1fr)}
        .table_srch_box .ipt_group .f_list > div{display:flex;}
        .table_srch_box .ipt_group .f_list > div .ipt_txt{margin-left:20px;flex-shrink:0}
        .table_srch_box .ipt_group .f_list input{width:auto !important;height:auto !important;}
        #srchGonsiCorp{display:block;margin:0 auto;}
    </style>
</head>
<body>
    <div id="etoday" class="mainpage">
        <header class="headerWrap">
            <div class="header_contents_wrap">
                <h1 class="logo"><a href="/">이투데이</a></h1>
                <p class="header_desc">공시자료 기반 실시간 기업지배구조 AI분석</p>
            </div>
        </header>
        <main class="contents">
            <section class="main_notice_today">
                <div class="container">
                    <h3>AI 요약 Prompt Test</h3>
                    <form id="frm_llmsumy" name="frm_llmsumy">
                        <div class="table_srch_box frst_box">
                            <div class="ipt_group">
                                <span class="ipt_txt">System Prompt:</span>
                                <input type="text" id="pro_system" name="pro_system" class="input md" placeholder="모델의 성격(Persona), 말투, 규칙을 정의해 주세요.">
                            </div>
                            <div class="ipt_group">
                                <span class="ipt_txt">user Prompt:</span>
                                <input type="text" id="pro_user" name="pro_user" class="input md" placeholder="요청을 입력해주세요.">
                            </div>
                            <div class="ipt_group">
                                <span class="ipt_txt">원본 문서 코드:</span>
                                <input type="text" id="rce_no" name="rce_no" class="input md" placeholder="문서 원본 번호를 입력해주세요.">
                            </div>
                        </div>                        
                    </form>
                    <button type="button" id="srchGonsiCorp" class="btn btn_solid" onclick="get_summy();">요약</button>                        
                </div>
            </section>
            <section class="main_notice_today">
                <div class="container">
                    <div class="table_srch_box">
                        <div class="ipt_group">
                            <span class="ipt_txt">요약결과</span>
                        </div>
                    </div>      
                    <div class="table_srch_box">
                        <div class="ipt_group" id="llm_sumy_area">

                        </div>
                    </div>                   
                </div>
            </section>
            
        </main>
        <footer class="footer">
            <div class="container">
                <div class="f_m_group">
                    <ul>
                        <li><a href="https://company.etoday.co.kr/" class="click-trc" data-name="main_ft_company" target="_blank">회사소개</a></li>
                        <li><a href="javascript:;" onclick="footer_popup('tab01')" class="click-trc" data-name="main_ft_policy_1">이용약관</a></li>
                        <li class="f_point"><a href="javascript:;" onclick="footer_popup('tab02')" class="click-trc" data-name="main_ft_policy_2">개인정보처리방침</a></li>
                        <li><a href="javascript:;" onclick="footer_popup('tab03')" class="click-trc" data-name="main_ft_policy_3">청소년보호정책</a></li>
                        <li><a href="javascript:;" onclick="footer_popup('tab04')" class="click-trc" data-name="main_ft_policy_4">고충처리</a></li>
                        <li><a href="https://company.etoday.co.kr/company_info/location" class="click-trc" data-name="main_ft_location" target="_blank">이용문의</a></li>
                        <li><a href="https://member.etoday.co.kr/subs/" class="click-trc" data-name="main_ft_subscribe" target="_blank">신문/PDF 구독</a></li>
                        <li><a href="https://www.etoday.co.kr/rss/" class="click-trc" data-name="main_ft_rss">RSS<span class="rss_ico img_element"></span></a></li>
                        <li><a href="https://www.etoday.co.kr/sitemap/" class="click-trc" data-name="main_ft_sitemap">사이트맵</a></li>
                    </ul>
                    <div class="f_share_icons">
                        <a href="https://www.youtube.com/user/etodaycokr" class="sns_youtube" target="_blank"></a>
                        <a href="https://tv.naver.com/etoday" class="sns_navertv" target="_blank"></a>
                        <a href="https://tv.kakao.com/channel/2882570/video" class="sns_kakaotv" target="_blank"></a>
                        <a href="https://www.facebook.com/etoday/" class="sns_facebook" target="_blank"></a>
                        <a href="https://blog.naver.com/etoday12" class="sns_naverblog" target="_blank"></a>
                        <a href="https://twitter.com/etodaynews" class="sns_x"target="_blank"></a>
                        <a href="https://www.instagram.com/etoday_newsplus/" class="sns_instagram" target="_blank"></a>                                                   
                    </div>
                </div>
                <div class="foot_info">
                    <p><span><strong>이투데이 (제호 : 이투데이)</strong> 서울시 강남구 강남대로 556 이투데이빌딩</span><span>TEL 02-799-2600</span></p>
                    <p><span>등록번호 : 서울아00197</span><span>등록일자 : 2006.04.27</span><span>발행일자 : 2006.04.27</span><span>발행인 : 김상우</span><span>편집인 : 이종재</span><span>청소년보호책임자 : 이초희</span></p>
                    <p class="copyright">Copyright 2025. 이투데이. All rights reserved.</p>
                </div>
            </div>
        </footer>
        <div class="loader_wrap"><div class="loader"></div></div>

<script>
function get_summy(){
	$.ajax({ 
		url : "/llmsumy/make/", 
		type: "post", 
		data: $("#frm_llmsumy").serialize(),
		dataType:"json", 
		success : function(data) {
            if(data.ok==true){
                $("#llm_sumy_area").html(data.summary[0].content[0].text);
            }else{
                $("#llm_sumy_area").html(data.summary);
            }
		}, 
		error: function(xhr, Status, error) { 
			console.log(xhr.responseText); 
		} 
	});
}    
</script>

</body>
</html>