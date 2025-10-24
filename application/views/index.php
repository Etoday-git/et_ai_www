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
</head>
<body>
    <div id="etoday" class="mainpage">
        <header class="headerWrap">
            <div class="header_contents_wrap">
                <h1 class="logo"><a href="/">이투데이</a></h1>
                <p class="header_desc">공시자료 기반 실시간 기업지배구조 AI분석</p>

                <nav class="nav">
                    <ul class="menu">
                        <li><a href="#" onclick="scrollToElement('.mainpage');$et.removeClass('openmenu');return false;">TOP</a></li>
                        <li><a href="#" onclick="scrollToElement('.main_dashboard');$et.removeClass('openmenu');return false;">대시보드 요약</a></li>
                        <li><a href="#" onclick="scrollToElement('.main_notice_today');$et.removeClass('openmenu');return false;">오늘의 공시</a></li>
                        <li><a href="#" onclick="scrollToElement('.main_ranking');$et.removeClass('openmenu');return false;">기업 랭킹 분석</a></li>
                        <li class="guide"><a href="#" onclick="modal.open('guide');guideSwiper.update();$et.removeClass('openmenu');return false;">사용방법 안내</a></li>
                        <li class="pcguide"><a href="#" onclick="modal.open('pcguide');pcguideSwiper.update();$et.removeClass('openmenu');return false;">사용방법 안내</a></li>
                    </ul>
                </nav>

                <div class="btn btn_menu"><div class="mbar"></div></div>
            </div>
        </header>
        <main class="contents">
            <section class="showcase">
                <div class="viewbox">
                    <div class="srch_box">
                        <div class="srch_wrap">
                            <div class="srch_ipt_wrap">
                                <input type="text" class="input" placeholder="기업명을 입력해 주세요">
                            </div>
                            <div class="atcmp_container">
                                <ul class="atcmp_list" style="display: none;"></ul>
                                <div class="atcmp_foot">
                                    <a href="#" class="btn_close">닫기</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="main_show_swiper swiper_container highver">
                        <div class="swiper-wrapper">
                            <!-- <div class="swiper-slide"></div>  -->
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <div class="swiper-pagination"></div>
                    </div>
                    <script></script>
                    <div class="bot_btn_wrap">
                    <a href="#" id="CorpInfoShowAll" class="btn btn_rounded">지배 구조 전체보기</a>
                    <a href="#" id="OtrCprInvstmnt" class="btn btn_rounded" onclick="modal.open('otrCprInvstmnt'); corpCrossOwnership(); return false;">타법인 출자 현황 보기</a>
                    </div>
                    <div class="scrollani" onclick=" window.scrollBy({top: window.innerHeight,behavior: 'smooth'});"><div class="arrow"></div><div class="arrow"></div></div>
                </div>
            </section>
            
            <section class="main_notice_today">
                <div class="container">
                    <h3>오늘의 공시</h3>
                    <div class="table_srch_box">
                        <div class="ipt_group">
                            <span class="ipt_txt">검색어</span>
                            <input type="text" id="gsSearchWord" class="input md">
                        </div>
                        
                        <div class="ipt_group">
                            <span class="ipt_txt">기간</span>
                            <div class="datepicker_wrap">
                                <input type="text" id="gsBgnDe" class="input datepicker datepicker1">
                                <div class="sel_layPop">
                                    <div class="datepicker_wrap">
                                        <div id="date-range"></div>
                                        <button class="btn_close bg" onclick="$(this).closest('.sel_layPop').removeClass('active')"><span class="blind">닫기</span></button>
                                    </div>
                                </div>
                            </div>
                            <div class="unit">~</div>
                            <div class="datepicker_wrap">
                                <input type="text" id="gsEndDe" class="input datepicker datepicker2">
                                <div class="sel_layPop">
                                    <div class="datepicker_wrap">
                                        <div id="date-range2"></div>
                                        <button class="btn_close bg" onclick="$(this).closest('.sel_layPop').removeClass('active')"><span class="blind">닫기</span></button>
                                    </div>
                                </div>
                            </div>
                            
                        </div>
                        <button type="button" id="srchGonsiCorp" class="btn btn_solid">검색</button>
                        <Script> 
                        </Script>
                    </div>

                    <table id="gsCorpTb" class="table">
                        <thead>
                            <tr>
                                <th scope="col">번호</th>
                                <th scope="col">회사명</th>
                                <th scope="col">보고서명</th>
                                <th scope="col">AI요약</th>
                                <th scope="col">주식시장</th>
                                <th scope="col">제출인</th>
                                <th scope="col">접수일자</th>
                            </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                    <div id="pagination" class="paging"></div>
                </div>
            </section>

            <section class="main_dashboard">
                <div class="container">
                    <div class="mdashSwiper">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                            </div>
                        </div>
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <script>
                            
                        </script>                        
                    </div>
                </div>
            </section>
            
            <section class="main_ranking">
                <div class="container">
                    <h3>기업 랭킹분석</h3>
                    <div class="top_rank_scroll">
                        <div class="top_rank_wrap">
                            <div id="PureProfitRank" class="top_rank" onclick="modal.open('pureProfitRank');">
                                <div class="rank_title">2024년 매출액이 많은 TOP 10 기업</div>
                                <div class="list_header">
                                    <div class="sm">단위:억원</div>
                                </div>
                                <ul id="profitRank" class="rank_list">
                                </ul>
                            </div>
                            <div id="netIncomeRank" class="top_rank" onclick="modal.open('incomeRank');">
                                <div class="rank_title">2024년 당기순이익이 높은 TOP 10 기업</div>
                                <div class="list_header">
                                    <div class="sm">단위:억원</div>
                                </div>
                                <ul id="topNetIncomeRank" class="rank_list">
                                </ul>
                            </div>
                        </div>
                        <script>
                            
                        </script>
                    </div>
                    <div class="bot_rank_wrap rankswiper">
                        <div class="swiper-container">
                            <div class="swiper-wrapper">
                                <div id="selfStockRank" class="swiper-slide" onclick="modal.open('selfStockRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 보통주 자기주식 취득 수량 TOP 10</div>
                                    <div class="graph">
                                        <div id="chart1" class="chart"></div>
                                    </div>
                                </div>
                                <div id="minorShareholdersRank" class="swiper-slide" onclick="modal.open('minorShareholdersRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 소액주주의 주식 소유 비율이 높은 10개 기업은?</div>
                                    <div class="graph">
                                        <div id="chart2" class="chart"></div>
                                    </div>
                                </div>
                                <div id="ListedSubsidiariesRank" class="swiper-slide" onclick="modal.open('listedSubsidiariesRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 상장자회사 수가 많은 기업 TOP 10</div>
                                    <div class="graph">
                                        <div id="chart3" class="chart"></div>
                                    </div>
                                </div>
                                <div id="majorOwnershipRank" class="swiper-slide" onclick="modal.open('majorOwnershipRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 최대주주와 특수관계인의 지분율이 높은 기업 TOP 10</div>
                                    <div class="graph">
                                        <div id="chart4" class="chart"></div>
                                    </div>
                                </div>
                                <div id="bonusIssueRank" class="swiper-slide" onclick="modal.open('bonusIssueRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 보통주 무상증자 금액이 많은 기업 TOP 10</div>
                                    <div class="graph">
                                        <div id="chart5" class="chart"></div>
                                    </div>
                                </div>
                                <div id="npsInvestedCompaniesRank" class="swiper-slide" onclick="modal.open('npsInvestedCompaniesRank');">
                                    <div class="date"></div>
                                    <div class="tit">2024년 국민연금의 지분율이 높은 기업 TOP 10</div>
                                    <div class="graph">
                                        <div id="chart6" class="chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Add Arrows -->
                        <div class="swiper-button-next"></div>
                        <div class="swiper-button-prev"></div>
                        <script src="https://d3js.org/d3.v7.min.js"></script>
                        <script>
                            /* highcharts */
                            const commonOptions = {
                                chart: {
                                    backgroundColor: 'transparent',
                                    plotBackgroundColor: 'transparent'
                                },
                                xAxis: {
                                    title: { text: null },
                                    labels: {
                                        style: {
                                            color: 'rgba(255,255,255,.6)',
                                            fontSize: '12px'
                                        }
                                    },
                                    lineColor: 'rgba(255, 255, 255, 0.2)',
                                    lineWidth: 2
                                },
                                yAxis: {
                                    title: { text: null },
                                    gridLineColor: 'rgba(255, 255, 255, 0.2)', // 그리드선 색
                                    gridLineWidth: 1,                           // 두께
                                    labels: {
                                        style: {
                                            color: 'rgba(255,255,255,.6)',
                                            fontSize: '12px'
                                        }
                                    }
                                },
                                legend: { enabled: false }
                            };
                            var rankSwiper =  new Swiper('.rankswiper .swiper-container', {
                                slidesPerView:4,
                                spaceBetween:0,
                                navigation: {
                                    nextEl: '.rankswiper .swiper-button-next',
                                    prevEl: '.rankswiper .swiper-button-prev'
                                },
                                breakpoints: {
                                    600: {
                                        slidesPerView:1,
                                    },
                                    1024:{
                                        slidesPerView:2,
                                    }
                                },
                                on: {
                                    slideChangeTransitionEnd: function () {
                                        reflowVisibleCharts(this);
                                    }
                                },
                            })
                        </script>
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
                                        <img src="/images/guide/img1.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img2.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img3.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/img4.png" alt="">
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
                                        <img src="/images/guide/pc1.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc2.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc3.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc4.png" alt="">
                                    </div>
                                    <div class="swiper-slide">
                                        <img src="/images/guide/pc5.png" alt="">
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

<!-- 자기주식취득 모달 -->
<div class="modal modal_rank modal_selfStockRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('selfStockRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 보통주 자기주식 취득 수량이 높은 10개 기업은?</div>
                    <div class="sm">단위:주</div>
                </div>
                <div class="chart">
                    <div id="inSelfStockRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>자기주식취득금액</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 소액주주비율 모달 -->
<div class="modal modal_rank modal_minorShareholdersRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('minorShareholdersRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 소액주주의 주식 소유 비율이 높은 10개 기업은?</div>
                    <div class="sm">단위:%</div>
                </div>
                <div class="chart">
                    <div id="inMinorShareholdersRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>소액주주의 주식 소유 비율(%)</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 상장자회사수 모달 -->
<div class="modal modal_rank modal_listedSubsidiariesRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('listedSubsidiariesRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 상장 자회사 수가 많은 기업집단 10개는?</div>
                    <div class="sm">단위:개</div>
                </div>
                <div class="chart">
                    <div id="inListedSubsidiariesRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업집단</th>
                                <th>상장자회사 수</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 최대 주주와 특수 관계인 지분율 모달 -->
<div class="modal modal_rank modal_majorOwnershipRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('majorOwnershipRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 최대주주와 특수관계인의 지분율이 높은 기업 TOP 10</div>
                    <div class="sm">단위:%</div>
                </div>
                <div class="chart">
                    <div id="inMajorOwnershipRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>최대주주와 특수관계인의 지분율(%)</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 보통주 무상증자 금액이 많은 기업 TOP 10 모달 -->
<div class="modal modal_rank modal_bonusIssueRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('bonusIssueRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 보통주 무상증자 금액이 많은 기업 TOP10</div>
                    <div class="sm">단위:원</div>
                </div>
                <div class="chart">
                    <div id="inBonusIssueRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>무상증자금액</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 국민연금 출자 순위 TOP 10 모달 -->
<div class="modal modal_rank modal_npsInvestedCompaniesRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('npsInvestedCompaniesRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 국민연금의 지분율이 높은 기업 TOP 10</div>
                    <div class="sm">단위:%</div>
                </div>
                <div class="chart">
                    <div id="inNpsInvestedCompaniesRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>국민연금 지분율</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 정규직 근로자 수 TOP 10 모달 -->
<div class="modal modal_rank modal_permanentEmployeeRank">
    <div class="modal_wrap">
        <div class="modal_inner">
            <div class="modal_header">
                <h5>기업 랭킹 분석</h5>
                <a href="#" class="btn_modal_close" onclick="modal.close('permanentEmployeeRank');return false;">닫기</a>
            </div>
            <div class="modal_contents">
                <div class="rank_header">
                    <div class="rank_title">2024년 정규직 근로자 수가 많은 기업 TOP 10</div>
                    <div class="sm">단위:명</div>
                </div>
                <div class="chart">
                    <div id="inPermanentEmployeeRank"></div>                    
                </div>
                <div class="table_wrap">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>순위</th>
                                <th>기업명</th>
                                <th>정규직 근로자 수</th>
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
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal modal_moreInfo">
    <div class="modal_wrap">
        <div class="modal_box">
            <div class="modal_contents">
                <div class="sorttxt"></div>
                <div class="name"></div>
                <div class="data"></div>
            </div>
            <a href="#" class="btn_modal_close" onclick="modal.close('moreInfo');return false;">닫기</a>
        </div>
    </div>
</div>
<script src="/assets/js/page.js"></script>
<script src="/assets/js/index.js"></script>
</body>
</html>