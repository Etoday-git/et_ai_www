<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이투데이-공시자료 기반 실시간 기업지배구조 AI 분석</title>

    <link rel="shortcut icon" href="/favicon.ico">    
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
                <h1 class="logo"><a href="/">이투데이</a></h1>
                <p class="header_desc">공시자료 기반 실시간 기업지배구조 AI분석</p>

                <nav class="nav">
                    <ul class="menu">
                        <li><a href="/">HOME</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_top');$et.removeClass('openmenu');return false;">TOP</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_map_wrap');$et.removeClass('openmenu');return false;">지배구조</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_add');$et.removeClass('openmenu');return false;">주가정보</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_majorshareholder');$et.removeClass('openmenu');return false;">대주주 변동 내역</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_news');$et.removeClass('openmenu');return false;">최신 종목 뉴스</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_notice_today');$et.removeClass('openmenu');return false;">공시 안내</a></li>
                        <li><a href="#" onclick="scrollToElement('.detail_finance_item');$et.removeClass('openmenu');return false;">매출 및 영업이익</a></li>
                        <li class="guide"><a href="#" onclick="modal.open('guide');guideSwiper.update();$et.removeClass('openmenu');return false;">사용방법 안내</a></li>
                        <li class="pcguide"><a href="#" onclick="modal.open('pcguide');pcguideSwiper.update();$et.removeClass('openmenu');return false;">사용방법 안내</a></li>
                    </ul>
                </nav>

                <div class="btn btn_menu"><div class="mbar"></div></div>
            </div>
        </header>
        <main class="contents">
            <section class="detail_top">
                <div class="container">
                    <h2><div id="corp_name" class="name"><a href="#" class="btn_srch"></a></div></h2>
                    <input type="hidden" id="stk_id" data-corp-stkid="">
                    <div class="srch_box">
                        <div class="srch_wrap">
                            <div class="srch_ipt_wrap">
                            <input type="text" class="input" placeholder="기업명을 입력해 주세요">
                            <!-- <button type="button" class="btn_srch">검색</button> -->
                            </div>
                            <div class="atcmp_container">
                                <ul class="atcmp_list">
                                    <li><strong>기업명</strong>을 입력해주세요.</li>
                                </ul>
                                <div class="atcmp_foot">
                                    <a href="#" class="btn_close">닫기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="corp_box_wrap">
                        <div class="top_btn_wrap">
                            <!-- <a href="#" class="btn btn_rounded" onclick="modal.open('corpInfo');return false;">기업개황정보</a> -->
                            <a href="#" class="btn btn_rounded" data-modal="corpInfo">기업개황정보</a>
                        </div>
                        <div class="corp_box">
                            <div class="col">
                                <dl>
                                    <dt>대표이사</dt>
                                    <dd class="ceo"></dd>
                                    <dt>임원현황</dt>
                                    <dd class="executives_list">
                                        <div class="inner">
                                            <div class="inbar deungi" data-val="">
                                                <div class="txt"></div>
                                                <div class="bar malebar" data-val=""></div>
                                                <div class="bar femalebar" data-val=""></div>
                                            </div>
                                        </div>
                                        <div class="inner">
                                            <div class="inbar mideungi"  data-val="">
                                                <div class="txt"></div>
                                                <div class="bar malebar" data-val=""></div>
                                                <div class="bar femalebar" data-val=""></div>
                                            </div>
                                        </div>
                                        <ul class="executives_list_ul">
                                            <li> <div class="date"></div></li>
                                            <li> <div class="date"></div></li>
                                            <li> <div class="date"></div></li>
                                        </ul>
                                    </dd>
                                </dl>                                
                            </div>
                            <div class="col">
                                <dl>
                                    <dt>최대주주&amp;<br>특수관계인</dt>
                                    <dd class="chart_wrap">
                                        <div id="topChart"></div>
                                        <div class="info_wrap">
                                            <ul>
                                            </ul>
                                        </div>
                                    </dd>
                                </dl>
                            </div>
                        </div>
                    </div>                    
                </div>
            </section>
            <section class="detail_map_wrap">
                <div class="container">
                    <div class="top_btn_wrap">
                        <a href="#" class="btn btn_rounded">지배 구조 전체보기</a>
                        <a href="#" class="btn btn_rounded" data-modal="otrCprInvstmnt">타법인 출자 현황 보기</a>
                    </div>

                    <div class="detail_map">
                        <div class="map_header_wrap">
                            <div class="map_header_inner">
                                <h4 class="map_corp">
                                    <div class="sort gr"><div class="tooltip"></div></div>
                                    <div class="name"></div>
                                </h4>
                                <div class="header_col">
                                    <div class="map_header">
                                        주주 구성
                                        <div class="date"></div>
                                    </div>
                                </div>
                                <div class="header_col">
                                    <div class="map_header">
                                        투자회사 분석
                                        <div class="date"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="list_wrap">
                            <div class="map_list left">
                                <div class="cell_wrap">
                                    <div class="vbar"></div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                </div>
                            </div>
                            <div class="map_list right">
                                <div class="cell_wrap">
                                    <div class="vbar"></div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>                                    
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                    <div class="cell">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="btn_wrap">
                        <a href="#" class="btn_more">더보기</a>
                    </div>                    
                </div>
            </section>
            <section class="detail_add">
                <div class="container">
                    <h3>주가정보<span class="date"></span></h3>
                    <div class="stock_info_box">
                        <div class="info_box">
                            <div class="sort_wrap">
                                <span class="badge"></span>
                                <span class="badge"></span>
                            </div>
                            <div class="name"></div>
                            <div class="rate_info up">
                                <div class="today"><span></span></div>
                                <div class="no_exday">
                                    <span class="txt">전일대비</span>
                                    <span class="point"><span></span></span>
                                    <span class="txt">등락률</span>
                                    <span class="point"></span>
                                </div>     
                                <div class="add_info col">
                                    <span class="txt">전일</span>
                                    <span class="point YESTERDAY_ENDPRICE"></span>
                                    <span class="txt">시가</span>
                                    <span class="point MARKET_PRICE"></span>
                                    <span class="txt">고가</span>
                                    <span class="point up HIGH_PRICE"></span>
                                    <span class="txt">저가</span>
                                    <span class="point down LOW_PRICE"></span>
                                </div>
                                <div class="add_info">
                                    <span class="txt">거래량</span>
                                    <span class="point ACCUMULATED_DEALING_AMOUNT"></span>
                                    <span class="txt">거래대금(백만)</span>
                                    <span class="point ACCUMULATED_DEALING_PRICE"></span>
                                </div>                                  
                            </div>
                        </div>
                        <div class="graph_box">
                            <div class="chart">
                                <p class="source">한국거래소(KRX)</p>                                
                                <div id="stock-chart"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="detail_majorshareholder">
                <div class="container">
                    <h3>대주주 변동 내역</h3>
                    <div class="detail_table shareholder_table">
                        <table class="table line">
                            <thead>
                                <tr>
                                    <th scope="col" rowspan="2" class="wfull">번호</th>
                                    <th scope="col" rowspan="2" class="wfull">대표보고자</th>
                                    <th scope="col" rowspan="2" class="wfull">보고일</th>
                                    <th scope="col" colspan="4" class="whalf h4">보유주식등의 수 및 보유비율</th>
                                    <th scope="col" colspan="2" class="whalf h2">주요체결 주식등의 수 및 비율</th>
                                    <th scope="col" rowspan="2" class="wfull">보고 사유</th>
                                </tr>
                                <tr class="addth">
                                    <th scope="col" class="">주식등의 수</th>
                                    <th scope="col" class="">증감</th>
                                    <th scope="col" class="">지분율(%)</th>
                                    <th scope="col" class="">증감(%)</th>
                                    <th scope="col" class="">주식등의 수</th>
                                    <th scope="col" class="">보유비율(%)</th>
                                </tr>
                            </thead>
                            <tbody class="anomaly_detection_tbody">
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
            <section class="detail_relatedparty">
                <div class="container">
                    <h3>특수관계인 변동 내역</h3>
                    <div class="detail_table affiliated_change_table">
                        <table class="table line">
                            <thead>
                                <tr>
                                    <th scope="col" rowspan="3" class="wfull">번호</th>
                                    <th scope="col" rowspan="3" class="wfull">결산기준일</th>
                                    <th scope="col" rowspan="3" class="wfull">성명</th>
                                    <th scope="col" rowspan="3" class="wfull">관계</th>
                                    <th scope="col" rowspan="3" class="wfull">주식의 종류</th>
                                    <th scope="col" colspan="4" class="wthr h4">소유주식 수 및 지분율</th>
                                    <th scope="col" rowspan="3" class="wfull">비고</th>
                                </tr>
                                <tr class="addth">
                                    <th scope="col" colspan="2" class="h2">기초</th>
                                    <th scope="col" colspan="2" class="h2">기말</th>
                                </tr>
                                <tr class="addth">
                                    <th scope="col">주식 수</th>
                                    <th scope="col">지분율(%)</th>
                                    <th scope="col">주식 수</th>
                                    <th scope="col">지분율(%)</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                </div>
            </section>
            <section class="detail_news">
                <div class="container">
                    <h3>최신 종목 뉴스</h3>
                    <div class="news_list">
                    </div>
                </div>
            </section>
            <section class="detail_notice_today">
                <div class="container">
                    <h3>공시 안내</h3>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">회사명</th>
                                <th scope="col">보고서명</th>
                                <th scope="col">AI요약</th>
                                <th scope="col">제출인</th>
                                <th scope="col">접수일자</th>
                            </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <div id="pagination" class="paging">
                        <a href="#" class="first">처음</a>
                        <a href="#" class="prev">이전</a>
                        <a href="#" class="on">1</a>
                        <a href="#" class="">2</a>
                        <a href="#" class="">3</a>
                        <a href="#" class="">4</a>
                        <a href="#" class="">5</a>
                        <a href="#" class="next">다음</a>
                        <a href="#" class="last">마지막</a>
                    </div>
                </div>
            </section>
            <section class="detail_finance_item">
                <div class="container">
                    <h3>매출액 및 영업이익</h3>
                    <div class="finance_item_wrap">
                        <div class="inner_wrap">
                            <div class="finace_item box">
                                <div class="y">2024</div>
                                <dl class="val_wrap">
                                    <dt>매출</dt>
                                    <dd data-val="59826">0</dd>
                                    <dt>영업이익</dt>
                                    <dd data-val="5129">0</dd>
                                </dl>
                            </div>
                            <div class="finace_item box">
                                <div class="y">2023</div>
                                <dl class="val_wrap">
                                    <dt>매출</dt>
                                    <dd data-val="59826">0</dd>
                                    <dt>영업이익</dt>
                                    <dd data-val="5129">0</dd>
                                </dl>
                            </div>
                            <div class="finace_item box">
                                <div class="y">2022</div>
                                <dl class="val_wrap">
                                    <dt>매출</dt>
                                    <dd data-val="59826">0</dd>
                                    <dt>영업이익</dt>
                                    <dd data-val="5129">0</dd>
                                </dl>
                            </div>
                            <div class="finace_item box">
                                <div class="y">2021</div>
                                <dl class="val_wrap">
                                    <dt>매출</dt>
                                    <dd data-val="59826">0</dd>
                                    <dt>영업이익</dt>
                                    <dd data-val="5129">0</dd>
                                </dl>
                            </div>
                            <div class="finace_item box">
                                <div class="y">2020</div>
                                <dl class="val_wrap">
                                    <dt>매출</dt>
                                    <dd data-val="59826">0</dd>
                                    <dt>영업이익</dt>
                                    <dd data-val="5129">0</dd>
                                </dl>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
            <section class="detail_rank">
                <div class="container">
                    <h3>TOP 10 랭킹 </h3>
                    <div class="top_rank_scroll">
                        <div class="top_rank_wrap">
                            <div id="PureProfitRank" class="top_rank box left" onclick="modal.open('pureProfitRank');">
                                <div class="rank_title">2024년 12월 현재 매출액 상위 10대 기업</div>
                                <div class="list_header">
                                    <div class="sm">단위:억원</div>
                                </div>
                                <ul id="profitRank" class="rank_list">
                                </ul>
                            </div>
                            <div id="netIncomeRank" class="top_rank box right" onclick="modal.open('incomeRank');">
                                <div class="rank_title">2024년 12월 현재 당기순이익 상위 10대 기업</div>
                                <div class="list_header">
                                    <div class="sm">단위:억원</div>
                                </div>
                                <ul id="topNetIncomeRank" class="rank_list">
                                </ul>
                            </div>
                        </div>
                        <script>
                            function rankDataAni(){
                                const bars = document.querySelectorAll('.detail_rank .bar');
                                bars.forEach((bar) => {
                                    const targetWidth = bar.dataset.val;
                                    gsap.to(bar, {
                                        width: targetWidth,
                                        duration: 1,
                                        ease: "power2.out",
                                        delay:.1
                                    }); 
                                });
                            }
                        </script>
                    </div>
                </div>
            </section>
            <section class="detail_ai">
                <div class="container">
                    <h3>AI분석</h3>
                    <div class="top"></div>
                    <div class="desc">
                        <div class="tit"></div>
                    </div>
                </div>
            </section>
        </main>
        <footer class="footer">
            <div class="container">
                <div class="foot_info">                    
                    <p>* 공시 원문 데이터의 누락·오류 또는 AI 분석 과정에서의 오차로 인해 일부 정보가 실제와 다를 수 있습니다.</p>
                    <p>본 서비스는 <span><img src="/images/kpf.png" alt="" />의</span> 지원을 받아 개발되었습니다. </p>
                    <p class="copyright">Copyright 2025. 이투데이. All rights reserved.</p>
                </div>
            </div>
        </footer>

        <div class="loader_wrap"><div class="loader"></div></div>

        <div class="modal modal_guide">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <a href="#" class="btn_modal_close" onclick="modal.close('guide');return false;">닫기</a>
                    <div class="modal_contents">
                        <h5>사용안내</h5>
                        <div class="guide_wrap">
                            <div class="swiper-container swiper_guide">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub1.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub2.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub3.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub4.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub5.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub6.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub7.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img_sub8.png" alt="">
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <script>
                        var guideSwiper = new Swiper('.swiper_guide', {
                            pagination: {
                                el: ".modal_guide .swiper-pagination",
                            }
                        })
                    </script>
                </div>
            </div>
        </div>

        <div class="modal modal_pcguide">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <a href="#" class="btn_modal_close" onclick="modal.close('pcguide');return false;">닫기</a>
                    <div class="modal_contents">
                        <h5>사용안내</h5>
                        <div class="guide_wrap">
                            <div class="swiper-container swiper_pcguide">
                                <div class="swiper-wrapper">
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub1.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub2.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub3.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub4.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub5.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc_sub6.png" alt="">
                                    </div>
                                </div>
                                
                            </div>
                        </div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <script>
                        var pcguideSwiper = new Swiper('.swiper_pcguide', {
                            pagination: {
                                el: ".modal_pcguide .swiper-pagination",
                            }
                        })
                    </script>
                </div>
            </div>
        </div>

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
                                    <td class="corp_name"></td>
                                </tr>
                                <tr>
                                    <th>영문명</th>
                                    <td class="corp_name_eng"></td>
                                </tr>
                                <tr>
                                    <th>공시회사명</th>
                                    <td class="stock_name"></td>
                                </tr>
                                <tr>
                                    <th>종목코드</th>
                                    <td class="stock_code"></td>
                                </tr>
                                <tr>
                                    <th>대표자명</th>
                                    <td class="ceo_nm"></td>
                                </tr>
                                <tr>
                                    <th>법인구분</th>
                                    <td class="corp_cls"></td>
                                </tr>
                                <tr>
                                    <th>법인등록번호</th>
                                    <td class="jurir_no"></td>
                                </tr>
                                <tr>
                                    <th>사업자등록번호</th>
                                    <td class="bizr_no"></td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td class="adres"></td>
                                </tr>
                                <tr>
                                    <th>홈페이지</th>
                                    <td class="hm_url"></td>
                                </tr>
                                <tr>
                                    <th>IR홈페이지</th>
                                    <td class="ir_url"></td>
                                </tr>
                                <tr>
                                    <th>전화번호</th>
                                    <td class="phn_no"></td>
                                </tr>
                                <tr>
                                    <th>팩스번호</th>
                                    <td class="fax_no"></td>
                                </tr>
                                <tr>
                                    <th>업종명</th>
                                    <td class="induty_code"></td>
                                </tr>
                                <tr>
                                    <th>설립일</th>
                                    <td class="est_dt"></td>
                                </tr>
                                <tr>
                                    <th>결산월</th>
                                    <td class="acc_mt"></td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <script>
            </script>
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
                                        <th class="corp_name">법인명</th>
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
                                        <td class="corp_name"></td>
                                        <td class="frst_acqs_de"></td>
                                        <td class="invstmnt_purps"></td>
                                        <td class="trmend_blce_qy"></td>
                                        <td class="trmend_blce_qota_rt"></td>
                                        <td class="trmend_blce_acntbk_amount"></td>
                                        <td class="recent_bsns_year_fnnr_sttus_tot_assets"></td>
                                        <td class="recent_bsns_year_fnnr_sttus_thstrm_ntpf"></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>                
            </div>
        </div>
        <div class="modal modal_rank modal_pureProfitRank">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <div class="modal_header">
                        <h5>기업 랭킹 분석</h5>
                        <a href="#" class="btn_modal_close" onclick="modal.close('pureProfitRank');return false;">닫기</a>
                    </div>
                    <div class="modal_contents">
                        <div class="rank_header">
                            <div class="rank_title">2024년 매출액 Top 10기업은?</div>
                            <div class="sm">단위:억원</div>
                        </div>
                        <div class="chart">
                            <div id="inProfitRank"></div>                    
                        </div>
                        <div class="table_wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>순위</th>
                                        <th>기업명</th>
                                        <th>매출액(억원)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td class="left">삼성전자</td>
                                        <td>12,923</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td class="left">sk하이닉스</td>
                                        <td>10923</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td class="left">현대자동차</td>
                                        <td>8779</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td class="left">기아</td>
                                        <td>7223</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td class="left">삼성생명</td>
                                        <td>6191</td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td class="left">한국전력공사</td>
                                        <td>5174</td>
                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td class="left">한화생명</td>
                                        <td>4132</td>
                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td class="left">미래에셋증권</td>
                                        <td>3089</td>
                                    </tr>
                                    <tr>
                                        <td>9</td>
                                        <td class="left">NH투자증권</td>
                                        <td>2067</td>
                                    </tr>
                                    <tr>
                                        <td>10</td>
                                        <td class="left">삼성증권</td>
                                        <td>1911</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal modal_rank modal_incomeRank">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <div class="modal_header">
                        <h5>기업 랭킹 분석</h5>
                        <a href="#" class="btn_modal_close" onclick="modal.close('incomeRank');return false;">닫기</a>
                    </div>
                    <div class="modal_contents">
                        <div class="rank_header">
                            <div class="rank_title">2024년 당기순이익 Top 10기업은?</div>
                            <div class="sm">단위:억원</div>
                        </div>
                        <div class="chart">
                            <div id="inIncomeRank"></div>                    
                        </div>
                        <div class="table_wrap">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th>순위</th>
                                        <th>기업명</th>
                                        <th>당기순이익(억원)</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>1</td>
                                        <td class="left">삼성전자</td>
                                        <td>12,923</td>
                                    </tr>
                                    <tr>
                                        <td>2</td>
                                        <td class="left">sk하이닉스</td>
                                        <td>10923</td>
                                    </tr>
                                    <tr>
                                        <td>3</td>
                                        <td class="left">현대자동차</td>
                                        <td>8779</td>
                                    </tr>
                                    <tr>
                                        <td>4</td>
                                        <td class="left">기아</td>
                                        <td>7223</td>
                                    </tr>
                                    <tr>
                                        <td>5</td>
                                        <td class="left">삼성생명</td>
                                        <td>6191</td>
                                    </tr>
                                    <tr>
                                        <td>6</td>
                                        <td class="left">한국전력공사</td>
                                        <td>5174</td>
                                    </tr>
                                    <tr>
                                        <td>7</td>
                                        <td class="left">한화생명</td>
                                        <td>4132</td>
                                    </tr>
                                    <tr>
                                        <td>8</td>
                                        <td class="left">미래에셋증권</td>
                                        <td>3089</td>
                                    </tr>
                                    <tr>
                                        <td>9</td>
                                        <td class="left">NH투자증권</td>
                                        <td>2067</td>
                                    </tr>
                                    <tr>
                                        <td>10</td>
                                        <td class="left">삼성증권</td>
                                        <td>1911</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- AI 요약 모달 -->
        <div class="modal modal_aiSummary">
            <div class="modal_wrap">
                <div class="modal_inner">
                    <div class="modal_header">
                        <h5>AI 요약</h5>
                        <a href="#" class="btn_modal_close" onclick="modal.close('aiSummary');return false;">닫기</a>
                    </div>
                    <div class="modal_contents">
                        <div id="summaryResult"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="/assets/js/page.js"></script>
    <script src="/assets/js/detail.js"></script>
</body>
</html>