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
    <script src="https://code.highcharts.com/stock/highstock.js"></script>
    <script src="https://code.highcharts.com/highcharts-more.js"></script>
    <script src="https://code.highcharts.com/modules/solid-gauge.js"></script>
    <script src="https://code.highcharts.com/modules/variable-pie.js"></script>
    <script src="https://code.highcharts.com/modules/accessibility.js"></script>

    <link rel="stylesheet" href="/assets/css/page.css" type="text/css">
</head>
<body>
    <div id="etoday" class="detailpage">
        <header class="headerWrap">
            <div class="header_contents_wrap">
                <h1 class="logo"><a href="index.html">이투데이</a></h1>
                <p class="header_desc">공시자료 기반 실시간 기업지배구조 AI분석</p>

                <nav class="nav">
                    <ul class="menu">
                        <li><a href="/">HOME</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_top');$et.removeClass('openmenu');return false;">TOP</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_map_wrap');$et.removeClass('openmenu');return false;">지배구조</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_add');$et.removeClass('openmenu');return false;">주가정보</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_majorshareholder');$et.removeClass('openmenu');return false;">대주주 변동 내역</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_relatedparty');$et.removeClass('openmenu');return false;">대주주 변동 내역</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_news');$et.removeClass('openmenu');return false;">최신 종목 뉴스</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_notice_today');$et.removeClass('openmenu');return false;">최신 종목 뉴스</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_finance_item');$et.removeClass('openmenu');return false;">공시 안내</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_finance_item');$et.removeClass('openmenu');return false;">매출 및 영업이익</a></li>
                    </ul>
                </nav>

                <div class="btn btn_menu"><div class="mbar"></div></div>
            </div>
        </header>
        <main class="errorpage">
            <div class="inner">
                <div class="tit"><img src="../images/icon/error.png" alt="page not found"></div>
                <div class="desc">존재하지 않는 주소를 입력하셨거나,<br>요청하신 페이지의 주소가 변경, 삭제되어 찾을 수 없습니다.</div>
                <a href="/" class="btn_main">메인으로</a>
            </div>
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

        <div class="modal modal_corpInfo">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <div class="modal_header">
                        <h5>기업개황정보</h5>
                        <a href="#" class="btn_modal_close" onclick="modal.close('corpInfo');return false;">닫기</a>
                    </div>
                    <div class="modal_contents">
                        <div class="table_wrap">
                            <table class="table table_left">
                                <tr>
                                    <th>회사이름</th>
                                    <td>(주)엘지씨엔에스</td>
                                </tr>
                                <tr>
                                    <th>영문명</th>
                                    <td>LG CNS Co., Ltd.</td>
                                </tr>
                                <tr>
                                    <th>공시회사명</th>
                                    <td>LG씨엔에스</td>
                                </tr>
                                <tr>
                                    <th>종목코드</th>
                                    <td>064400</td>
                                </tr>
                                <tr>
                                    <th>대표자명</th>
                                    <td>현신균</td>
                                </tr>
                                <tr>
                                    <th>법인구분</th>
                                    <td>유가증권시장</td>
                                </tr>
                                <tr>
                                    <th>법인등록번호</th>
                                    <td>110111-0516695</td>
                                </tr>
                                <tr>
                                    <th>사업자등록번호</th>
                                    <td>116-81-19477</td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td>서울특별시 강서구 마곡중앙8로 71</td>
                                </tr>
                                <tr>
                                    <th>홈페이지</th>
                                    <td>www.lgcns.com</td>
                                </tr>
                                <tr>
                                    <th>IR홈페이지</th>
                                    <td>-</td>
                                </tr>
                                <tr>
                                    <th>전화번호</th>
                                    <td>02-3773-1114</td>
                                </tr>
                                <tr>
                                    <th>팩스번호</th>
                                    <td>02-2099-0099</td>
                                </tr>
                                <tr>
                                    <th>업종명</th>
                                    <td>컴퓨터시스템 통합 자문 및 구축 서비스업</td>
                                </tr>
                                <tr>
                                    <th>설립일</th>
                                    <td>1987.01.14</td>
                                </tr>
                                <tr>
                                    <th>결산월</th>
                                    <td>12월</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal modal_otrCprInvstmnt">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <div class="modal_header">
                        <h5>엘지씨엔에스 타법인 출자 현황</h5>
                        <a href="#" class="btn_modal_close" onclick="modal.close('otrCprInvstmnt');return false;">닫기</a>
                    </div>
                    <div class="modal_contents">
                        <div class="table_wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>법인명</th>
                                        <th>최초취득일자</th>
                                        <th>출자목적</th>
                                        <th>기말잔액(수량)</th>
                                        <th>기말잔액(지분율)</th>
                                        <th>기말잔액(장부가액)</th>
                                        <th>최근사업연도 재무현황<br>(총자산)</th>
                                        <th>최근사업연도 재무현황<br>(당기순이익)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>㈜비즈테크아이</td>
                                        <td>2007.08.23</td>
                                        <td>경영참여</td>
                                        <td>10,375,721</td>
                                        <td>96.09</td>
                                        <td>10,015,000,000</td>
                                        <td>90,093,000,000</td>
                                        <td>8,781,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>㈜행복마루</td>
                                        <td>2016.09.07</td>
                                        <td>경영참여</td>
                                        <td>140,000</td>
                                        <td>100.00</td>
                                        <td>700,000,000</td>
                                        <td>3,263,000,000</td>
                                        <td>413,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>㈜오픈소스컨설팅 (*5)</td>
                                        <td>2019.07.01</td>
                                        <td>경영참여</td>
                                        <td>244,292</td>
                                        <td>73.06</td>
                                        <td>7,922,000,000</td>
                                        <td>13,690,000,000</td>
                                        <td>-619,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>㈜라이트브레인 (*5)</td>
                                        <td>2021.12.10</td>
                                        <td>경영참여</td>
                                        <td>204,300</td>
                                        <td>61.91</td>
                                        <td>5,407,000,000</td>
                                        <td>10,889,000,000</td>
                                        <td>36,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>㈜비즈테크온</td>
                                        <td>2022.07.01</td>
                                        <td>경영참여</td>
                                        <td>2,158,849</td>
                                        <td>96.09</td>
                                        <td>2,084,000,000</td>
                                        <td>16,320,000,000</td>
                                        <td>1,903,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>(주)지티이노비젼 (*2)</td>
                                        <td>2024.03.07</td>
                                        <td>경영참여</td>
                                        <td>45,800</td>
                                        <td>55.05</td>
                                        <td>5,953,000,000</td>
                                        <td>11,977,000,000</td>
                                        <td>92,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>LG CNS China Inc.</td>
                                        <td>2001.04.01</td>
                                        <td>경영참여</td>
                                        <td>-</td>
                                        <td>100.00</td>
                                        <td>23,232,000,000</td>
                                        <td>93,425,000,000</td>
                                        <td>14,792,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>LG CNS America, Inc.</td>
                                        <td>2003.07.01</td>
                                        <td>경영참여</td>
                                        <td>100</td>
                                        <td>100.00</td>
                                        <td>2,883,000,000</td>
                                        <td>270,702,000,000</td>
                                        <td>34,396,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>LG CNS Europe B.V.</td>
                                        <td>2003.03.01</td>
                                        <td>경영참여</td>
                                        <td>5,000</td>
                                        <td>100.00</td>
                                        <td>3,657,000,000</td>
                                        <td>55,572,000,000</td>
                                        <td>3,733,000,000</td>
                                    </tr>
                                    <tr>
                                        <td>PT. LG CNS Indonesia</td>
                                        <td>2005.12.01</td>
                                        <td>경영참여</td>
                                        <td>20,000</td>
                                        <td>100.00</td>
                                        <td>-</td>
                                        <td>22,933,000,000</td>
                                        <td>-350,000,000</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="/assets/js/page.js"></script>
</body>
</html>