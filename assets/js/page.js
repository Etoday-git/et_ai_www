var $et = $("#etoday")

$(function(){
    $et.on('click','.headerWrap .btn_menu',function(e){
        $et.toggleClass('openmenu');
    })

    $et.on('click','.detail_top .btn_srch',function(){
        $et.toggleClass('opensrch')
    })

    const srchBox = document.querySelector('.srch_box');
    const inputEl = document.querySelector('.srch_ipt_wrap .input');
    srchBox.addEventListener('click', function(e) {
        if (e.target === inputEl || inputEl.contains(e.target)) {
            return;
        }
        $et.removeClass('opensrch')
        $('.atcmp_container').hide();
    });


    $(window).scroll(function() {
        if ($(window).scrollTop() > 10) {
            $et.addClass('scrolled')
        } else {
            $et.removeClass('scrolled')
        }
    });
    
    
})
window.addEventListener("resize", function () {
    const etoday = document.getElementById("etoday");
    if (etoday.classList.contains("openmenu")) {
        etoday.classList.remove("openmenu");
    }
});

function scrollToElement(selector, offsetRatio = 0.1) {
    const el = document.querySelector(selector);
    if (el) {
      const rect = el.getBoundingClientRect(); // 화면 기준 위치
      const absoluteTop = window.scrollY + rect.top; // 문서 기준 절대 위치
      const offset = window.innerHeight * offsetRatio; // 화면 높이의 10% 만큼 offset

      window.scrollTo({
        top: absoluteTop - offset,
        behavior: "smooth"
      });
    }
}

var modal = {
	close:function(obj){
		var $obj = $(".modal_"+obj);
		$obj.removeClass("on");
	},
	open:function(obj){
		var $obj = $(".modal_"+obj);
		$obj.addClass("on");
	}
}

var loader = {
	e:function(){
		$et.removeClass('loading')
	},
	s:function(){
		$et.addClass('loading')
	}
}


/* 메인 스크롤 뷰 액션 */
let hasAnimatedDash = false,
    hasAnimatedRank = false,
    hasAnimateddefin = false,
    hasAnimatedStock = false;

function checkIfInTopView() {
    const triggerPoint = window.innerHeight * 0.3; 
    if($et.hasClass('mainpage')){
        const target = document.querySelector('.main_dashboard');
        const target2 = document.querySelector('.main_ranking');
        const rect = target.getBoundingClientRect();
        const rect2 = target2.getBoundingClientRect();
        if (!hasAnimatedDash && rect.top <= triggerPoint) {
            dataAni();       
            hasAnimatedDash = true;
        }
        if (!hasAnimatedRank && rect2.top <= triggerPoint) {
            rankDataAni();
            // chartCreate();
            chartSpect();
            
            hasAnimatedRank = true;
        }
        if (window.scrollY > 100) {
            $(".scrollani").hide();
        }else{
            $(".scrollani").show();
        }
    }else if($et.hasClass('detailpage')){
        const target = document.querySelector('.detail_finance_item');
        const target2 = document.querySelector('.detail_rank');
        const target3 = document.querySelector('.detail_add');
        const rect = target.getBoundingClientRect();
        const rect2 = target2.getBoundingClientRect();
        const rect3 = target3.getBoundingClientRect();
        if (!hasAnimateddefin && rect.top <= triggerPoint) {
            dataAni();       
            hasAnimateddefin = true;
        }
        if (!hasAnimatedRank && rect2.top <= triggerPoint) {
            rankDataAni();
            hasAnimatedRank = true;
        }
        if (!hasAnimatedStock && rect3.top <= triggerPoint) {
            stockChartCreate();
            hasAnimatedStock = true;
        }

    }
}

const tooltip = document.createElement('div');
tooltip.className = 'custom-tooltip';
document.body.appendChild(tooltip);

function showTooltip(e, name, val1, val2) {
    tooltip.innerHTML = `
        <div class="tooltip-name">${name}</div>
        <div class="tooltip-val">${val1}<br>${val2}</div>
    `;
    tooltip.style.left = e.pageX + 12 + 'px';
    tooltip.style.top = e.pageY + 12 + 'px';
    tooltip.style.opacity = '1';
}
function hideTooltip() {
    tooltip.style.opacity = '0';
}

function tooltipEvt(){
    document.querySelectorAll('.swiper-slide-active .name p, .swiper-slide-active .val').forEach(el => {
        el.addEventListener('mouseenter', e => {
            const parent = el.closest('.inner_circle');
            const name = parent.querySelector('.name p').innerHTML.trim();
            const valEl = parent.querySelector('.val');
            const [val1, val2] = valEl.innerHTML.split(/<br\s*\/?>/i);
            showTooltip(e,name,val1,val2);
        });
        el.addEventListener('mousemove', e => {
            if (tooltip.style.opacity === '1') {
                tooltip.style.left = e.pageX + 12 + 'px';
                tooltip.style.top = e.pageY + 12 + 'px';
            }
        });
        el.addEventListener('mouseleave', hideTooltip);
    });
}

// 스크롤 이벤트에 연결
window.addEventListener('scroll', checkIfInTopView);
