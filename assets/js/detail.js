function getCorpCodeFromURL() {
    const segs = location.pathname.replace(/\/+$/,'').split('/');
    return decodeURIComponent(segs[segs.length - 1] || '');
}
let currentCorpCode = getCorpCodeFromURL();

const nowDate = new Date();
const lastYear = nowDate.getFullYear() - 1;

let currentPage = 1;
let pageSize = 10;

const clsMap = {
    Y:{label:"유",tooltip:"유가증권시장",class:"gr"},
    K:{label:"코",tooltip:"코스닥시장",  class:"pp"},
    N:{label:"넥",tooltip:"코넥스시장",  class:"bl"}
};

function formatNumber(num) {
    if (num == null || num === '') return '';
    const n = Number(num);
    return isNaN(n) ? '' : n.toLocaleString('ko-KR');
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

function getNowDateTime() {
    const now = new Date();  
    const year   = now.getFullYear();
    const month  = String(now.getMonth() + 1).padStart(2, '0');
    const day    = String(now.getDate()).padStart(2, '0');
    const hour   = String(now.getHours()).padStart(2, '0');
    const minute = String(now.getMinutes()).padStart(2, '0');
  
    return `${year}.${month}.${day} ${hour}:${minute}`;
}

// 기업 검색 자동완성
let isComposing   = false;   // 한글 조합 중
let selecting     = false;   // 자동완성 항목 선택 중
let debounceTimer = null;
let lastXhr       = null;

const $ipt  = $('.srch_ipt_wrap .input');
const $list = $('.atcmp_list');
const $cont = $('.atcmp_container');
const $dt_page = $('.detailpage');

// Down키 선택용
let activeIndex   = -1;
let userNavigated = false;

// 공통 선택 처리 (마우스/키보드 공용)
function handlePick($a){
    if (!$a || !$a.length) return;
    selecting = true;
  
    const corp_code = $a.data('code');
    const corp_name = $a.text();
  
    $ipt.val(corp_name);
  
    // 데이터 로딩 함수들 호출
    corpProfile(corp_code);                  // 회사명 및 대표이사
    corpDirector(corp_code);                 // 임원현황
    corpMajorShareholders(corp_code);
    corpCrossOwnership(corp_code);
    invest_info(corp_code);
    anomalyDetection(corp_code);             // 대주주변동내역
    specialRelationChange(corp_code);        // 특수관계인변동내역
    gongsiPageAjax(1, corp_code);            // 공시 안내
    corpProfit(corp_code);                   // 매출액 및 영업이익

    // 랭킹top10 조회
    _badgeSet = false;
    topRevenue(corp_code);
    topNetIncome(corp_code);

    // URL 갱신
    const newUrl = '/detail/' + encodeURIComponent(corp_code);
    if (history.pushState) {
      history.pushState({ corp_code }, '', newUrl);

      loadAISummary(corp_code);

    }
  
    // 자동완성 닫기
    $dt_page.removeClass('opensrch');
    $list.empty();
    $cont.hide();
  
    setTimeout(() => { selecting = false; }, 0);
}
  
// li 하이라이트 관리
function setActive(index){
    const $items = $list.find('li');
    $items.removeClass('active');
    if (index >= 0 && index < $items.length) {
        $items.eq(index).addClass('active')[0].scrollIntoView({ block: 'nearest' });
    }
    activeIndex = index;
}
  
// 검색 실행
function runSearch() {
    const keyword = $ipt.val().trim();
    if (!keyword) { $list.empty(); $cont.hide(); return; }
  
    if (lastXhr && lastXhr.readyState !== 4) lastXhr.abort();
  
    lastXhr = $.get('/api/SearchCorp', { corp_name: keyword }, function(json) {
        // 응답 도착 시점에 입력값이 바뀌었으면 무시
        if (keyword !== $ipt.val().trim()) return;
  
        if (json.status === '00' && json.DataList && json.DataList.length > 0) {
        const html = json.DataList.map(item =>
        `<li style="cursor:pointer;"><a href="#" data-code="${item.corp_code}">${item.corp_name}</a></li>`
        ).join('');
        $list.html(html);
        $cont.show();  
            // down키 안 눌렸으면 초기화
        if (!userNavigated) setActive(-1);
      } else {
        $list.empty();
        $cont.hide();
        if (!userNavigated) setActive(-1);
      }
    }).fail(function(_, status){
        if (status !== 'abort') {
            $list.empty();
            $cont.hide();
            if (!userNavigated) setActive(-1);
        }
    });
}


// IME
$ipt.on('compositionstart', () => { isComposing = true; });
$ipt.on('compositionend',  () => {
    isComposing = false;
    clearTimeout(debounceTimer);
    runSearch();
});
  
// 디바운스 검색
$ipt.on('input', function () {
    if (selecting) return;
    userNavigated = false;               // 새 입력 시작 네비 상태 리셋
    clearTimeout(debounceTimer);
    debounceTimer = setTimeout(runSearch, 100);
});

$ipt.on('keydown', function(e){
    if (isComposing) return;
  
    // ↓/↑ 직전에 예약·진행 중 검색 끊어 깜빡임 방지
    clearTimeout(debounceTimer);
    if (lastXhr && lastXhr.readyState !== 4) lastXhr.abort();
  
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
      $list.empty();
      $cont.hide();
      setActive(-1);
      userNavigated = false;
    }
});
  
// 마우스 선택
$(document).off('click', '.atcmp_list a'); // 기존 click 바인딩 제거(중복 방지)
$list.on('mousedown', 'a, li', function(e){
    selecting = true;
    e.preventDefault();
    e.stopPropagation();
  
    clearTimeout(debounceTimer);
    if (lastXhr && lastXhr.readyState !== 4) lastXhr.abort();
    const $target = $(e.target).is('a') ? $(e.target) : $(this).find('a').first();
    handlePick($target);
    return false;
});

corpProfile(currentCorpCode);               // 회사명 및 대표이사
corpDirector(currentCorpCode);              // 임원현황
corpMajorShareholders(currentCorpCode);     // 대주주
corpCrossOwnership(currentCorpCode);        // 타법인 출자 현황
invest_info(currentCorpCode);               // 지배구조 그래프
anomalyDetection(currentCorpCode);          // 대주주변동내역
specialRelationChange(currentCorpCode);     // 특수관계인변동내역
gongsiPageAjax(1, currentCorpCode);         // 공시 안내
corpProfit(currentCorpCode);                // 매출액
// 랭킹top10 조회
topRevenue(currentCorpCode);
topNetIncome(currentCorpCode);

// 회사명 및 대표이사
function corpProfile(corpCode) {                                        
    $.ajax({ 
        type:'GET', 
        url:'/api/IfCorpCompanyProfile', 
        data:{ corp_code: corpCode }, 
        dataType:'json', 
        cache:true 
    }).done(res => {
        $('.detail_top #corp_name').attr('data-corp-code', res.DataList[0].corp_code).html(res.DataList[0].corp_name + '<a href="#" class="btn_srch"></a>');
        $('#stk_id').attr('data-corp-stkid', res.DataList[0].stock_code);
        $('.corp_box .ceo').text(res.DataList[0].ceo_nm);

        const stk_id = $('#stk_id').attr('data-corp-stkid');

        latestNews(stk_id);             //종목 뉴스
        latestInfoStock(stk_id);        //당일 주가
        threeMntInfoStock(stk_id);      //최근 3개월 주가
        
    });
}

// 임원현황
function corpDirector(corpCode) {
    $.ajax({ 
        type:'GET', 
        url:'/api/IfCorpExecutive', 
        data:{ corp_code: corpCode }, 
        dataType:'json', 
        cache:true 
    }).done(res => {
        const directors = [];        
        // 미등기임원 수 (성별제공X)
        const mideungi_total = res.DataList.mideungi_count;  
        // 등기임원 수 (성별제공o)
        const deungi_total = res.DataList.result.length;
        // 등기임원 성별 count
        let deungi_men = 0, deungi_women = 0;

        res.DataList.result.forEach(item => {
            if (item.sexdstn === '남') deungi_men++;
            else if (item.sexdstn === '여') deungi_women++;
            const name = item.nm || '';
            const typeRaw = item.rgist_exctv_at || ''; // '사내이사', '사외이사'
            const beginDate = item.tenure_start_on.replace(/^(\d{4})-(\d{2})-(\d{2})/, '$1.$2.$3');            
            directors.push({ type: typeRaw, name, date: beginDate ? (beginDate) : '' });
            if (directors.length === 3) return;
        });

        const $ul = $('.executives_list_ul');

        for (let i = 0; i < 3; i++) {
            const d = directors[i];
            console.log(d);
            const label = d ? d.type : '이사';
            const name = d ? d.name : '-';
            const date = d ? d.date : '';
            $ul.children('li').eq(i).html(
              `· ${label} ${name} <div class="date">${date}</div>`
            );
        }
        const $dg = $('.executives_list .inbar.deungi');
        $dg.attr('data-val', deungi_total);
        $dg.find('.txt').text(`등기임원 ${deungi_total}명 (남자 ${deungi_men}, 여자 ${deungi_women})`);
        $dg.find('.bar.malebar').attr('data-val', deungi_men);
        $dg.find('.bar.femalebar').attr('data-val', deungi_women);

        const $mdg = $('.executives_list .inbar.mideungi');
        $mdg.attr('data-val', mideungi_total);
        $mdg.find('.txt').text(`미등기임원 ${mideungi_total}명`);
        $mdg.find('.bar.malebar').attr('data-val', mideungi_total);
        $mdg.find('.bar.femalebar').attr('data-val', 0);

        document.querySelectorAll('.inbar').forEach(inbar => {
            const total = parseInt(inbar.dataset.val || '0', 10) || 0;
            const maleBar = inbar.querySelector('.malebar');
            const femaleBar = inbar.querySelector('.femalebar');

            const maleVal = parseInt(maleBar?.dataset.val || '0', 10) || 0;
            const femaleVal = parseInt(femaleBar?.dataset.val || '0', 10) || 0;

            const malePercent = total ? (maleVal / total) * 100 : 0;
            const femalePercent = total ? (femaleVal / total) * 100 : 0;

            gsap.to(maleBar, {
            width: malePercent + '%',
            duration: 1,
            ease: 'power2.out'
            });

            gsap.to(femaleBar, {
            width: femalePercent + '%',
            duration: 1,
            ease: 'power2.out',
            delay: 0.2
            });
        });
    });
}

// 대주주
function corpMajorShareholders(corpCode) {
    $.ajax({ 
        type:'GET', 
        url:'/api/IfCorpMajorShareholders', 
        data:{ corp_code: corpCode }, 
        dataType:'json', 
        cache:true 
    }).done(res => {
        const rows = Array.isArray(res?.DataList) ? res.DataList : [];
        if (!rows.length) {
            Highcharts.chart('topChart', { title: { text: null }, series:[{ data: [] }] });
            $('.chart_wrap .info_wrap ul').empty().append('<li><div class="name">데이터 없음</div></li>');
                return;
        }

        // 회사명
        const centerLabel = rows[0]?.corp_name || '';
        // graph color
        const palette = ['#4584E0','#FEC96B','#FD9074','#9D72D0','#4CC3B3','#7E8EF1','#F28C28','#56B870'];
        // chart data
        let sumHolderRate = 0;

        // 전체 합 계산 (모든 행 포함)
        rows.forEach(item => {
            sumHolderRate += parseFloat(item.trmend_posesn_stock_qota_rt ?? 0);
        });

        // 기본 데이터
        let seriesData = rows.map((item, idx) => ({
            name: item.nm || '-',
            y: Number.isFinite(parseFloat(item.trmend_posesn_stock_qota_rt))
                ? parseFloat(item.trmend_posesn_stock_qota_rt)
                : 0,
            color: palette[idx % palette.length]
        }));

        // 기타 추가 (100 - 전체합)
        const remain = 100 - sumHolderRate;
        if (remain > 0) {
            seriesData.push({
                name: '기타',
                y: Number.isFinite(remain) ? remain : 0,
                color: palette[seriesData.length % palette.length]
            });
        }

        // 오른쪽 리스트
        const $ul = $('.chart_wrap .info_wrap ul').empty();
        seriesData.forEach(d => {
            const li = `
                <li>
                <div class="dot" style="background:${d.color}"></div>
                <div class="name">${d.name}</div>
                <div class="val">${d.y.toFixed(2)}%</div>
                </li>`;
            $ul.append(li);
        });

        // 차트
        Highcharts.chart('topChart', {
        chart: {
            type: 'pie',
            backgroundColor: 'transparent',
            plotBackgroundColor: 'transparent',
            height: '280px',
            custom: {},
            events: {
                render() {
                    const chart = this, series = chart.series[0];
                    let customLabel = chart.options.chart.custom.label;
                    if (!customLabel) {
                    customLabel = chart.options.chart.custom.label =
                        chart.renderer.label(centerLabel)
                        .css({ color:'#000', textAnchor:'middle' })
                        .add();
                    } else {
                    customLabel.attr({ text: centerLabel });
                    }
                    const x = series.center[0] + chart.plotLeft;
                    const y = series.center[1] + chart.plotTop - (customLabel.attr('height') / 2);
                    customLabel.attr({ x, y });
                }
            }
        },
        accessibility: { point: { valueSuffix: '%' } },
        tooltip: { pointFormat: '{point.y:.2f}%' },
        legend: { enabled: false },
        plotOptions: {
            series: {
            allowPointSelect: true,
            cursor: 'pointer',
            borderRadius: 5,
            dataLabels: [{
                enabled: true,
                overflow: 'none',
                distance: -25,
                format: '{point.y:.2f}%',
                crop: false,
                style: { fontSize: '12px', color:'#000', textOutline: '{point.color}' }
            }],
                showInLegend: true
            }
        },
        series: [{
            colorByPoint: false,  // 우리가 주는 color 사용
            innerSize: '60%',
            size: '100%',
            data: seriesData
        }]
        });
    });
}    

// 지배구조 그래프
function invest_info(corpCode){
    $.ajax({
        type : 'GET',
        url  : '/api/IfGovernanceGraph',
        data:{ corp_code: corpCode, detail_flag: 'Y' },
        dataType : 'json',
        cache: true,
        success: function (json) {
            $ipt.val('').blur();
            if (json.status !== '00') {
                $('.detail_map_wrap').css('display', 'none');
                return;
            }
            $('.detail_map_wrap').css('display', 'block');
            let formatted_date = '';
            if(json.DataList.Out_corp_list.length) {
                const raw = json.DataList.Out_corp_list[0].stlm_dt;
                const [y, m, d] = raw.split('-');
                formatted_date = `${y}년 ${m}월 ${d}일`;
            } else {
                formatted_date = '';
            }
           
            $('.detail_map .map_corp').html(`<div class="sort ${clsMap[json.DataList.In_corp_list[0].corp_cls].class}">
                                            ${clsMap[json.DataList.In_corp_list[0].corp_cls].label}<div class="tooltip">
                                            ${clsMap[json.DataList.In_corp_list[0].corp_cls].tooltip}</div></div>
                                            <div class="name">${json.DataList.In_corp_list[0].corp_name}</div>`);
            $('.detail_map .map_header .date').text(`${formatted_date} 기준`);

            $('.detail_map .map_list.left .cell_wrap').find('.cell').remove();

            const $wrap = $('.detail_map .map_list.left .cell_wrap');
            let majorHtml = '';
            let otherHtml = '';
            let majorCount = 0;
            console.log(json.DataList.In_corp_list);
            json.DataList.In_corp_list.forEach(item => {
                const clsKey = item._corp_cls || '';
                const m = clsMap[clsKey] || { label: '', tooltip: '', class: '' };
                const detail_href = (item._corp_code && clsKey !== 'E') ? `/detail/${item._corp_code}` : null;
                const detail_href_link = (item._corp_code && clsKey !== 'E') ? `<a href="${detail_href}" class="link link_show" target="_blank"></a>` 
                                        : '';
                const sortHtml = (clsKey && clsKey !== 'E')
                                ? `<div class="sort ${m.class}">
                                    ${m.label}
                                    <div class="tooltip">${m.tooltip}</div>
                                </div>`
                                : '';
                
                if(item.holder_type == '대주주'){
                    majorCount++;
                    majorHtml += `
                        ${majorCount === 1 ? '<div class="vbar"></div>' : ''}
                        <div class="cell top">                            
                            ${majorCount === 1 ? '<div class="intit">5%이상 대주주</div>' : ''}
                            ${sortHtml}
                            <div class="txt_wrap">
                                <div class="name"><p>${item.nm}</p>${detail_href_link}</div>
                                <div class="val"><span>${item.stkrt}%</span></div>
                            </div>
                        </div>
                    `;
                }else{                    
                    otherHtml += `
                        <div class="cell">
                            ${sortHtml}
                            <div class="txt_wrap">
                            <div class="name"><p>${item.nm}</p>${detail_href_link}</div>                            
                            <div class="val"><span>${item.stkrt}%</span></div>
                            </div>
                        </div>`;
                }
            });
            if (majorCount === 0) {
                otherHtml = `<div class="vbar"></div>` + otherHtml;
            }
            $wrap.html(majorHtml + otherHtml);
            
            $('.detail_map .map_list.right .cell_wrap').find('.cell').remove();  
            json.DataList.Out_corp_list.forEach(item => {
                const clsKey = item._corp_cls || '';
                const m = clsMap[clsKey] || { label: '', tooltip: '', class: '' };
                const detail_href = (item._corp_code && clsKey !== 'E') ? `/detail/${item._corp_code}` : null;
                const detail_href_link = (item._corp_code && clsKey !== 'E') ? `<a href="${detail_href}" class="link link_show" target="_blank"></a>` 
                                        : '';
                const sortHtml = (clsKey && clsKey !== 'E')
                                ? `<div class="sort ${m.class}">
                                    ${m.label}
                                    <div class="tooltip">${m.tooltip}</div>
                                </div>`
                                : '';
                $('.detail_map .map_list.right .cell_wrap').append(`
                    <div class="cell">
                    ${sortHtml}
                    <div class="txt_wrap">
                        <div class="name"><p>${item.inv_prm}</p>${detail_href_link}</div>                          
                        <div class="val"><span>${item.trmend_blce_qota_rt}%</span></div>
                    </div>
                    </div>
                `);
            });

            $(".vbar").each(function() {
                const $bar = $(this);          
                const $nextCell = $bar.next();
                const top = $nextCell.outerHeight() / 2;
                const $parentWrap = $bar.closest('.cell_wrap');  // 부모 cell_wrap
                const $lastCell = $parentWrap.find('.cell').last(); 
                const bot = $lastCell.outerHeight() / 2;       // bottom 위치 계산
                console.log(top)
                $bar.css({
                    top: top + "px",
                    height: "calc(100% - " + (top + bot) + "px)"
                })
            }); 

            $et.on("click",".detail_map_wrap .btn_more",function(e){
                e.preventDefault();
                var $this = $(this);
                var $wrap = $this.closest(".detail_map_wrap");
                if($wrap.hasClass('open')){
                    $wrap.removeClass('open');
                    $this.removeClass('v')
                    $this.html('더보기');
                }else{
                    $wrap.addClass('open');
                    $this.addClass('v')
                    $this.html('접기');
                }
                scrollToElement('.detail_map_wrap')
            })
        },
        error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}

// 법인등록번호 포맷
function formatJurirNo(val) {
    if (!val) return '-';
    const clean = val.replace(/\D/g, '');
    if (clean.length === 13) {
        return clean.replace(/(\d{6})(\d{7})/, '$1-$2');
    }
    return clean;
}

// 기업개황정보(모달)
function corpInfo(corpCode) {
    $.ajax({
        type:'GET',
        url:'/api/ifCorpInfo',
        data:{ corp_code: corpCode },
        dataType:'json',
        cache:true
    }).done(res => {
        const info = res.DataList[0];
        $('.modal_corpInfo .corp_name').text(info.corp_name ? info.corp_name : '-');
        $('.modal_corpInfo .corp_name_eng').text(info.corp_name_eng ? info.corp_name_eng : '-');
        $('.modal_corpInfo .stock_name').text(info.stock_name ? info.stock_name : '-');
        $('.modal_corpInfo .stock_code').text(info.stock_code ? info.stock_code : '-');
        $('.modal_corpInfo .ceo_nm').text(info.ceo_nm ? info.ceo_nm : '-');
        $('.modal_corpInfo .corp_cls').text(info.corp_cls ? clsMap[info.corp_cls].tooltip : '-');
        $('.modal_corpInfo .jurir_no').text(info.jurir_no ? info.jurir_no.replace(/(\d{6})(\d{7})/, '$1-$2') : '-');
        $('.modal_corpInfo .bizr_no').text(info.bizr_no ? info.bizr_no.replace(/(\d{3})(\d{2})(\d{5})/, '$1-$2-$3') : '-');
        $('.modal_corpInfo .adres').text(info.adres ? info.adres : '-');
        $('.modal_corpInfo .hm_url').text(info.hm_url ? info.hm_url : '-');
        $('.modal_corpInfo .ir_url').text(info.ir_url ? info.ir_url : '-');
        $('.modal_corpInfo .phn_no').text(info.phn_no ? info.phn_no : '-');
        $('.modal_corpInfo .fax_no').text(info.fax_no ? info.fax_no : '-');
        $('.modal_corpInfo .induty_code').text(info.INDEX_TYPE_NM ? info.INDEX_TYPE_NM : '-');
        $('.modal_corpInfo .est_dt').text(info.est_dt ? info.est_dt.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3') : '-');
        $('.modal_corpInfo .acc_mt').text(info.acc_mt ? info.acc_mt + '월' : '-');
    });
}

// 타법인출자현황(모달)
function corpCrossOwnership(corpCode){
    console.log(corpCode);
    $.ajax({
        type : 'GET',
        url  : '/api/IfCorpCrossOwnership',
        data:{ corp_code: corpCode },
        dataType : 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') {return};            
            const info = json.DataList;
            const $tbody = $('.modal_otrCprInvstmnt tbody');
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

// 대주주 변동 내역
function anomalyDetection(corpCode) {
    $.ajax({
        type:'GET',
        url:'/api/IfAnomalyDetection',
        data:{ corp_code: corpCode, relation_flag: 'MS' },
        dataType:'json',
        cache:true
    }).done(res => {
        const info = res.DataList;
        const $tbody = $('.shareholder_table tbody');
        if (res.status && res.status !== '00') {            
            $tbody.html(`
                <tr><td colspan="10" class="text-center">변동 내역이 없습니다.</td></tr>
            `); return;
        }     
        $tbody.empty();
        info.forEach((item, idx) => {            
            const row = `
                <tr onclick="window.open('https://dart.fss.or.kr/dsaf001/main.do?rcpNo=${item.rcept_no}', '_blank', 'width=800,height=1000,scrollbars=yes,resizable=yes');" style="cursor:pointer;">
                    <td class="num">${idx + 1 || '-'}</td>                    
                    <td class="repror">${item.repror || '-'}</td>
                    <td class="rcept_dt">${item.rcept_dt ? item.rcept_dt.replace(/-/g, '.') : '-'}</td>
                    <td class="stkqy">${item.stkqy || '-'}</td>
                    <td class="stkqy_irds">${item.stkqy_irds || '-'}</td>
                    <td class="stkrt">${item.stkrt || '-'}</td>
                    <td class="stkrt_irds">${item.stkrt_irds || '-'}</td>
                    <td class="ctr_stkqy">${item.ctr_stkqy || '-'}</td>
                    <td class="ctr_stkrt">${item.ctr_stkrt || '-'}</td>
                    <td class="report_resn">${item.report_resn || '-'}</td>
                </tr>
            `;
            $tbody.append(row);
        });
    });
}

// 특수관계인 변동 내역
function specialRelationChange(corpCode) {
    loader.s();
    $.ajax({
        type:'GET',
        url:'/api/IfAnomalyDetection',
        data:{ corp_code: corpCode, relation_flag: 'SR' },
        dataType:'json',
        cache:true
    }).done(res => {
        loader.e();
        const $tbody = $('.affiliated_change_table tbody');       
        if (res.status && res.status !== '00') {            
            $tbody.html(`
                <tr><td colspan="10" class="text-center">변동 내역이 없습니다.</td></tr>
            `); return;
        }
        const info = res.DataList;   
        $tbody.empty();
        info.forEach((item, idx) => {
            const row = `
                <tr>
                    <td class="num">${idx + 1 || '-'}</td>
                    <td class="stlm_dt">${item.stlm_dt ? item.stlm_dt.replace(/-/g, '.') : '-'}</td>
                    <td class="nm">${item.nm || '-'}</td>
                    <td class="relate">${item.relate || '-'}</td>
                    <td class="stock_knd">${item.stock_knd || '-'}</td>
                    <td class="bsis_posesn_stock_co">${item.bsis_posesn_stock_co || '-'}</td>
                    <td class="bsis_posesn_stock_qota_rt">${item.bsis_posesn_stock_qota_rt || '-'}</td>
                    <td class="trmend_posesn_stock_co">${item.trmend_posesn_stock_co || '-'}</td>
                    <td class="trmend_posesn_stock_qota_rt">${item.trmend_posesn_stock_qota_rt || '-'}</td>                    
                    <td class="report_resn">${item.rm || '-'}</td>
                </tr>
            `;
            $tbody.append(row);
        });
    });
}

// 최신 주가
function latestInfoStock(stk_id) {
    $.ajax({
        type:'GET',
        url:'/krxdata/import_stk_info',
        data:{ stk_id: stk_id },
        dataType:'json',
        cache:true
    }).done(res => {
        if(res.DataList.Error) { $('.detail_add').hide(); return; }
        $('.detail_add').show();
        const stkType = res.DataList.STK_TPCD;
        const stkTypeMap = {
            '1': '유가증권',
            '2': '코스닥'
        };        
        const stkTypeText = stkTypeMap[stkType] || '-';
        const changeRate = res.DataList.CHAGE_RATE;  // -20 또는 2.15
        // up/down
        const $rateInfo = $('.stock_info_box .rate_info');
        if (String(changeRate).trim().startsWith('-')) {
            // 음수: 하락
            $rateInfo.removeClass('up').addClass('down');
        } else {
            // 양수 또는 0: 상승
            $rateInfo.removeClass('down').addClass('up');
        }
        console.log(res.DataList);
        $('.detail_add .date').text(getNowDateTime());
        $('.stock_info_box .sort_wrap .badge').first().html(stkTypeText);
        $('.stock_info_box .sort_wrap .badge').last().html(res.DataList.BIZNAME);
        $('.stock_info_box .name').text(res.DataList.STK_KNM + ' (' + res.DataList.STK_CD + ')');
        $('.stock_info_box .rate_info .today span').text(formatNumber(res.DataList.DEALLING_PRICE));
        $('.stock_info_box .rate_info .no_exday .point span').eq(0).text(formatNumber(res.DataList.COMPARE_YESTERDAY_PRICE));
        $('.stock_info_box .rate_info .no_exday .point').eq(1).text(res.DataList.CHAGE_RATE + '%');  
        $('.stock_info_box .rate_info .add_info.col .YESTERDAY_ENDPRICE').text(Number(res.DataList.YESTERDAY_ENDPRICE).toLocaleString());      // 전일
        $('.stock_info_box .rate_info .add_info.col .MARKET_PRICE').text(Number(res.DataList.MARKET_PRICE).toLocaleString());                  // 시가
        $('.stock_info_box .rate_info .add_info.col .HIGH_PRICE').text(Number(res.DataList.HIGH_PRICE).toLocaleString());      // 현재 고가
        $('.stock_info_box .rate_info .add_info.col .LOW_PRICE').text(Number(res.DataList.LOW_PRICE).toLocaleString());      // 현재 저가
        $('.stock_info_box .rate_info .add_info .ACCUMULATED_DEALING_AMOUNT').text(formatNumber(res.DataList.ACCUMULATED_DEALING_AMOUNT));      // 거래량
        $('.stock_info_box .rate_info .add_info .ACCUMULATED_DEALING_PRICE').text(fmtAmountToBaekman(res.DataList.ACCUMULATED_DEALING_PRICE));        // 거래대금(백만단위)
    });
}

// 최근 3개월 주가
function threeMntInfoStock(stk_id) {
    $.ajax({
        type:'GET',
        url:'/krxdata/import_stk_3mnt',
        data:{ stk_id: stk_id },
        dataType:'json',
        cache:true
    }).done(res => {
        const threeMntData = res.DataList || [];
        $.ajax({
            type:'GET',
            url:'/krxdata/import_stk_info',
            data:{ stk_id: stk_id },
            dataType:'json',
            cache:true
        }).done(infoRes => {
            const latestRaw = infoRes.DataList;
            threeMntData.push(latestRaw);
            stockChartCreate(threeMntData);
        });
    });    
}

// 날짜변환
const parseYYYYMMDD = (s) => {
    if (!s) return null;
    const y = +s.slice(0, 4);
    const m = +s.slice(4, 6) - 1;
    const d = +s.slice(6, 8);
    return Date.UTC(y, m, d);
};
  
function stockChartCreate(rows) {
    if (!Array.isArray(rows)) return;
  
    const parsed = rows.map(r => ({
      t: parseYYYYMMDD(r.BIZDATE),                      // 날짜
      price: Number(r.DEALLING_PRICE),                  // 시가
      vol: Number(r.ACCUMULATED_DEALING_AMOUNT)         // 거래량(숫자)
    }))
    .filter(p => p.t && !isNaN(p.price))                // 유효값만
    .sort((a, b) => a.t - b.t);                         // 오름차순
  
    const closeData = parsed.map(p => [p.t, p.price]);  // [time, close]
    const volume    = parsed.map(p => [p.t, p.vol]);    // [time, vol]
  
    const threeMonths = 1000 * 60 * 60 * 24 * 90;
    const max = closeData.length ? closeData[closeData.length - 1][0] : null;
    const min = max ? (max - threeMonths) : null;
  
    Highcharts.stockChart('stock-chart', {
        stockTools: { gui: { enabled: false } },
        rangeSelector: { enabled: false },   // 기간 선택 UI 제거
        navigator: { enabled: false },       // navigator 제거
        scrollbar: { enabled: false },       // scrollbar 제거
        xAxis: {
            min,
            max,
            crosshair: { className: 'highcharts-crosshair-custom', enabled: true },
        },
        yAxis: [
            {
                title: { text: 'price' },
                labels: { align: 'left' },
                height: '70%'
            },
            {
                title: { text: 'volume' },
                labels:{ enabled: false },
                top: '70%',
                height: '30%',
                offset: 0
            }
        ],
        chart: {
            height :400, 
            backgroundColor: "transparent", 
            zooming: {
                mouseWheel: {
                    enabled: false // 마우스 휠 줌 비활성화
                }
            },
        },
        series: [
        {
            name: '',
            type: 'area',
            data: closeData,
            gapSize: 5,
            lineColor: '#8581f3',
            tooltip: {
                backgroundColor: '#333',   // 툴팁 배경 색
                borderColor: '#333',       // 툴팁 테두리 색
                borderRadius: 8,              // 모서리 둥글게
                style: {
                    color: '#ffffff',           // 툴팁 글자 색
                    fontSize: '13px',           // 글자 크기
                    fontWeight: 'bold'          // 글자 두께
                },
                pointFormatter: function () {
                return formatNumber(this.y); // ✅ 커스텀 콤마 함수
                },
                valueDecimals: 2
            },
            color: 'rgb(22,115,218)',   // 선 색상
            fillColor: {
                linearGradient: { x1: 0, y1: 0, x2: 0, y2: 1 }, // 위→아래 그라디언트
                stops: [
                    [0, 'rgb(199, 113, 243)'],
                    [1, 'rgba(76, 175, 254,0)']
                ]
            },
            threshold: null
        },
        {
            type: 'column',
            color: '#72adee',
            tooltip: {
                backgroundColor: '#333',   // 툴팁 배경 색
                borderColor: '#333',       // 툴팁 테두리 색
                borderRadius: 8,              // 모서리 둥글게
                style: {
                    color: '#ffffff',           // 툴팁 글자 색
                    fontSize: '13px',           // 글자 크기
                    fontWeight: 'bold'          // 글자 두께
                },
                pointFormatter: function () {
                return '거래량 : ' + formatNumber(this.y); // ✅ 커스텀 콤마 함수
                }
            },
            keys: ['x', 'y', 'className'],
            id: 'aapl-volume',
            data: volume,
            yAxis: 1
        }
      ]
    });
}


// 최신 종목 뉴스
function latestNews(stk_id) {
    $.ajax({
        type:'GET',
        url:'/krxdata/import_stk_atc',
        data:{ stk_id: stk_id },
        dataType:'json',
        cache:true
    }).done(res => {
        console.log(res);
        const $div = $('.news_list');
        if (res.status && res.status !== '00') {            
            $div.html(`
                <a href="javascript:void(0)"><div class="tit">최신 뉴스가 없습니다.</div></a>
            `); return;
        }
        const info = res.DataList;        
        $div.empty();
        info.forEach(item => {
            const row = `
                <a href="https://www.etoday.co.kr/news/view/${item.ATC_ID}" target="_blank" rel="noopener noreferrer">
                    <input type="hidden" class="atc_id" value="${item.ATC_ID}">
                    <input type="hidden" class="pto_id" value="${item.PTO_ID}">
                    <div class="tit">${item.ATC_TL_NM}</div>
                    <div class="date">${item.ATC_SRV_DT.replace(/^(\d{4})-(\d{2})-(\d{2})/, '$1.$2.$3')}</div>
                </a>
            `;
            $div.append(row);
        });

    });
}

// 공시 안내
function gongsiPageAjax(page, corpCode) {
    currentPage = page;
    $.ajax({
        type:'GET',
        url: '/api/IfDisclosureSearch',
        data:{ 
            corp_code: corpCode,
            page_no: currentPage,
            page_count: pageSize,
            fg: 'detail' 
        },
        dataType:'json',
        cache: false,
        success: function (json) {
            if (json.status && json.status !== '00') {
                $('.detail_notice_today').hide();
                return;
            }
            $('.detail_notice_today').show();
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

function renderTable(list, totalCount, pageNo, pageSize) {
    const $tbody = $('.detail_notice_today tbody');
    if (!Array.isArray(list) || list.length === 0) {
        $tbody.html('<tr><td colspan="6" class="text-center">데이터 없음</td></tr>');
        return;
    }
    // startNo desc
    const startNo = totalCount - (pageNo - 1) * pageSize;

    const rows = list.map((row, idx) => {     
        const no = startNo - idx                                // 번호 계산                                   
        const corpName = row.corp_name || '-';                  // 회사명
        const reportName = row.report_nm || '-';                // 보고서명                                       
        const submitter = row.flr_nm || '-';                    // 제출인                                        
        const rceptRaw = row.rcept_dt || '';                    // 접수일자        
        let   rceptDate = rceptRaw.replace(/(\d{4})(\d{2})(\d{2})/, '$1.$2.$3');

        return `
        <tr>
            <td>${no}</td>
            <td>${escapeHtml(corpName)}</td>
            <td class="left"><a href="https://dart.fss.or.kr/dsaf001/main.do?rcpNo=${row.rcept_no}" target="_blank" rel="noopener noreferrer">${escapeHtml(reportName)}</a></td>
            <td class="ai_summary_cell" data-rcept-no="${row.rcept_no}">-</td>
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
            console.error("AJAX Error Status:", status);
            console.error("Error Details:", error);
            console.error("Server Response:", xhr.responseText);
        },
        complete: function() {
            delete currentRequests[rceptNo];
        }
    });
}

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

function escapeHtml(str) {
    return String(str ?? '')
        .replaceAll('&','&amp;')
        .replaceAll('<','&lt;')
        .replaceAll('>','&gt;')
        .replaceAll('"','&quot;')
        .replaceAll("'",'&#39;');
}

$('#pagination').on('click', 'a', function(e) {
    e.preventDefault();
    const page = Number($(this).data('page'));
    const currentCorpCode = $('#corp_name').data('corp-code');
    if (!isNaN(page)) {
        gongsiPageAjax(page, currentCorpCode);
    }
});

// 매출액 및 영업이익(2020~2024) 
function corpProfit(corp_code){
    return $.ajax({ 
        type:'GET', 
        url:'/api/IfCorpRevenueProfit', 
        data:{ corp_code:corp_code, detail_flag: 'true' }, 
        dataType:'json', cache:true 
    }).done(res => {
        // 데이터가 없으면 섹션자체를 숨김처리
        if(res.status && res.status !== '00') {
            $('.detail_finance_item').hide();
            return;
        }
        const hasSales = res.DataList.some(item => /매출/.test(item.account_nm || ''));
        const hasOp    = res.DataList.some(item => /영업이익/.test(item.account_nm || ''));
        if(!(hasSales && hasOp)) {
            // 하나라도 없으면 섹션 숨기기
            $('.detail_finance_item').hide();
            return;
        }

        $('.detail_finance_item').show();
        console.log(res.DataList);
        const $container = $('.finance_item_wrap .inner_wrap');
        $container.empty();

        const byYear = {};
        res.DataList.forEach(item => {
            const y = item.bsns_year;
            if (!byYear[y]) byYear[y] = { sales: null, op: null };

            const amountRaw = String(item.amt_order || '');
            const amountNum  = amountRaw.replace(/[^0-9.-]/g, ''); // data-val용 숫자만
            const isSales = /매출/.test(item.account_nm || '');
            const isOp    = /영업이익/.test(item.account_nm || '');

            if (isSales) byYear[y].sales = amountNum;
            else if (isOp) byYear[y].op = amountNum;
        });

        Object.keys(byYear).sort((a,b)=>b.localeCompare(a)).forEach(year => {
            const { sales, op } = byYear[year];
            const salesVal = sales ?? '0';
            const opVal    = op    ?? '0';

            $container.append(
                `<div class="finace_item box">
                <div class="y">${year}</div>
                <dl class="val_wrap">
                    <dt>매출</dt>
                    <dd data-val="${salesVal}">0</dd>
                    <dt>영업이익</dt>
                    <dd data-val="${opVal}">0</dd>
                </dl>
                </div>`
            );
        });

        dataAni();
    });
}
function dataAni(){
    const nums = document.querySelectorAll('.detail_finance_item .val_wrap dd');
    const counter = { val: 0 };
    nums.forEach((num) =>{
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
corpProfit(currentCorpCode);    // 매출액 및 영업이익(2020~2024)

// modal
$(document).on('click', '.btn_rounded[data-modal="corpInfo"]', function(e) {
    e.preventDefault();
    modal.open('corpInfo');          // 모달 열기
    const corpCode = $('#corp_name').data('corp-code');
    corpInfo(corpCode);              // API 호출
});

// modal
$(document).on('click', '.btn_rounded[data-modal="otrCprInvstmnt"]', function(e) {
    e.preventDefault();
    modal.open('otrCprInvstmnt');       // 모달 열기
    const corpCode = $('#corp_name').data('corp-code');
    corpCrossOwnership(corpCode);       // API 호출
});


// ==========================================
// TOP 10 랭킹(매출액, 당기순이익)
// ==========================================
// 매출액 상위 10개
let _badgeSet = false;
function setIndustryBadge(text){
    if (!text || _badgeSet) return;
    const $h3 = $('.detail_rank h3');
    if ($h3.find('.badge').length === 0) $h3.append('<div class="badge"></div>');
    $h3.find('.badge').text(text);
    _badgeSet = true;
}

function topRevenue(corp_code){
    $.ajax({
        method: 'GET',
        url: '/api/IfTopRevenue',
        data: { bsns_year: lastYear, corp_code: corp_code, detail_flag: 'Y' },
        dataType: 'json',
        cache: false,
        success: function (json) {
            if (json && json.status && json.status !== '00') {
                $('#PureProfitRank').hide();
                $('#profitRank').empty(); return;
            }
            $('#PureProfitRank').show();
            console.log(json.DataList);
            const list = json.DataList.result;
            const me   = json.DataList.me;
            setIndustryBadge(list[0]?.INDEX_TYPE_NM || me?.INDEX_TYPE_NM);
          
            renderTopRevenue(list, $('#profitRank'), me);
        }, error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}
function renderTopRevenue(list, $ul, me) {
    $ul.empty();
    if (!Array.isArray(list) || list.length === 0) {
        $ul.append('<li class="empty"><div class="name">데이터가 없습니다</div></li>');
        return;
    }
    const maxVal = Math.max.apply(null, list.map(item => parseInt(item.amt_order, 10) || 0));

    list.forEach((item, idx) => {
        const num = idx + 1;
        const name = item.corp_name || '-';
        const val = parseInt(item.amt_order, 10) || 0;
        const data = Math.floor(val / 1e8).toLocaleString();   // 억단위
        const ratio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

        const li = `
            <li>
            <div class="num">${num}</div>
            <div class="name">${name}</div>
            <div class="bar_wrap">
                <div class="bar_inner">
                <div class="bar" data-val="${ratio}" style="width:0"></div>
                </div>
            </div>
            <div class="data">${data}</div>
            </li>
        `;
        $ul.append(li);       

        // 너비 애니메이션
        const $bar = $ul.find('li:last .bar');
        requestAnimationFrame(() => { $bar.css('width', ratio); });
    });
    // 자기 데이터가 있으면 추가
    if(me !== null) {
        var val = parseInt(me.amt_order, 10) || 0;
        const meData = Math.floor(val / 1e8).toLocaleString();   // 억단위
        const meRatio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

        const meLi = `
            <li class="me">
                <div class="num">-</div>
                <div class="name">${me.corp_name}</div>
                <div class="bar_wrap">
                    <div class="bar_inner">
                        <div class="bar" data-val="${meRatio}" style="width:0"></div>
                    </div>
                </div>
                <div class="data">${meData}</div>
            </li>
        `;
        $ul.append(meLi);
        const $bar = $ul.find('li:last .bar');
        requestAnimationFrame(() => { $bar.css('width', meRatio); });
    } else{
        $ul.append('<li class="me"><div class="num">-</div><div class="name">-</div><div class="bar_wrap"><div class="bar_inner"><div class="bar" data-val="0" style="width:0"></div></div></div><div class="data">-</div></li>'); 
    }
}

// 당기순이익 상위 10개
function topNetIncome(corp_code){
    $.ajax({
        method: 'GET',
        url: '/api/IfTopNetIncome',
        data: { bsns_year: lastYear, corp_code: corp_code, detail_flag: 'Y' },
        dataType: 'json',
        cache: false,
        success: function (json) {
            if (json && json.status && json.status !== '00') {
                $('#netIncomeRank').hide();
                $('#topNetIncomeRank').empty(); return;
            }
            $('#netIncomeRank').show();
            const list = json.DataList.result;
            const me   = json.DataList.me;
            setIndustryBadge(list[0]?.INDEX_TYPE_NM || me?.INDEX_TYPE_NM);
            renderTopNetIncome(list, $('#topNetIncomeRank'), me);

        }, error: function (xhr, status, error) {
            console.log(xhr + '|' + status + '|' + error);
        }
    });
}

function renderTopNetIncome(list, $ul, me) {
    $ul.empty();
    if (!Array.isArray(list) || list.length === 0) {
        $ul.append('<li class="empty"><div class="name">데이터가 없습니다</div></li>');
        return;
    }
    const maxVal = Math.max.apply(null, list.map(item => parseInt(item.amt_order, 10) || 0));

    list.forEach((item, idx) => {
        const num = idx + 1;
        const name = item.corp_name || '-';
        const val = parseInt(item.amt_order, 10) || 0;
        const data = Math.floor(val / 1e8).toLocaleString();   // 억단위
        const ratio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

        const li = `
            <li>
            <div class="num">${num}</div>
            <div class="name">${name}</div>
            <div class="bar_wrap">
                <div class="bar_inner">
                <div class="bar" data-val="${ratio}" style="width:0"></div>
                </div>
            </div>
            <div class="data">${data}</div>
            </li>
        `;
        $ul.append(li);       

        // 너비 애니메이션
        const $bar = $ul.find('li:last .bar');
        requestAnimationFrame(() => { $bar.css('width', ratio); });
    });

    if(me !== null) {
        var val = parseInt(me.amt_order, 10) || 0;
        const meData = Math.floor(val / 1e8).toLocaleString();   // 억단위
        const meRatio = maxVal > 0 ? (val / maxVal * 100).toFixed(1) + "%" : "0%";

        const meLi = `
            <li class="me">
                <div class="num">-</div>
                <div class="name">${me.corp_name}</div>
                <div class="bar_wrap">
                    <div class="bar_inner">
                        <div class="bar" data-val="${meRatio}" style="width:0"></div>
                    </div>
                </div>
                <div class="data">${meData}</div>
            </li>
        `;

        $ul.append(meLi);
        const $bar = $ul.find('li:last .bar');
        requestAnimationFrame(() => { $bar.css('width', meRatio); });
    } else {
        $ul.append('<li class="me"><div class="num">-</div><div class="name">-</div><div class="bar_wrap"><div class="bar_inner"><div class="bar" data-val="0" style="width:0"></div></div></div><div class="data">-</div></li>');        
    }
}

function loadAISummary(corpCode) {
    $('.detail_ai .top').text('AI분석 생성 중...');
    $('.detail_ai .desc').empty();
    
    $.ajax({
        url: '/llmsumy/corp_summary',
        type: 'POST',
        data: { corp_code: corpCode },
        dataType: 'json',
        success: function(response) {
            if (response.success) {
                const data = response.data;
                
                $('.detail_ai .top').text(data.corp_name + ' 지배구조 변동 및 그 의미 분석 보고서');
                $('.detail_ai .desc').html('<div class="tit">요약</div><div class="content"></div>');
                // $('.detail_ai .desc .content').text(data.final_summary);
                $('.detail_ai .desc .content').css('white-space', 'pre-wrap').text(data.final_summary.replace(/\\n/g, '\n'));
            } else {
                $('.detail_ai .top').text('AI분석 생성에 실패했습니다.');
            }
        },
        error: function(xhr, status, error) {
            console.error("AJAX Error Status:", status);
            console.error("Error Details:", error);
            console.error("Server Response:", xhr.responseText);
            $('.detail_ai .top').text('AI분석 생성 중 오류가 발생했습니다.');
        }
    });
}

$(document).ready(function() {
    const corpCode = window.location.pathname.split('/')[2];
    
    if (corpCode) {
        loadAISummary(corpCode);
    }
});
// ==========================================
// 모달 랭킹(매출액, 당기순이익)
// ==========================================
// 매출액 상위
function ifTopRevenue(corp_code){
    $.ajax({
        type: 'GET',
        url: '/api/IfTopRevenue',
        data: { bsns_year: lastYear, corp_code: corp_code, detail_flag: 'Y' },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            console.log(json.DataList.result);
            const info = json.DataList.result || [];
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
    var corp_code = $('#corp_name').attr('data-corp-code');
    ifTopRevenue(corp_code);
});

// 당기순이익 상위
function ifTopNetIncome(corp_code){
    console.log(corp_code);
    $.ajax({
        type: 'GET',
        url: '/api/IfTopNetIncome',
        data: { bsns_year: lastYear, corp_code: corp_code, detail_flag: 'Y' },
        dataType: 'json',
        cache: true,
        success: function (json) {
            if (json.status !== '00') return;
            const info = json.DataList.result || [];
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
    var corp_code = $('#corp_name').attr('data-corp-code');
    ifTopNetIncome(corp_code);
});