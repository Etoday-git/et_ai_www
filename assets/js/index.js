// ============================
// 상단 검색 자동완성 기능
// ============================
// 날짜 관련
const nowDate = new Date();
const lastYear = nowDate.getFullYear() - 1;
const today = new Date(nowDate.getFullYear(), nowDate.getMonth(), nowDate.getDate(), 0, 0, 0, 0);

function toEok(val) { 
    if (val == null || val === '') return 0; 
    const num = Number(String(val).replace(/[^\d.-]/g, '')); 
    return Number.isFinite(num) ? num / 1e8 : 0; 
}

const $ipt       = $('.srch_ipt_wrap .input');
const $list      = $('.atcmp_list');
const $cont      = $('.atcmp_container');
const $main_page = $('.mainpage');

// states
let activeIndex     = -1;
let userNavigated   = false;
let lastKeyword     = '';
let reqToken        = 0;
let isInputFocused  = false;
let debounceTimer   = null;
let lastXhr         = null;
let isComposing     = false;
let selecting       = false;

function cancelPending() {
    clearTimeout(debounceTimer);
    if (lastXhr && lastXhr.readyState !== 4) lastXhr.abort();
    reqToken++;
}
function hideList() {
    $list.empty()
    $cont.hide();
}
function showList(force = false) {
    if ($et.hasClass('srchopen')) $cont.show();
}
function handlePick($a) {
    if (!$a || !$a.length) return;
    selecting = true;
  
    const corpName = $a.text();
    const corpCode = $a.data('code');
  
    if ($et.hasClass('openmenu')) {
      if (corpCode)  window.location.href = '/detail/' + corpCode;
      selecting = false;
      return;
    }
    $et.removeClass('openmenu');
    $main_page.removeClass('srchopen');
  
    $ipt.val(corpName);
    invest_info([corpCode]);
    
    hideList();
    selecting = false;    
}
function setActive(index) {
    const $items = $list.find('li');
    $items.removeClass('active');
    if (index >= 0 && index < $items.length) {
      $items.eq(index).addClass('active')[0].scrollIntoView({ block: 'nearest' });
    }
    activeIndex = index;
}

function resetActiveSafely() {
    if (userNavigated) return;  // 네비 시작 후엔 리셋 금지
    setActive(-1);
}
  
// event
$et.on('focus', '.srch_box .input', function () {
    isInputFocused = true;
    $et.addClass('srchopen');
});
$et.on('blur', '.srch_box .input', function () {
    isInputFocused = false;
    cancelPending();
    $et.removeClass('srchopen');
    hideList();
});
  
// --- IME ---
$ipt.on('compositionstart', () => { isComposing = true; });
$ipt.on('compositionend',  () => {
    isComposing = false;
    clearTimeout(debounceTimer);
    runSearch();
});

$ipt.on('input', function () {
    if (selecting) return;
    if (!isInputFocused) return;
  
    // 새 키워드 입력시 네비 상태 초기화
    userNavigated = false;  
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(runSearch, 100);
});
  
// --- run search ---
function runSearch() {
    if (!isInputFocused) return;                                    // 포커스 없으면 실행 금지
    
    const keyword = $ipt.val().trim();
    if (!keyword) { hideList(); return; }
    $et.addClass('srchopen');
    $list.show();
    if (lastXhr && lastXhr.readyState !== 4) lastXhr.abort();
    
    const myToken = ++reqToken;
    lastXhr = $.get('/api/SearchCorp', { corp_name: keyword }).done(function (json) {
        if (myToken !== reqToken) return;                       // latest only
        if (!isInputFocused) return;                            // 응답 시에도 포커스 확인
        if (keyword !== $ipt.val().trim()) return;              // 입력 바뀜
        if (userNavigated && keyword === lastKeyword) return;   // 네비 중 동일 키워드면 스킵

        if (json.status === '00' && json.DataList && json.DataList.length > 0) {
            const html = json.DataList.map(item =>
                `<li style="cursor:pointer;"><a href="#" data-code="${item.corp_code}">${item.corp_name}</a></li>`
            ).join('');
            $list.html(html);
            showList();

            if (keyword !== lastKeyword) resetActiveSafely();
        } else {
            hideList();
            if (keyword !== lastKeyword) resetActiveSafely();
        }
        lastKeyword = keyword;        
    }).fail(function (_, status) {
        if (status === 'abort') return;
        if (myToken !== reqToken) return;
        hideList();
        if (keyword !== lastKeyword) resetActiveSafely();
        lastKeyword = keyword;
    });
}

$ipt.on('keydown', function (e) {
    if (isComposing) return;
    cancelPending();
  
    const $links = $list.find('a');
    if (!$links.length) return;
  
    if (e.key === 'ArrowDown') {
      e.preventDefault();
      userNavigated = true;
      const next = activeIndex < $links.length - 1 ? activeIndex + 1 : 0;
      setActive(next);
    } else if (e.key === 'ArrowUp') {
      e.preventDefault();
      userNavigated = true;
      const prev = activeIndex > 0 ? activeIndex - 1 : $links.length - 1;
      setActive(prev);
    } else if (e.key === 'Enter') {
      if (activeIndex >= 0) {
        e.preventDefault();
        handlePick($links.eq(activeIndex));
      }
    } else if (e.key === 'Escape') {
      hideList();
      setActive(-1);
      userNavigated = false;
    }
});
  
// --- click pick --
$list.on('mousedown', 'a, li', function (e) {
    e.preventDefault();
    e.stopPropagation();
    cancelPending();
    const $target = $(e.target).is('a') ? $(e.target) : $(this).find('a').first();
    handlePick($target);
  
    return false;
});

// ============================
// 지배구조그래프
// ============================
// 매핑 & 단위변환
const clsMap = {
    Y:{label:"유",tooltip:"유가증권시장",class:"gr", full:"유가증권시장"},
    K:{label:"코",tooltip:"코스닥시장",  class:"pp", full:"코스닥시장"},
    N:{label:"넥",tooltip:"코넥스시장",  class:"bl", full:"코넥스시장"},
};

function HTMLByCode(code){
    const map = clsMap[String(code || '').toUpperCase()];
    if (!map) return '';
    return `<div class="sort ${map.class}">${map.label}<div class="tooltip">${map.tooltip}</div></div>`;
}

const fmtAmountToBaekman = v => {
    if (v == null || v === '') return '';
    const n = Number(String(v).replace(/[^\d.-]/g, ''));
    if (!isFinite(n)) return '';

    const inHundredMillionKRW = n / 1_000_000; // 원 → 백만원

    if (Math.abs(inHundredMillionKRW) < 1) {
        // 1 미만이면 소수점 그대로 노출
        return `${inHundredMillionKRW}백만원`;
    } else {
        // 1 이상이면 소수점 첫째 자리에서 반올림 → 정수
        const rounded = Math.round(inHundredMillionKRW);
        return `${rounded.toLocaleString('ko-KR')}백만원`;
    }
};

const percentToNumber = v => {
    if (v==null || v==='') return 0;
    const n = parseFloat(String(v).toString().replace('%',''));
    return isFinite(n) ? n : 0;
};
const zFromValue = v => Math.max(1, Math.min(50, percentToNumber(v)));

// 초기 5개 회사 로딩
function list_corp_code(limit) {
    return $.ajax({
      type : 'GET',
      url  : '/api/IfGovernanceGraphList',
      data : { limit },
      dataType : 'json',
      cache: true
    }).then(json => {
      const list = json?.DataList || [];
      return list.map(item => item.corp_code);
    }).catch(err => {
      console.error(err);
      return [];
    });
}

// 주주(왼),투자회사(오) 그래프 헤더 템플릿
function slideChartHTML(item, idx) {
    const headBadge = HTMLByCode(item.corp_cls);
    const anyRcept = item?.in?.[0]?.rcept_no || item?.out?.[0]?.rcept_no || '';
    // 대주주 수
    const leftTopCount = (item.in || []).filter(
        r => (r.holder_type || '').trim() === '대주주'
    ).length;
    const topCountClassName = 'c'+leftTopCount;
    const displayDate = item.in[0].stml_dt ? item.in[0].stml_dt.replaceAll('-', '.') : '';
  
    return `
    <div class="swiper-slide" data-index="${idx}" data-corp="${item.corp_code}">
      <div class="show_inner">
        <h2>
          ${headBadge}
          <div class="name">${item.corp_name||''}</div>
          <a href="/detail/${item.corp_code}" class="link link_show_new" target="_blank"></a>
          ${anyRcept ? `
            <a href="https://dart.fss.or.kr/dsaf001/main.do?rcpNo=${anyRcept}"
               class="link"
               onclick="window.open(this.href,'dartPopup','width=800,height=1000,scrollbars=yes,resizable=yes'); return false;">
            </a>` : ''}
            <div class="date">(${displayDate?`${displayDate} 기준`:''})</div>   
        </h2>
  
        <div class="map leftwrap">
          <div class="map_header">주주 구성 <div class="desc"><span>5%이상 대주주</span><span>최대주주 및 특수관계인</span></div></div>
          <div class="map_wrap ${topCountClassName}" id="leftMap">
            <div class="chart-container chart-top" data-chart="0"></div>
            <div class="chart-container chart-sub" data-chart="1"></div>
          </div>
        </div>
  
        <div class="map rightwrap">
          <div class="map_header">타법인 출자</div>
          <div class="map_wrap">
            <div class="chart-container" data-chart="2"></div>
          </div>
        </div>
      </div>
    </div>`;
}

// 공통 옵션(안바꿔도됨)
const chartOpt = {
    animation: {
        duration: 2000,         // 2초 동안 전체 차트 애니메이션
        easing: 'easeOutBounce' // 부드러운 easing 효과
    },
    type: 'packedbubble',
    width: null,
    height: '100%' ,
    backgroundColor: 'transparent',
};
const screenWidth = window.innerWidth;
// 화면 너비에 따라 버블 간격 계산
let bubblePaddingValue,
    bubbleMinSize,
    bubbleMaxSize,
    bubbleMinSizeGr,
    bubbleMaxSizeGr;

if (screenWidth < 415) { 
    bubblePaddingValue = 10;
    bubbleMinSize= '70%';
    bubbleMaxSize='100%';
    bubbleMinSizeGr='80%';
    bubbleMaxSizeGr='100%';
} else if (screenWidth < 600) { 
    bubblePaddingValue = 10;
    bubbleMinSize= '50%';
    bubbleMaxSize='90%';
    bubbleMinSizeGr='60%';
    bubbleMaxSizeGr='100%';
} else if (screenWidth < 1500) { 
    bubblePaddingValue = 10;
    bubbleMinSize= '50%';
    bubbleMaxSize='80%';
    bubbleMinSizeGr='45%';
    bubbleMaxSizeGr='90%';
} else {                        
    bubblePaddingValue = 20;
    bubbleMinSize='50%';
    bubbleMaxSize='80%';
    bubbleMinSizeGr='40%';
    bubbleMaxSizeGr='80%';
}
// 차트
let chartPool = new Map();
const scaleSize = (size, k) => {
  if (typeof size === 'number') return size * k;
  if (typeof size === 'string' && size.endsWith('%')) return (parseFloat(size) * k) + '%';
  return size;
};
  
function createChartFor(el, series, role) {
    const base = { ...chartOpt };
  
    const layoutAlgorithm = {
        splitSeries: false,
        seriesInteraction: false,
        parentNodeLimit: true,
        gravitationalConstant: 0.02,
        bubblePadding: bubblePaddingValue,     
        initialPositionRadius: 40,
        maxIterations: 800
    };

    // role: 0=대주주, 1=특수관계인, 2=오른쪽
    const isRight = role === 2;
    let mins, maxs;
  
    if (role === 0) {
      mins = scaleSize(bubbleMinSize, 1.2);
      maxs = bubbleMaxSize;
    } else if (isRight) {
      mins = bubbleMinSizeGr;
      maxs = bubbleMaxSizeGr;
    } else {
      mins = bubbleMinSize;
      maxs = bubbleMaxSize;
    }
  
    const getZRange = (arr) => {
      const vals = (arr || []).map(p => +p.value || 0).filter(v => v > 0);
      if (!vals.length) return { zMin: 0, zMax: 1 };
      const zMin = Math.min(...vals);
      let zMax = Math.max(...vals);
      if (!Number.isFinite(zMin) || !Number.isFinite(zMax) || zMin === zMax) zMax = zMin + 1;
      return { zMin, zMax };
    };
  
    // 왼/오 동일 로직이면 그대로
    const { zMin, zMax } = getZRange(series);
    const zMinOpt = zMin;
    const zMaxOpt = zMax;
  
    return Highcharts.chart(el, {
      chart: base,
      tooltip: { enabled: false },
      plotOptions: {
        packedbubble: {
          minSize: mins,
          maxSize: maxs,
          zMin: zMinOpt,
          zMax: zMaxOpt,
          layoutAlgorithm,
          dataLabels: commonDataLabels,
          parentNodeOptions: { marker: { radius: 0 } },
          states: { hover: { enabled: false } }
        }
      },
      series: [{ borderWidth: 0, data: series }]
    });
}

// Swiper
function wireSwiperEvents() {
    if (!showSwiper) return;
    showSwiper.on('init', function() {
        for (const [, inst] of chartPool) { try { inst.destroy(); } catch(e){} }
        chartPool.clear();
        renderVisibleCharts(this);
    });
    showSwiper.on('slideChangeTransitionStart', function() {
        renderVisibleCharts(this);
    });
    showSwiper.on('resize', function() {
        renderVisibleCharts(this);
    });
}

function initSwiperIfNeeded(needLoop) {
    if (showSwiper) return;
    showSwiper = new Swiper('.main_show_swiper', {
        threshold: 20,
        fadeEffect: { crossFade: true },
        loop: !!needLoop, // 2장 이상일 때만 loop
        navigation: {
            nextEl: '.main_show_swiper .swiper-button-next',
            prevEl: '.main_show_swiper .swiper-button-prev',
        },
        pagination: { el: '.main_show_swiper .swiper-pagination' },
        breakpoints: {
            600: {
            }
        },
    });
    wireSwiperEvents();
}

// function syncSwiperFromCache(baseDate='') {
function syncSwiperFromCache() {
    const wrapper = document.querySelector('.main_show_swiper .swiper-wrapper');
    if (!wrapper) return;

    const slides = slideCache.map((g,i)=>slideChartHTML(g,i));
    wrapper.innerHTML = slides.join('');

    // 한 슬라이드 당 [leftTop, leftSub, right] 구조 저장
    chartSeriesCache = slideCache.map(g => buildSeriesFromGroup(g));

    const needLoop = slides.length > 1;
    if (!showSwiper) { initSwiperIfNeeded(needLoop); }
    else {
        if (!!showSwiper.params.loop !== needLoop) {
            showSwiper.destroy(true, true);
            showSwiper = null;
            initSwiperIfNeeded(needLoop);
        } else {
            if (showSwiper.params.loop) showSwiper.loopDestroy();
                showSwiper.removeAllSlides();
                showSwiper.appendSlide(slides);
            if (showSwiper.params.loop) showSwiper.loopCreate();
                showSwiper.update();
                showSwiper.slideToLoop(0, 0);
        }
    }

    requestAnimationFrame(() => {
        for (const [, inst] of chartPool) { try { inst.destroy(); } catch(e){} }
        chartPool.clear();
        renderVisibleCharts(showSwiper);
    });
}

function renderVisibleCharts(swiper) {
    if (!swiper) return;

    const activeEl = swiper.slides[swiper.activeIndex];
    const nextEl   = swiper.slides[swiper.activeIndex + 1] || swiper.slides[0];
    const keepSlides = [activeEl, nextEl].filter(Boolean);

    const targets = [];
    keepSlides.forEach(slideEl => {
        const slideIdx = getSlideIndex(slideEl);
        if (Number.isNaN(slideIdx) || slideIdx < 0) return;

        slideEl.querySelectorAll('.chart-container').forEach((el) => {
        const role = parseInt(el.dataset.chart || '0', 10);
        targets.push({ el, slideIdx, role });
        });
    });

    const allowEls = new Set(targets.map(t => t.el));
    for (const [el, inst] of chartPool.entries()) {
        if (!allowEls.has(el)) { try { inst.destroy(); } catch(e){} chartPool.delete(el); }
    }
    
    for (const t of targets) {
        if (chartPool.has(t.el)) continue;

        const triple = chartSeriesCache[t.slideIdx] || [[],[],[]];
        const series = triple[t.role] || [];
    
        const inst = createChartFor(t.el, series, t.role);
        chartPool.set(t.el, inst);
    }
    tooltipEvt();
}

const commonDataLabels = {
    enabled: true,
    useHTML: true, 
    allowOverlap: true,             // 겹침 허용 → SVG 계산 강제 변경 방지
    formatter: function () {
        const code = this.point.sortCode;
        const cursorFg = this.point.cursorFg;
        const sortHtml = HTMLByCode(code);  // 'Y','K','N','E'
        const radius = this.point.marker.width; 
        const wonHtml = this.point.won ? '<br>'+this.point.won : '';

        const hasCode = !!this.point.sortCode;
        const cursor  = cursorFg == 'Y' ? 'cursor:pointer;' : '';
        var inclick = '';
        if(cursorFg == 'Y'){
            inclick = 'inclick';
        }

        const linkHtml = this.point.href ? '<a href="'+this.point.href+'" class="link link_show" target="_blank"></a>' : '';
        
        return `
        <div class="inner_circle ${inclick}" style="width:${radius}px;height:${radius}px;${cursor}">
            <div class="inner">
                <div class="icon_wrap">
                    <div class="inner">
                        ${sortHtml}
                        <a href="#" class="detailview"></a>
                        ${linkHtml}
                    </div>
                </div>
                <div class="name">
                    <p>${this.point.name}</p>
                    
                </div>
            </div>
           <div class="val">${(this.point.pct ?? this.point.value)}%${wonHtml}</div>
        </div>
        `;
    }
}

$et.on('click','.detailview',function(e){
    e.stopPropagation();
    e.preventDefault();
    const $this = $(this),
        $root = $this.closest(".inner_circle "),
        $modal = $(".modal_moreInfo");
    if($this.next('.sort').length) { 
        const sort = $this.next('.sort').find('.tooltip').text().trim(); 
        $modal.find('.sorttxt').addClass('on').text(sort);
    }else{
        $modal.find('.sorttxt').removeClass('on')
    }
    const nameHtml = $root.find('.name').html();
    const dataHtml = $root.find('.val').html();
    $modal.find('.name').html(nameHtml);
    $modal.find('.data').html(dataHtml);
    modal.open('moreInfo');
})

// API data > seriesData 변
function buildSeriesFromGroup(group) {
    const inList  = group.in || [];
    const outList = group.out || [];
    // 대주주
    const leftTop = inList.filter(r => (r.holder_type || '').trim() === '대주주').map(r => {
        var detail_href = null;
        if(r.gongsi_fg == 'Y'){
            detail_href = r._corp_code ? `/detail/${r._corp_code}` : null;
        }
        return {
            name: r.nm ?? '',
            sortCode: r._corp_cls,                          // 라벨용
            cursorFg: r.gongsi_fg,                          
            value: percentToNumber(r.stkrt),                // 원 크기용
            won:   r.stkqy ? `${Number(r.stkqy).toLocaleString()}주` : undefined,
            // link: dart_link,
            href: detail_href,
            events: {
                click: () => {
                    if (r.gongsi_fg == 'Y') invest_info([r._corp_code]);
                }
            },
            color: '#5A8BD2', borderColor: '#5A8BD2'
        };
    });

    // 특수관계인
    const leftSub = inList.filter(r => (r.holder_type || '').trim() !== '대주주').map(r => {
        var detail_href = r._corp_code ? `/detail/${r._corp_code}` : null;
        return {
            name: r.nm ?? '',
            sortCode: r._corp_cls,
            cursorFg: r._corp_cls,
            value: percentToNumber(r.stkrt),
            won:   r.stkqy ? `${r.stkqy}주` : undefined,
            href: detail_href,
            events: {
                click: () => {
                    if (r._corp_code) invest_info([r._corp_code]);
                }
            },
            color: '#6680A7', borderColor: '#6680A7'
        };
    });
  
    // 오른쪽(투자회사 분석)
    const numOr0 = v => {
        if (v == null || v === '') return 0;
        const n = Number(String(v).replace(/[^0-9.\-]/g, ''));
        return Number.isFinite(n) ? n : 0;
    };

    let right;
    if (Array.isArray(outList) && outList.length > 0) {
        right = outList.map(r => {
            var detail_href = r._corp_code ? `/detail/${r._corp_code}` : null;
            return {
                name: r.inv_prm ?? '',
                sortCode: r._corp_cls,
                cursorFg: r._corp_cls,
                value: numOr0(r.trmend_amt_num),                             // 버블 크기
                pct:   percentToNumber(r.trmend_blce_qota_rt)||0,            // 라벨 %
                won:   fmtAmountToBaekman(r.trmend_blce_acntbk_amount) || undefined,
                href: detail_href,
                events: {
                    click: () => {
                        if (r._corp_code) invest_info([r._corp_code]);
                    }
                },
                color: '#77c1c5', borderColor: '#77c1c5'
            };
        });
    } else {
        right = [{
            name: '데이터 없음',
            sortCode: null,
            cursorFg: null,                 
            value: 100,                     
            pct: 0,
            won: undefined,
            href: null,
            isPlaceholder: true,            
            color: '#E5E7EB',               
            borderColor: '#D1D5DB',
            dataLabels: {
                enabled: true,
                useHTML: true,
                formatter: function () { return '<b style="color: #666; font-size: 15px;">데이터 없음</b>'; }
            }
        }];
    }
    return [leftTop, leftSub, right];
}

// 그룹핑
function groupByCorp(data) {
    const inList  = data.In_corp_list  || [];
    const outList = data.Out_corp_list || [];
    const map = new Map();

    const upsert = (code, name, cls) => {
        code = String(code ?? '');
        if (!code) return null;
        if (!map.has(code)) {
            map.set(code, { corp_code: code, corp_name: name || '', corp_cls: cls || '', in: [], out: [], stlm_dt: '' });
        } else {
            const item = map.get(code);
            if (!item.corp_name && name) item.corp_name = name;
            if (!item.corp_cls && cls) item.corp_cls = cls;
        }
        return map.get(code);
    };

    for (const r of inList) {
        const g = upsert(r.corp_code, r.corp_name, r.corp_cls);
        if (g) g.in.push(r);
    }
    for (const r of outList) {
        const g = upsert(r.corp_code, r.corp_name, r.corp_cls);
        if (g) g.out.push(r);
    }
    return Array.from(map.values());
}

const MAX_SLIDES = 5;       // 최대 슬라이드 개수
let slideCache = [];
let chartSeriesCache = [];
let showSwiper = null;

// 원본 인덱스 얻기
function getSlideIndex(el) {
    const i = el?.getAttribute?.('data-swiper-slide-index');
    if (i != null) return parseInt(i, 10);
    const j = el?.dataset?.index;
    return j != null ? parseInt(j, 10) : -1;
}

// API 호출
function pushToFrontAndTrim(groups) {
    for (const g of groups) {
        slideCache = slideCache.filter(x => x.corp_code !== g.corp_code);
        slideCache.unshift(g);
    }
    if (slideCache.length > MAX_SLIDES) slideCache.length = MAX_SLIDES;
}

async function invest_info(corp_code) {
    try {
        loader?.s && loader.s();
        let codes = corp_code
        if (codes == null || (Array.isArray(codes) && codes.length === 0) || (typeof codes === 'string' && codes.trim() === '')) {
            codes = await list_corp_code(5);
        }
        if (!Array.isArray(codes)) {
            codes = [String(codes).trim()];
        }
        codes = codes.filter(Boolean);
        if (!codes.length) {
            return;
        }
        const json = await $.ajax({
            type: 'GET',
            url: '/api/IfGovernanceGraph',
            data: { 'corp_code[]': codes },
            dataType: 'json',
            cache: true
        });
        $ipt.val('').blur();
        $list.empty();
        $cont.hide();
        
        if (json.status !== '00') {
            alert('해당 회사의 지배구조 정보가 없습니다.');
            return;
        }
        const groups = groupByCorp(json.DataList || []);
        if (!slideCache.length || codes.length > 1) {
            slideCache = groups.slice(0, MAX_SLIDES);
        } else {
            pushToFrontAndTrim(groups);
        }
        syncSwiperFromCache();

    } catch (e) {
        console.error('invest_info error:', e);
    } finally {
        loader?.e && loader.e();
    }
}
invest_info();

// 바로가기 이미지 버튼 클릭시 팝업으로 뜨도록 추가
document.addEventListener('click', function(e) {
    const a = e.target.closest('a.link.open_dart');
    if (!a) return;  
    e.preventDefault();
    window.open(
      a.href,
      'dartPopup',
      'width=1200,height=800,scrollbars=yes,resizable=yes'
    );
});

// ============================
// 지배 구조 전체보기
// ============================
function corpGovernanceAll(corpCode){
    $.ajax({
        type : 'GET',
        url  : '/api/IfCorpGovernanceAll',
        data:{ corp_code: corpCode, std_year: lastYear },
        dataType : 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') {
                alert("해당 회사의 집단기업(그룹사) 지배구조 정보가 없습니다.");
                return;
            }
            const BASE_URL = window.location.origin;
            const file_path = json.DataList[0].file_path;
            const file_page = json.DataList[0].file_page;
            const url = `${BASE_URL}/${file_path}#page=${file_page}`;
            window.open(url, '_blank');
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}

document.querySelector('#CorpInfoShowAll').addEventListener('click', function(e){
    e.preventDefault();
    const activeSlide = document.querySelector('.swiper-slide-active');
    const corpCode = activeSlide?.dataset.corp;
    corpGovernanceAll(corpCode);
});

// ============================
// 타법인 출자 현황
// ============================
function corpCrossOwnership(corpCode){
    console.log(corpCode);
    $.ajax({
        type : 'GET',
        url  : '/api/IfCorpCrossOwnership',
        data:{ corp_code: corpCode },
        dataType : 'json',
        cache: true,
        success: function (json) {
            const $tbody = $('.modal_otrCprInvstmnt tbody')
            if (json.status !== '00') {
                $('.modal_otrCprInvstmnt .modal_header h5').text('타법인 출자 현황');
                $tbody.empty();
                $tbody.append(`
                <tr>
                    <td colspan="8" class="no-result">검색 결과가 없습니다</td>
                </tr>
            `);
            return};            
            const info = json.DataList;           ;
            $('.modal_otrCprInvstmnt .modal_header h5').text(info[0].corp_name + ' 타법인 출자 현황');
            $tbody.empty();
            info.forEach(item => {
                const row = `
                    <tr>
                        <td class="inv_prm">${item.inv_prm || '-'}</td>
                        <td class="frst_acqs_de">${item.frst_acqs_de || '-'}</td>
                        <td class="invstmnt_purps">${item.invstmnt_purps || '-'}</td>
                        <td class="trmend_blce_qy">${item.trmend_blce_qy || '-'}</td>
                        <td class="trmend_blce_qota_rt">${item.trmend_blce_qota_rt || '-'}</td>
                        <td class="trmend_blce_acntbk_amount">${item.trmend_blce_acntbk_amount || '-'}</td>
                        <td class="recent_bsns_year_fnnr_sttus_tot_assets">${item.recent_bsns_year_fnnr_sttus_tot_assets || '-'}</td>
                        <td class="recent_bsns_year_fnnr_sttus_thstrm_ntpf">${item.recent_bsns_year_fnnr_sttus_thstrm_ntpf || '-'}</td>
                    </tr>
                `;
                $tbody.append(row);
            });
        }
    });
}
document.querySelector('#OtrCprInvstmnt').addEventListener('click', function(e){
    e.preventDefault();
    const activeSlide = document.querySelector('.swiper-slide-active');
    const corpCode = activeSlide?.dataset.corp;
    corpCrossOwnership(corpCode);
});

// ============================
// 메인 대시보드
// ============================
const DASHBOARD_ROOT    = '.mdashSwiper';
const DASHBOARD_WRAPPER = `${DASHBOARD_ROOT} .swiper-wrapper`;
let showDashboardSwiper = null;

function initDashboardSwiperIfNeeded() {
    if (showDashboardSwiper) return;
    showDashboardSwiper = new Swiper(`${DASHBOARD_ROOT} .swiper-container`, {
        spaceBetween: 30,
        allowTouchMove: true,
        navigation: {
            nextEl: `${DASHBOARD_ROOT} .swiper-button-next`,
            prevEl: `${DASHBOARD_ROOT} .swiper-button-prev`,
        },
        breakpoints: { 600: { allowTouchMove: false } },
        on: {
            slideChangeTransitionStart: dataReset,
            slideChangeTransitionEnd:   dataAni,
        },
    });
}

function renderSlides(html) {
    const wrapper = document.querySelector(DASHBOARD_WRAPPER);
    if (!wrapper) return;
    wrapper.innerHTML = html;
    initDashboardSwiperIfNeeded();
}

// 애니메이션
function dataReset() {
    const bars = document.querySelectorAll('.main_dashboard .bar');
    const nums = document.querySelectorAll('.main_dashboard .val_wrap dd');
    bars.forEach(bar => bar.style.width = '0');
    nums.forEach(num => num.textContent = '0');
}
function dataAni() {
    const bars = document.querySelectorAll('.main_dashboard .bar');
    const nums = document.querySelectorAll('.main_dashboard .val_wrap dd');
    bars.forEach(bar => {
        gsap.to(bar, { width: bar.dataset.val || '0%', duration: 1, ease: 'power2.out', delay: .1 });
    });
    nums.forEach(num => {
        const raw = String(num.dataset.val || '');                 // "300,870,903,000,000"
        const endValue = Number(raw.replace(/[^\d.-]/g, '')) || 0; // 300870903000000
        const counter = { val: 0 };

        gsap.to(counter, {
            val: endValue,
            duration: 1,
            ease: 'power2.out',
            onUpdate: () => {
                num.textContent = Math.floor(counter.val / 1e8).toLocaleString(); // 억
            }
        });
    });
}
// 템플릿
const withPercent = v => {
    if (v == null || v === '') return '';
    const s = String(v).trim();
    return s.endsWith('%') ? s : `${s}%`;
};

function buildProfitByYear(list) {
    const byYear = {};
    for (const r of (list||[])) {
        const year = String(r.bsns_year || '').trim();
        if (!year) continue;
        const nm = String(r.account_nm || '').trim();
        byYear[year] ??= { year, sales: null, op: null };
        if (nm.includes('매출'))     {byYear[year].sales = r.amt_order};
        if (nm.includes('영업이익'))  {byYear[year].op    = r.amt_order};
    }
    return Object.values(byYear).sort((a,b)=>Number(b.year)-Number(a.year)).slice(0,3);
}

function topHolders(list) {
    const arr = Array.isArray(list) ? list.slice() : [];
    arr.sort((a,b)=>{
        const an = parseFloat(String(a.trmend_posesn_stock_qota_rt||'').replace(/[^\d.-]/g,''))||0;
        const bn = parseFloat(String(b.trmend_posesn_stock_qota_rt||'').replace(/[^\d.-]/g,''))||0;
        return bn - an;
    });
    return arr.slice(0,4);
}

function dashboardSlideHTML({ corp_code, corp_name, ceo_name = '' }, profits, holders) {
    const years = buildProfitByYear(profits);
    const holderTop4 = topHolders(holders);
    const financeBoxes = years.map(y => `
        <div class="finace_item box">
        <div class="y">${y.year}</div>
        <dl class="val_wrap">
            <dt>매출</dt><dd data-val="${y.sales}">0</dd>
            <dt>영업이익</dt><dd data-val="${y.op}">0</dd>
        </dl>
        </div>`).join('');
    const holderLis = holderTop4.map(h=>{
        const per  = withPercent(h.trmend_posesn_stock_qota_rt);
        const name = h.nm;
        return `
        <li>
            <div class="bar_wrap"><div class="bar" data-val="${per}"></div></div>
            <div class="per">${per}</div>
            <div class="sh_name">${name}</div>
        </li>`;
    }).join('');

    return `
        <div class="swiper-slide main_dashboard" data-corp="${corp_code}">
        <h3>${corp_name || corp_code} 대시보드</h3>
        <div class="card">
            <div class="card_header">
            <div class="tit">대표이사</div>
            <div class="name">${ceo_name}</div>
            <a href="/detail/${corp_code}" class="btn btn_txt" target="_blank"><i></i>AI분석 상세보기</a>
            </div>
            <div class="card_body">
            <div class="inner">
                <h5 class="card_title">매출 및 영업이익 <span class="sm">단위:억원</span></h5>
                <div class="finance_item_wrap"><div class="inner_wrap">${financeBoxes}</div></div>
            </div>
            <div class="inner">
                <h5 class="card_title">최대주주 및 특수관계인</h5>
                <ul class="shareholder_list box">${holderLis}</ul>
            </div>
            </div>
        </div>
    </div>`;
}

// API
function corpProfile(corp_code) {
    return $.ajax({ type:'GET', url:'/api/IfCorpCompanyProfile', data:{ corp_code }, dataType:'json', cache:true });
}
function corpProfit(corp_code){
    return $.ajax({ type:'GET', url:'/api/IfCorpRevenueProfit', data:{ corp_code }, dataType:'json', cache:true });
}
function corpMajorShareholders(corp_code) {
    return $.ajax({ type:'GET', url:'/api/IfCorpMajorShareholders', data:{ corp_code }, dataType:'json', cache:true });
}
function groupByCorpCode(list) {
    const map = new Map();
    for (const r of (list||[])) {
        const code = String(r.corp_code || '');
        if (!map.has(code)) map.set(code, { corp_code: code, items: [] });
        map.get(code).items.push(r);
    }
    return Array.from(map.values());
}

// 첫 페이지 로딩
document.addEventListener('DOMContentLoaded', async () => {
    const wrapper = document.querySelector(DASHBOARD_WRAPPER);
    if (wrapper) wrapper.innerHTML = '';

    const codes = await list_corp_code(10);    

    $.when(
        corpProfile(codes),
        corpProfit(codes),
        corpMajorShareholders(codes)
    ).done((profileRes, profitRes, holdersRes) => {
        const profile = profileRes?.[0];
        const profit  = profitRes?.[0];
        const holders = holdersRes?.[0];
        if (!profile || !profit || !holders) return;
        if (profile.status && profile.status !== '00') return;
        if (profit.status  && profit.status  !== '00') return;
        if (holders.status && holders.status !== '00') return;

        const profileMap = new Map();
        (profile.DataList || []).forEach(p => {
            profileMap.set(String(p.corp_code || ''), p);
        });

        const profitMap = new Map();
        (groupByCorpCode(profit.DataList) || []).forEach(g => {
            profitMap.set(String(g.corp_code || ''), g.items || []);
        });

        const holdersMap = new Map();
        (groupByCorpCode(holders.DataList) || []).forEach(g => {
            holdersMap.set(String(g.corp_code || ''), g.items || []);
        });

        const slidesHTML = codes.map(code => {
            const key = String(code);
            const p0 = profileMap.get(key) || {};
            const header = {
            corp_code: key,
            corp_name: p0.corp_name || p0.corp_nm || '',
            ceo_name : p0.ceo_nm    || p0.repr_nm || ''
            };
            return dashboardSlideHTML(
            header,
            profitMap.get(key)  || [],
            holdersMap.get(key) || []
            );
        }).join('');

        renderSlides(slidesHTML);
        dataAni();
    }).fail((...args) => {
        console.warn('대시보드 API failed', args);
    });
});

// ============================
// 오늘의 공시
// ============================
// 달력
function fmt(d){
    const y = d.getFullYear();
    const m = String(d.getMonth()+1).padStart(2,'0');
    const day = String(d.getDate()).padStart(2,'0');
    return `${y}-${m}-${day}`;
}
// 오늘날짜는 nowDate
var weekAgo = new Date();
weekAgo.setDate(nowDate.getDate() - 7);

$('#gsBgnDe').val(fmt(weekAgo));
$('#gsEndDe').val(fmt(nowDate));

// 공통 옵션
const dpOpts = {
    inline: true,
    opens: 'left',
    singleMonth: true,
    singleDate: true,
    showDropdowns: true,
    format: 'YYYY-MM-DD',
    language: 'en',
    alwaysOpen: true,
    showTopbar: false,
    stickyMonths: true,
    customArrowPrevSymbol:'<img src="/images/common/datepicker_prev.png" alt="">',
    customArrowNextSymbol:'<img src="/images/common/datepicker_next.png" alt="">'
};

function validateRange(triggerEl, pickedValue, isStartPicker){
    const $start = $('#gsBgnDe');
    const $end   = $('#gsEndDe');

    if (isStartPicker) $start.val(pickedValue);
    else               $end.val(pickedValue);

    const bgn = $start.val();
    const end = $end.val();

    if (bgn && end && bgn >= end) {
        alert('접수일자가 잘못되었습니다.');
        if (isStartPicker) $start.val(''); else $end.val('');
        $(triggerEl).data('dateRangePicker').clear();
        return false;
    }
    return true;
}

// 시작일 달력
$('.datepicker1').dateRangePicker({ ...dpOpts, container: '#date-range' }).bind('datepicker-change', function (e, obj) {
    // obj.value: 'YYYY-MM-DD'
    if (validateRange(this, obj.value, true)) {
        $('.main_notice_today .sel_layPop').removeClass('active');
    }
});

// 종료일 달력
$('.datepicker2').dateRangePicker({ ...dpOpts, container: '#date-range2' }).bind('datepicker-change', function (e, obj) {
    if (validateRange(this, obj.value, false)) {
        $('.main_notice_today .sel_layPop').removeClass('active');
    }
});

// 팝업 토글
$('.table_srch_box').on('click', '.datepicker1', function(){
    $(this).next('.sel_layPop').toggleClass('active');
});
$('.table_srch_box').on('click', '.datepicker2', function(){
    $(this).next('.sel_layPop').toggleClass('active');
});

// 페이징 ajax
let currentPage = 1;
let pageSize = 10;
let lastQuery = { search_word: '', bgn_de: fmt(weekAgo).replaceAll('-', ''), end_de: fmt(nowDate).replaceAll('-', '') };

function renderTable(list, totalCount, pageNo, pageSize) {
    const $tbody = $('#gsCorpTb tbody');
    if (!Array.isArray(list) || list.length === 0) {
        $tbody.html('<tr><td colspan="6" class="text-center">데이터 없음</td></tr>');
        return;
    }
    // startNo desc
    const startNo = totalCount - (pageNo - 1) * pageSize;

    const rows = list.map((row, idx) => {
        const reportName = row.report_nm || '-';                // 보고서명                                        
        const corpName = row.corp_name || '-';                  // 회사명
        const market = (clsMap[row.corp_cls]?.tooltip) || '-';; // 주식시장                                       
        const submitter = row.flr_nm || '-';                    // 제출인                                                
        const rceptRaw = row.rcept_dt || ''; 
        let   rceptDate = rceptRaw.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');
                
        const no = startNo - idx                                // 번호 계산

        return `
        <tr>
            <td>${no.toLocaleString()}</td>
            <td><a href="${row.corp_code ? `/detail/${row.corp_code}` : '#'}" target="_blank">${escapeHtml(corpName)}</a></td>
            <td class="left">
            <a href="https://dart.fss.or.kr/dsaf001/main.do?rcpNo=${row.rcept_no}" 
                onclick="window.open(this.href, '_blank', 'width=800,height=1000,scrollbars=yes,resizable=yes'); return false;">
                ${escapeHtml(reportName)}
            </a>
            </td>            
            <td class="ai_summary_cell" data-rcept-no="${row.rcept_no}">-</td>
            <td>${escapeHtml(market)}</td>
            <td>${escapeHtml(submitter)}</td>
            <td>${escapeHtml(rceptDate)}</td>
        </tr>
        `;
    }).join('');

    $tbody.html(rows);
    
    checkSummaryData();
}

function checkSummaryData() {
    const rceptNoList = [];
    const cellMap = {};
    
    $('.ai_summary_cell').each(function() {
        const $cell = $(this);
        const rceptNo = $cell.data('rcept-no');
        if (rceptNo) {
            rceptNoList.push(rceptNo);
            cellMap[rceptNo] = $cell;
        }
    });
    
    if (rceptNoList.length === 0) return;
    
    $.ajax({
        url: '/llmsumy/check_data',
        type: 'post',
        data: { rcept_no_list: rceptNoList },
        dataType: 'json',
        success: function(data) {
            if (data.results) {
                Object.keys(data.results).forEach(function(rceptNo) {
                    const $cell = cellMap[rceptNo];
                    if (data.results[rceptNo]) {
                        $cell.html(`<button type="button" class="btn btn_down btn_ai_summary" data-rcept-no="${rceptNo}">다운로드</button>`);
                    }
                });
            }
        }
    });
}

let currentRequests = {};
$(document).on('click', '.btn_ai_summary', function() {
    const rceptNo = $(this).data('rcept-no');
    openAiSummaryModal(rceptNo);
});

function openAiSummaryModal(rceptNo) {
    $('.modal_aiSummary #summaryResult').text('AI 요약 중.');
    modal.open('aiSummary');

    if (currentRequests[rceptNo]) {
        return;
    }
    currentRequests[rceptNo] = true;

    $.ajax({ 
        url: "/llmsumy/make_summary/",
        type: "POST", 
        data: {
            rcept_no: rceptNo
        },
        dataType: "json",
        success: function(data) {
            if (data.ok === true) {
                $('#summaryResult').css('white-space', 'pre-wrap').text(data.summary.replace(/\\n/g, '\n'));

            } else {
                $('#summaryResult').html('AI 요약 생성 중 오류가 발생했습니다.');
            }
        }, 
        error: function(xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
            $('#summaryResult').text('서버 오류가 발생했습니다.');
        },
        complete: function() {
            delete currentRequests[rceptNo];
        }
    });
}

// 페이지번호 5개씩 노출
function renderPagination(totalCount, pageSize, currentPage) {
    const $paging = $('#pagination');
    const totalPages = Math.max(1, Math.ceil(totalCount / pageSize));

    if (totalPages === 1) {
        $paging.html('');   // 한 페이지만 있으면 숨김
        return;
    }

    const windowSize = 5;   // 노출 페이지 버튼 갯수
    const windowStart = Math.floor((currentPage - 1) / windowSize) * windowSize + 1;
    const windowEnd = Math.min(totalPages, windowStart + windowSize - 1);

    let html = '';
    html += `<a href="#" class="first" data-page="1">처음</a>`;
    html += `<a href="#" class="prev" data-page="${Math.max(1, currentPage - 1)}">이전</a>`;

    for (let p = windowStart; p <= windowEnd; p++) {
        html += `<a href="#" class="${p === currentPage ? 'on' : ''}" data-page="${p}">${p}</a>`;
    }

    html += `<a href="#" class="next" data-page="${Math.min(totalPages, currentPage + 1)}">다음</a>`;
    html += `<a href="#" class="last" data-page="${totalPages}">마지막</a>`;

    $paging.html(html);
}
// XSS 방지
function escapeHtml(str) {
    return String(str ?? '')
    .replaceAll('&','&amp;')
    .replaceAll('<','&lt;')
    .replaceAll('>','&gt;')
    .replaceAll('"','&quot;')
    .replaceAll("'",'&#39;');
}

function gongsiPageAjax(page) {
    currentPage = page;
    const startDate = $("#gsBgnDe").val();
    const endDate = $("#gsEndDe").val();
    const start = new Date(startDate);
    const end = new Date(endDate);
    if (end < start) {
        alert("접수일자가 잘못되었습니다.");
        return;
    }
    $.ajax({
        method: 'GET',
        url: '/api/IfDisclosureSearch',
        // url: '/opensearch/IfDisclosureOpenSearch',
        data: {
            search_word: lastQuery.search_word,
            bgn_de: lastQuery.bgn_de,
            end_de: lastQuery.end_de,
            page_no: currentPage,
            page_count: pageSize
        },
        dataType: 'json',
        cache: false,
        success: function (json) {            
            if (json.status && json.status !== '00') {
                const $tbody = $("#gsCorpTb tbody");
                const $pagination = $("#pagination");
                $tbody.html(
                    `<tr>
                        <td colspan="7" style="text-align:center;">조회 결과가 없습니다.</td>
                     </tr>`
                );
                $pagination.empty();
                return;
            }
            const list = json.DataList.list || [];
            const total = Number(json.DataList.total_count || 0);
            renderTable(list, total, currentPage, pageSize);
            renderPagination(total, pageSize, currentPage);
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}

$('#srchGonsiCorp').on('click', function(e) {
    e.preventDefault();
    lastQuery.search_word = $('#gsSearchWord').val() || '';
    lastQuery.bgn_de = ($('#gsBgnDe').val() || '').replaceAll('-', '');
    lastQuery.end_de = ($('#gsEndDe').val() || '').replaceAll('-', '');
    loader.s();
    gongsiPageAjax(1);
    loader.e();
});

$('#pagination').on('click', 'a', function(e) {
    e.preventDefault();
    const page = Number($(this).data('page'));
    if (!isNaN(page)) {
        gongsiPageAjax(page);
    }
});

gongsiPageAjax(1);

// ==========================================
// 기업랭킹분석 메인그래프 2개(매출액, 당기순이익)
// ==========================================
// 매출액 상위 10개
$.ajax({
    method: 'GET',
    url: '/api/IfTopRevenue',
    data: { bsns_year: lastYear },
    dataType: 'json',
    cache: false,
    success: function (json) {
        if (json.status && json.status !== '00') return;
        var list = json.DataList || [];
        var $ul = $("#profitRank");
        $ul.empty();

        var maxVal = Math.max.apply(null, list.map(function(item){
            return parseInt(item.amt_order, 10) || 0;
        }));

        list.forEach(function(item, idx) {
            var num = idx + 1;  
            var name = item.corp_name;
            var val = parseInt(item.amt_order, 10) || 0;
            var data = Math.floor(item.amt_order / 1e8).toLocaleString();   // 억단위 및 쉼표 (소수점 제거)

            var ratio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

            var li = `
                <li>
                    <div class="num">${num}</div>
                    <div class="name">${name}</div>
                    <div class="bar_wrap">
                        <div class="bar_inner">
                            <div class="bar" data-val="${ratio}"></div>
                        </div>
                    </div>
                    <div class="data">${data}</div>
                </li>
            `;
            $ul.append(li);
            var $bar = $ul.find('li:last .bar');
            $bar.css('width', 0);
        });
    },
    error: function (xhr, status, error) {
        console.log(xhr + '|' + status + '|' + error);
    }
});

// 당기순이익 상위 10개
$.ajax({
    method: 'GET',
    url: '/api/IfTopNetIncome',
    data: { bsns_year: lastYear },
    dataType: 'json',
    cache: false,
    success: function (json) {
        if (json.status && json.status !== '00') return;
        var list = json.DataList || [];
        var $ul = $("#topNetIncomeRank");
        $ul.empty();

        var maxVal = Math.max.apply(null, list.map(function(item){
            return parseInt(item.amt_order, 10) || 0;
        }));

        list.forEach(function(item, idx) {
            var num = idx + 1;  
            var name = item.corp_name;
            var val = parseInt(item.amt_order, 10) || 0;
            var data = Math.floor(item.amt_order / 1e8).toLocaleString();   // 억단위 및 쉼표 (소수점 제거)

            var ratio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

            var li = `
                <li>
                    <div class="num">${num}</div>
                    <div class="name">${name}</div>
                    <div class="bar_wrap">
                        <div class="bar_inner">
                            <div class="bar" data-val="${ratio}"></div>
                        </div>
                    </div>
                    <div class="data">${data}</div>
                </li>
            `;
            $ul.append(li);
            var $bar = $ul.find('li:last .bar');
            $bar.css('width', 0);
        });
    },
    error: function (xhr, status, error) {
        console.log(xhr + '|' + status + '|' + error);
    }
});

// ==========================================
// 기업랭킹분석 미니그래프 9개
// ==========================================
const chartsArr = [];        // Highcharts 인스턴스
const chartOptions = [];     // 각 차트의 옵션(데이터) 저장소 [0..6]

function chartSpect(){
    const reqs = [
        $.ajax({ method:'GET', url:'/api/IfTopTreasuryStock', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart0(json)),
        $.ajax({ method:'GET', url:'/api/IfTopMinorityShareholders', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart1(json)),
        $.ajax({ method:'GET', url:'/api/IfTopListedSubsidiaries', data:{}, dataType:'json', cache:false })
        .then(json => buildChart2(json)),
        $.ajax({ method:'GET', url:'/api/IfTopMajorOwnership', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart3(json)),
        $.ajax({ method:'GET', url:'/api/IfTopBonusIssue', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart4(json)),
        $.ajax({ method:'GET', url:'/api/IfTopNPSInvestedCompanies', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart5(json)),
        $.ajax({ method:'GET', url:'/api/IfTopPermanentEmployee', data:{ bsns_year: lastYear }, dataType:'json', cache:false })
        .then(json => buildChart6(json)),
    ];
    return Promise.allSettled(reqs).then(results => {
        results.forEach((res, i) => {
            if (res.status === 'fulfilled') {
            chartOptions[i] = res.value;          // buildChartX가 리턴한 옵션
            } else {
            console.warn('chart'+i+' 로드 실패:', res.reason);
            chartOptions[i] = getFallbackOption(); // 안전 기본 옵션
            }
        });
        renderAllCharts(); // ← 여기서 한 번에 차트 찍기
    });
}
function getFallbackOption(){
    return {
        chart: { type:'line' },
        xAxis: { categories: [] },
        series: [{ name:'데이터 없음', data: [] }]
    };
}
function renderAllCharts(){
    // 컨테이너 id: chart1 ~ chart7 가 있다고 가정
    for (let i = 0; i < 7; i++){
      const containerId = 'chart' + (i + 1);
      renderChart(i, containerId);
    }
}
function reflowVisibleCharts(swiper) {
    const n = Math.ceil(swiper.params.slidesPerView);
    const start = swiper.activeIndex;
    for (let i = start; i < start + n; i++) {
        if (chartsArr[i] && chartsArr[i].reflow) chartsArr[i].reflow();
    }
}  

function renderChart(i, containerId){
    const el = document.getElementById(containerId);
    if (!el) { console.warn('컨테이너 없음:', containerId); return; }  
    // 기존 인스턴스 있으면 파괴
    if (chartsArr[i] && chartsArr[i].destroy) chartsArr[i].destroy();  
    const opt = Highcharts.merge(
      commonOptions,
      chartOptions[i] || getFallbackOption()
    );  
    chartsArr[i] = Highcharts.chart(containerId, opt);
}
// 보통주 자기주식 취득금액 상위 10개
function buildChart0(json) {
    const stlm_dt = json.DataList[0].stlm_dt.replace(/-/g, '.');
    $('#selfStockRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 4);
    // const list = json.DataList || [];
    const points = list.map(it => ({
        name: it.corp_name || '-',
        y: Number((it.change_qy_acqs || '0').replace(/,/g, ''))
        // y: (function (v) {
        //     const f = parseFloat(String(v).replace(',',''));
        //     return isNaN(f) ? 0 : f;
        // })(it.change_qy_acqs)
    }));
    return {
        xAxis: {
            type: 'category' ,
        },
        yAxis: {
            max: 50000000,
        },
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.name}</span><br>',
            pointFormat: '<b>{point.y:,.0f}주</b>'
            // '<b>{point.y:,.0f}주</b>' 
        },
        plotOptions: {
            series: {
                dataLabels: { enabled: false }
            }
        },
        series: [{
            type: 'column',
            name: '취득수량',
            data: points,
            border: false,
            borderRadius: 2,
            color: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, // 위→아래
                stops: [
                    [0, 'rgba(55, 235, 240, 1)'], // 시작색
                    [1, 'rgba(55, 190, 230, .9)']  // 끝색
                ]
            },
            showInLegend: false,
            borderWidth: 0, 
        }]
    };
}
// 소액주주비율 상위 10개
function buildChart1(json) {
    const stlm_dt = json.DataList[0].stlm_dt.replace(/-/g, '.');
    $('#minorShareholdersRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 6);
    const points = list.map((it,idx) => ({
        name: it.corp_name || '-',
        y: (function(v){
            const f = parseFloat(String(v).replace('%',''));
            return isNaN(f) ? 0 : f;
        })(it.hold_stock_rate),
        color: ['#3af578','#9ff53a','#f3f53a','#f5c23a','#f5923a','#f5733a'][idx]
    }));     
    return {
        chart: {
            type: 'lollipop',
        },
        xAxis: { type: 'category' },
        yAxis: {
            max: 100,
        },
        accessibility: { announceNewData: { enabled: true } },  
        plotOptions: {
            series: {
                dataLabels: {
                enabled: false,
                }
            }
        }, 
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.name}</span><br>',
            pointFormat: '<b>{point.y:.2f}%</b>'
        },
        
        series: [{
            name: '소액주주비율',
            data: points
        }]
    };
}
// 상장 자회사 수 상위 10개
function buildChart2(json) {
    $('#ListedSubsidiariesRank .date').text('2024.12.31');
    const list = (json.DataList || []).slice(0, 5);
    const categories = list.map(it => it.unityGrupNm || '-');
    const data = list.map((it, idx) => ({
        y: Number(it.cnt || 0),
        color: ['#f53ad6','#f53a92','#d83af5','#b13af5'][idx] // 막대별 색상
    }));
    return {
        chart: {
            type: 'bar'
        },
        xAxis: {
            categories:categories,
        },
        series: [{
            name: 'Year 2024',
            data: data,
            borderWidth: 0, 
        }]
    };

}
// 최대주주와 특수관계인 지분율 상위 기업
function buildChart3(json) {
    const stlm_dt = json.DataList[0].stlm_dt.replace(/-/g, '.');
    $('#majorOwnershipRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 3);  
    // 메인 포인트: 회사명 + 금액(y), 툴팁에 지분율(z)도 같이 노출
    const points = list.map(it => {
        const amt = Number(it.amt_order) || 0; // 금액(숫자)
        return {
            name: it.corp_name || '-',
            y: Number(it.trmend_posesn_stock_qota_rt) || 0,
            p:amt,
        };
    });  
    return {
        xAxis: {
            type: 'category' ,
        },
        yAxis: {
            max: 100,
        },
        tooltip: {
            headerFormat: '<span style="font-size:11px">{point.name}</span><br/>',
            pointFormatter: function () {
            // 금액 + 지분율 같이 보여줌
            const amt = Highcharts.numberFormat(this.p, 0);
            const pct = (typeof this.y === 'number') ? Highcharts.numberFormat(this.y, 2) + '%' : '-';
            return `<b>${amt}</b> (지분율: <b>${pct}</b>)`;
            }
        },
        plotOptions: {
            series: {
                dataLabels: { enabled: false }
            }
        },
        series: [{
            type: 'column',
            name: '지지율',
            data: points,
            border: false,
            borderRadius: 2,
            showInLegend: false,
            borderWidth: 0, 
            color: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, // 위→아래
                stops: [
                    [0, 'rgba(135, 235, 80, 1)'], // 시작색
                    [1, 'rgba(70, 170, 60, .9)']  // 끝색
                ]
            },
        }]
    };
}
// 보통주 무상증자금액이 많은 기업
function buildChart4(json) {
    const stlm_dt = json.DataList[0].rcept_no.slice(0, 4) + '.12.31';
    $('#bonusIssueRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 5);
    const points = list.map(it => ({
        name: it.corp_name || '-',
        y: Number((it.own_stock_amount || '0').replace(/,/g, ''))
    }));
    return {
        xAxis: {
            type: 'category' ,
        },
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.name}</span><br>',
            pointFormat: '<b>{point.y}</b>'
        },
        plotOptions: {
            series: {
                dataLabels: { enabled: false }
            }
        },
        series: [{
            type: 'column',
            name: '무상증자금액',
            data: points,
            border: false,
            borderRadius: 2,
            color: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, // 위→아래
                stops: [
                    [0, 'rgba(55, 235, 240, 1)'], // 시작색
                    [1, 'rgba(55, 190, 230, .9)']  // 끝색
                ]
            },
            showInLegend: false,
            borderWidth: 0, 
        }]
    };
}
// 국민연금 출자 순위
function buildChart5(json) {
    const stlm_dt = json.DataList[0].rcept_no.slice(0, 4) + '.12.31';
    $('#npsInvestedCompaniesRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 5);
    // name / y 형태로 변환
    const points = list.map((it,idx) => ({
        name: it.corp_name || '-',
        y: Number(it.stkrt) || 0,
        color: ['#3af578','#9ff53a','#f3f53a','#f5c23a','#f5923a','#f5733a'][idx]
    }));
    return {
        chart: {
            type: 'lollipop',
        },
        xAxis: { type: 'category' },
        yAxis: {
            labels: {
                formatter() { return Highcharts.numberFormat(this.value, 0); },
                style: { color: 'rgba(255,255,255,0.6)' }
            }
        },
        accessibility: { announceNewData: { enabled: true } },  
        plotOptions: {
            series: {
                dataLabels: {
                enabled: false,
                }
            }
        }, 
        tooltip: {
            headerFormat: '<span style="font-size:12px">{point.name}</span><br/>',
            pointFormat: '<b>{point.y:.2f}%</b>'
        },
        series: [{
            name: '국민연금 지분율',
            data: points
        }]
    };
}
// 정규직 근로자 수 순위
function buildChart6(json) {
    const stlm_dt = json.DataList[0].stlm_dt.replace(/-/g, '.');
    $('#permanentEmployeeRank .date').text(stlm_dt);
    const list = (json.DataList || []).slice(0, 5);
    const categories = list.map(it => it.corp_name || '-');
    const points = list.map((it, idx) => ({
        y: Number(it.total_rgllbr_co || 0),
        color: ['#f53ad6','#f53a92','#d83af5','#b13af5'][idx] // 막대별 색상
    }));
    return {
        chart: {
            type: 'bar'
        },
        xAxis: {
            categories:categories,
        },
        tooltip: {
            shared: true,
            headerFormat: '<span style="font-size:12px">{point.name}</span><br/>',
            pointFormat:
                '<span style="color:{point.color}">●</span> {series.name}: <b>{point.y:,.0f}</b><br/>'
        },
        series: [{
            name: '정규직 근로자 수',
            data: points,
            borderWidth: 0, 
        }]
    }
}

function rankDataAni(){
    const bars = document.querySelectorAll('.main_ranking .bar');
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
// ============================
// 기업랭킹분석 (모달)
// ============================
// 매출액 상위
function ifTopRevenue(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopRevenue',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            console.log(json.DataList);
            const info = json.DataList || [];
            const top10 = info.slice(0, 10);
            const $tbody = $('.modal_pureProfitRank tbody');
            $tbody.empty();

            top10.forEach((item, idx) => {
                // 금액 문자열 > 숫자 변환 >억 단위
                const amt = item.amt_order ? Number(String(item.amt_order).replace(/[^\d.-]/g, '')) / 1e8 : 0;
                const row = `
                        <tr>
                            <td class="no">${idx + 1 || '-'}</td>
                            <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                            <td class="amt_order">${amt ? amt.toLocaleString() : '-'}</td>
                        </tr>
                    `;
                $tbody.append(row);
            });

            // 차트 데이터 생성
            const chartData = top10.map(item => {
                const amt = item.amt_order ? Number(String(item.amt_order).replace(/[^\d.-]/g, '')) / 1e8 : 0;
                return [item.corp_name || '-', amt];
            });

            Highcharts.chart('inProfitRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: { min: 0 },
                legend: { enabled: false },
                tooltip: {
                pointFormatter: function () {
                    return Highcharts.numberFormat(this.y, 1) + ' 억';
                }
                },
                series: [{
                pointWidth: 20,
                color: {
                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                    stops: [
                    [0, '#1673DA'],
                    [1, '#72ADEE']
                    ]
                },
                groupPadding: 0,
                data: chartData
                }]
            });
        }
        
    });
}
document.querySelector('#PureProfitRank').addEventListener('click', function(e){
    e.preventDefault();
    ifTopRevenue();
});

// 당기순이익 상위
function ifTopNetIncome(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopNetIncome',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            const info = json.DataList || [];
            const top10 = info.slice(0, 10);
            const $tbody = $('.modal_incomeRank tbody');
            $tbody.empty();

            top10.forEach((item, idx) => {
                // 금액 문자열 > 숫자 변환 >억 단위
                const amt = item.amt_order
                ? Number(String(item.amt_order).replace(/[^\d.-]/g, '')) / 1e8
                : 0;
                const row = `
                        <tr>
                            <td class="no">${idx + 1 || '-'}</td>
                            <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                            <td class="amt_order">${amt ? amt.toLocaleString() : '-'}</td>
                        </tr>
                    `;
                $tbody.append(row);
            });

            // 차트 데이터 생성
            const chartData = top10.map(item => {
                const amt = item.amt_order
                ? Number(String(item.amt_order).replace(/[^\d.-]/g, '')) / 1e8
                : 0;
                return [item.corp_name || '-', amt];
            });

            Highcharts.chart('inIncomeRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: { min: 0 },
                legend: { enabled: false },
                tooltip: {
                pointFormatter: function () {
                    return Highcharts.numberFormat(this.y, 1) + ' 억';
                }
                },
                series: [{
                pointWidth: 20,
                color: {
                    linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                    stops: [
                    [0, '#1673DA'],
                    [1, '#72ADEE']
                    ]
                },
                groupPadding: 0,
                data: chartData
                }]
            });
        }
    });
}
document.querySelector('#netIncomeRank').addEventListener('click', function(e){
    e.preventDefault();
    ifTopNetIncome();
});

// 보통주 자기주식취득수량 상위
function ifTopTreasuryStock(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopTreasuryStock',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;            
            const info = json.DataList || [];
            const $tbody = $('.modal_selfStockRank tbody').empty();
        
            info.forEach((item, idx) => {
                const amtNum = item.change_qy_acqs || 0;
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="self_stock_rate">${amtNum}주</td>
                </tr>`;
                $tbody.append(row);
            });
        
            const chartPoints = info.map(item => ({
                name: item.corp_name || '-',
                y: Number((item.change_qy_acqs || '0').replace(/,/g, ''))
            }));
        
            Highcharts.chart('inSelfStockRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                    min: 0,
                    labels: { formatter(){ return Highcharts.numberFormat(this.value, 0); } }
                },
                legend: { enabled: false },
                tooltip: {
                    headerFormat: '<b>{point.key}</b><br/>',
                    pointFormat: '<b>{point.y:,.0f}주</b>'   // 표시만 쉼표 포맷
                },
                plotOptions: {
                    series: { borderWidth: 0, groupPadding: 0 },
                    column: { pointWidth: 20 }
                },
                series: [{
                    name: '비율',
                    color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                    data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
      });
}
document.querySelector('#selfStockRank').addEventListener('click', function(e){
    e.preventDefault();
    ifTopTreasuryStock();    
});

// 소액주주비율 상위
function IfTopMinorityShareholders(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopMinorityShareholders',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;            
            const info = json.DataList || [];
            const $tbody = $('.modal_minorShareholdersRank tbody').empty();
        
            info.forEach((item, idx) => {
                const amtNum = Number(item.hold_stock_rate) || 0;
                const amtTxt = amtNum.toLocaleString();
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="hold_stock_rate">${amtTxt}%</td>
                </tr>`;
                $tbody.append(row);
            });
        
            const chartPoints = info.map(item => ({
                name: item.corp_name || '-',
                y: Number(item.hold_stock_rate) || 0
            }));
        
            Highcharts.chart('inMinorShareholdersRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                    min: 0,
                    labels: { formatter(){ return Highcharts.numberFormat(this.value, 0); } }
                },
                legend: { enabled: false },
                tooltip: {
                    headerFormat: '<b>{point.key}</b><br/>',
                    pointFormat: '<b>{point.y:,.0f}%</b>'   // 표시만 쉼표 포맷
                },
                plotOptions: {
                    series: { borderWidth: 0, groupPadding: 0 },
                    column: { pointWidth: 20 }
                },
                series: [{
                    name: '비율',
                    color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                    data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
document.querySelector('#minorShareholdersRank').addEventListener('click', function(e){
    e.preventDefault();
    console.log('소액주주비율 상위');
    IfTopMinorityShareholders();    
});
// 상장자회사수 상위
function IfTopListedSubsidiaries(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopListedSubsidiaries',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;            
            const info = json.DataList || [];
            const $tbody = $('.modal_listedSubsidiariesRank tbody').empty();
            // <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.unityGrupNm || '-'}</a></td>
            info.forEach((item, idx) => {
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>                
                    <td class="left">${item.unityGrupNm || '-'}</td>
                    <td class="cdpnyLstCo">${item.cnt}개</td>
                </tr>`;
                $tbody.append(row);
            });
        
            const chartPoints = info.map(item => ({
                name: item.unityGrupNm || '-',
                y: Number(item.cnt) || 0
            }));
        
            Highcharts.chart('inListedSubsidiariesRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                    min: 0,
                    labels: { formatter(){ return Highcharts.numberFormat(this.value, 0); } }
                },
                legend: { enabled: false },
                tooltip: {
                    headerFormat: '<b>{point.key}</b><br/>',
                    pointFormat: '<b>{point.y:,.0f}개</b>'   // 표시만 쉼표 포맷
                },
                plotOptions: {
                    series: { borderWidth: 0, groupPadding: 0 },
                    column: { pointWidth: 20 }
                },
                series: [{
                    name: '개수',
                    color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                    data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
document.querySelector('#ListedSubsidiariesRank').addEventListener('click', function(e){
    e.preventDefault();
    console.log('상장자회사수 상위');
    IfTopListedSubsidiaries();    
});

// 최대 주주와 특수 관계인 지분율
function IfTopMajorOwnership(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopMajorOwnership',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;            
            const info = json.DataList || [];
            console.log(info);
            const $tbody = $('.modal_majorOwnershipRank tbody').empty();
        
            info.forEach((item, idx) => {
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="trmend_posesn_stock_qota_rt">${item.trmend_posesn_stock_qota_rt}%</td>
                </tr>`;
                $tbody.append(row);
            });
        
            const chartPoints = info.map(item => {
                const pct = parseFloat(String(item.trmend_posesn_stock_qota_rt).replace('%','')) || 0;
                const amt = Number(item.amt_order) || 0;
                return {
                  name: item.corp_name || '-',
                  y: pct,
                  _amt: amt
                };
            });
        
            Highcharts.chart('inMajorOwnershipRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                  min: 0,
                  title: { text: '지분율(%)' },
                  labels: { format: '{value}%' }
                },
                legend: { enabled: false },
                plotOptions: {
                  series: { borderWidth: 0, groupPadding: 0 },
                  column: { pointWidth: 20 }
                },
                tooltip: {
                  headerFormat: '<span style="font-size:12px"><b>{point.name}</b></span><br/>',
                  pointFormatter: function () {
                    const pct = Highcharts.numberFormat(this.y, 2) + '%';
                    const amt = Highcharts.numberFormat(this._amt, 0);
                    return `지분율: <b>${pct}</b><br/>금액: <b>${amt}</b>`;
                  }
                },
                series: [{
                  name: '지분율',
                  color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                  data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
document.querySelector('#majorOwnershipRank').addEventListener('click', function(e){
    e.preventDefault();
    console.log('최대 주주와 특수 관계인 지분율');
    IfTopMajorOwnership();    
});

// 보통주 무상증자 금액이 많은 기업 TOP 10
function IfTopBonusIssue(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopBonusIssue',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;        
            const info = json.DataList || [];
            const $tbody = $('.modal_bonusIssueRank tbody').empty();
        
            info.forEach((item, idx) => {
                const amtNum = Number(String(item.own_stock_amount ?? '0').replace(/[^\d.-]/g, '')) || 0;
                const formattedAmt = amtNum.toLocaleString();
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="bonus_issue_amount">${formattedAmt}원</td>
                </tr>`;
                $tbody.append(row);
            });

            const chartPoints = info.map(item => {
                return {
                  name: item.corp_name || '-',
                  y: Number((item.own_stock_amount || '0').replace(/,/g, ''))
                };
                // const pct = parseFloat(String(item.own_stock_rate).replace('%','')) || 0;
                // const amt = Number(item.amt_order) || 0;
                // return {
                //   name: item.corp_name || '-',
                //   y: pct,
                //   _amt: amt
                // };
            });
        
            Highcharts.chart('inBonusIssueRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                  min: 0,
                  title: { text: '증자금액' },
                  labels: {
                    formatter: function () {
                      return Highcharts.numberFormat(this.value, 0);
                    }
                  }
                },
                legend: { enabled: false },
                plotOptions: {
                  series: { borderWidth: 0, groupPadding: 0 },
                  column: { pointWidth: 20 }
                },
                tooltip: {
                  headerFormat: '<span style="font-size:12px"><b>{point.name}</b></span><br/>',
                  pointFormatter: function () {
                    const amt = Highcharts.numberFormat(this.y, 0);
                    return `증자금액: <b>${amt}</b>`;
                  }
                },
                series: [{
                  name: '증자 비율',
                  color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                  data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
document.querySelector('#bonusIssueRank').addEventListener('click', function(e){
    e.preventDefault();
    console.log('보통주 무상증자 금액이 많은 기업 TOP 10');
    IfTopBonusIssue();
});

// 국민연금 출자 순위 TOP 10
function IfTopNPSInvestedCompanies(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopNPSInvestedCompanies',
        data: { bsns_year: lastYear },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            const info = json.DataList || [];
            console.log(info);
            const $tbody = $('.modal_npsInvestedCompaniesRank tbody').empty();
        
            info.forEach((item, idx) => {
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="nps_invested_amt">${item.stkrt}%</td>
                </tr>`;
                $tbody.append(row);
            });
            const chartPoints = info.map(item => {
                // const pct = parseFloat(String(item.amt_order).replace('%','')) || 0;
                const amt = Number(item.stkrt) || 0;
                return {
                  name: item.corp_name || '-',
                  y: amt,
                };
            });
        
            Highcharts.chart('inNpsInvestedCompaniesRank', {                
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                  min: 0,
                  title: { text: '지분율' },
                  labels: {
                    formatter: function () {
                      return Highcharts.numberFormat(this.value, 0) + '%';
                    }
                  }
                },
                legend: { enabled: false },
                plotOptions: {
                  series: { borderWidth: 0, groupPadding: 0 },
                  column: { pointWidth: 20 }
                },
                tooltip: {
                  headerFormat: '<span style="font-size:12px"><b>{point.name}</b></span><br/>',
                  pointFormatter: function () {
                    const pct = Highcharts.numberFormat(this.y, 2) + '%';
                    return `지분율: <b>${pct}`;
                  }
                },
                series: [{
                  name: '지분율',
                  color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                  data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
document.querySelector('#npsInvestedCompaniesRank').addEventListener('click', function(e){
    e.preventDefault();
    IfTopNPSInvestedCompanies();
});
// 정규직 근로자 수 TOP 10
function IfTopPermanentEmployee(){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopPermanentEmployee',
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            const info = json.DataList || [];
            console.log(info);
            const $tbody = $('.modal_permanentEmployeeRank tbody').empty();
            info.forEach((item, idx) => {
                const row = `
                <tr>
                    <td class="no">${idx + 1}</td>
                    <td class="left"><a href="${item.corp_code ? `/detail/${item.corp_code}` : '#'}" target="_blank">${item.corp_name || '-'}</a></td>
                    <td class="permanent_employee_amt">${Number(item.total_rgllbr_co).toLocaleString()}명</td>
                </tr>`;
                $tbody.append(row);
            });
            const chartPoints = info.map(item => {
                const amt = Number(item.total_rgllbr_co) || 0;
                return {
                  name: item.corp_name || '-',
                  y: amt,
                };
            });
            Highcharts.chart('inPermanentEmployeeRank', {
                chart: { type: 'column' },
                xAxis: { type: 'category' },
                yAxis: {
                  min: 0,
                  title: { text: '정규직 근로자 수' },
                  labels: {
                    formatter: function () {
                      return Highcharts.numberFormat(this.value, 0) + '명';
                    }
                  }
                },
                legend: { enabled: false },
                plotOptions: {
                  series: { borderWidth: 0, groupPadding: 0 },
                  column: { pointWidth: 20 }
                },
                tooltip: {
                  headerFormat: '<span style="font-size:12px"><b>{point.name}</b></span><br/>',
                  pointFormatter: function () {
                    const amt = Highcharts.numberFormat(this.y, 0) + '명';
                    return `정규직 근로자 수: <b>${amt}`;
                  }
                },
                series: [{
                  name: '정규직 근로자 수',
                  color: {
                        linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 },
                        stops: [[0, '#1673DA'], [1, '#72ADEE']]
                    },
                  data: chartPoints
                }]
            });
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
// document.querySelector('#permanentEmployeeRank').addEventListener('click', function(e){
//     e.preventDefault();
//     console.log('정규직 근로자 수 TOP 10');
//     IfTopPermanentEmployee();
// });