-- --------------------------------------------------------
-- 호스트:                          127.0.0.1
-- 서버 버전:                        8.4.6 - Source distribution
-- 서버 OS:                        Linux
-- HeidiSQL 버전:                  12.1.0.6537
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- 테이블 etoday_corp.ET_KRX_BIZCODE 구조 내보내기
DROP TABLE IF EXISTS `ET_KRX_BIZCODE`;
CREATE TABLE IF NOT EXISTS `ET_KRX_BIZCODE` (
  `MARKET_SEC` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마켓유형 (1 : 유가증권 / 2 : 코스닥 )',
  `BIZCODE` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드 (과거형 (미사용))',
  `INDEX_TYPE_ID` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '업종코드',
  `INDEX_TYPE_NM` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종명',
  PRIMARY KEY (`INDEX_TYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='업종코드리스트';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.ET_KRX_STK_3MNT 구조 내보내기
DROP TABLE IF EXISTS `ET_KRX_STK_3MNT`;
CREATE TABLE IF NOT EXISTS `ET_KRX_STK_3MNT` (
  `STK_CD` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `BIZDATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준일(영업일)',
  `COMPARE_YESTERDAY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일대비(0:판단불가 1:상한 2:상승 3:보합 4:하한 5:하락)',
  `COMPARE_YESTERDAY_PRICE` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일대비금액',
  `YESTERDAY_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일가격',
  `CHAGE_RATE` decimal(6,3) DEFAULT NULL COMMENT '전일대비 변동률',
  `DEALLING_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '체결가격',
  `DEALLING_AMOUNT` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '체결수량',
  `MARKET_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시가',
  `HIGH_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고가',
  `LOW_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저가',
  `ACCUMULATED_DEALING_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '누적체결가격',
  `ACCUMULATED_DEALING_AMOUNT` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '누적체결수량'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='3개월 주가정보 (복수)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.ET_KRX_STK_ATC 구조 내보내기
DROP TABLE IF EXISTS `ET_KRX_STK_ATC`;
CREATE TABLE IF NOT EXISTS `ET_KRX_STK_ATC` (
  `ATC_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기사아이디',
  `ATC_TL_NM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기사제목',
  `ATC_SRV_DT` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기사 출고일시',
  `PTO_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기사내 이미지 아이디'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='종목관련기사';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.ET_KRX_STK_INFO 구조 내보내기
DROP TABLE IF EXISTS `ET_KRX_STK_INFO`;
CREATE TABLE IF NOT EXISTS `ET_KRX_STK_INFO` (
  `STK_TPCD` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마켓유형(1 : 유가증권 / 2 : 코스닥)',
  `BIZDATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준일(영업일)',
  `STK_CD` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `STK_KNM` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목명',
  `STK_ENM` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목영문명',
  `BIZCODE_MID` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구 업종코드(미사용)',
  `BIZNAME` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구 업종명(미사용)',
  `STOCK_LIST_DATE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장일자',
  `STOCK_TOTAL_AMOUNT` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장주식수(상장증권수)',
  `STOCK_MARKET_CAPITAL` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `YESTERDAY_ENDPRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일종가',
  `UPPER_LIMIT_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상한가',
  `LOWER_LIMIT_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '하한가',
  `HIGH_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고가',
  `LOW_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '저가',
  `STOP_DEALING_FLG` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래정지여부',
  `MARKET_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '시가',
  `DEALLING_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '체결가격',
  `COMPARE_YESTERDAY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일대비(0:판단불가 1:상한 2:상승 3:보합 4:하한 5:하락)',
  `COMPARE_YESTERDAY_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일대비금액',
  `CHAGE_RATE` decimal(6,3) DEFAULT NULL COMMENT '전일대비 변동률',
  `ACCUMULATED_DEALING_PRICE` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '누적체결가격',
  `ACCUMULATED_DEALING_AMOUNT` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '누적체결수량'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='종목정보 (단수)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.ET_KRX_STK_LIST 구조 내보내기
DROP TABLE IF EXISTS `ET_KRX_STK_LIST`;
CREATE TABLE IF NOT EXISTS `ET_KRX_STK_LIST` (
  `STK_TPCD` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '마켓유형 (1 : 유가증권 / 2 : 코스닥)',
  `BIZDATE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준일 (영업일)',
  `STK_CD` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '종목코드 (6자리)',
  `KIND_CODE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '표준종목코드(국제 종목코드)',
  `SHORT_CODE` varchar(7) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '숏종목코드(7자리 종목코드)',
  `NAME_KOREAN` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목명',
  `NAME_ENGLISH` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목영문명',
  `BIZ_ID` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '용도 모름',
  `BASIC_PRICE` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준가격',
  `YESTERDAY_ENDPRICE_CODE` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일종가구분코드(1:실세,2:기세,3:거래무,4:시가기준가종목의 기세)',
  `YESTERDAY_DEALING_AMOUNT` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일누적체결수량',
  `YESTERDAY_DEALING_MONEY` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전일누적거래대금',
  `UPPER_LIMIT_PRICE` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상한가',
  `LOWER_LIMIT_PRICE` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '하한가',
  `FACE_PRICE` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '액면가',
  `INDEX_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드',
  `INDEX_TYPE_BIG` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드 대분류',
  `INDEX_TYPE_MID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드 중분류',
  `INDEX_TYPE_SML` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드 소분류',
  `STOCK_TOTAL_AMOUNT` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장주식수(상장증권수)',
  `CAPITAL_AMT` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자본금',
  PRIMARY KEY (`STK_CD`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='종목리스트 (복수)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 etoday_corp.hangul_to_number 구조 내보내기
DROP FUNCTION IF EXISTS `hangul_to_number`;
DELIMITER //
CREATE FUNCTION `hangul_to_number`(
	`hangul` VARCHAR(255)
) RETURNS bigint
    DETERMINISTIC
BEGIN
    DECLARE raw VARCHAR(255);
    DECLARE part VARCHAR(255);
    DECLARE result BIGINT DEFAULT 0;
    DECLARE unit BIGINT DEFAULT 0;
    DECLARE tmp BIGINT DEFAULT 0;

    -- 전처리: 공백 및 콤마 제거
    SET raw = REPLACE(REPLACE(hangul, ' ', ''), ',', '');

    -- 숫자 문자 치환
    SET raw = REPLACE(raw, '공', '0');
    SET raw = REPLACE(raw, '영', '0');
    SET raw = REPLACE(raw, '일', '1');
    SET raw = REPLACE(raw, '이', '2');
    SET raw = REPLACE(raw, '삼', '3');
    SET raw = REPLACE(raw, '사', '4');
    SET raw = REPLACE(raw, '오', '5');
    SET raw = REPLACE(raw, '육', '6');
    SET raw = REPLACE(raw, '칠', '7');
    SET raw = REPLACE(raw, '팔', '8');
    SET raw = REPLACE(raw, '구', '9');

    -- ----------------------------
    -- [1] 조 단위 추출 및 제거
    IF LOCATE('조', raw) > 0 THEN
        SET part = SUBSTRING_INDEX(raw, '조', 1);
        SET raw = SUBSTRING(raw, LOCATE('조', raw) + 1);
        SET tmp = parse_small_unit(part);
        SET result = result + tmp * 1000000000000;
    END IF;

    -- [2] 억 단위
    IF LOCATE('억', raw) > 0 THEN
        SET part = SUBSTRING_INDEX(raw, '억', 1);
        SET raw = SUBSTRING(raw, LOCATE('억', raw) + 1);
        SET tmp = parse_small_unit(part);
        SET result = result + tmp * 100000000;
    END IF;

    -- [3] 만 단위
    IF LOCATE('만', raw) > 0 THEN
        SET part = SUBSTRING_INDEX(raw, '만', 1);
        SET raw = SUBSTRING(raw, LOCATE('만', raw) + 1);
        SET tmp = parse_small_unit(part);
        SET result = result + tmp * 10000;
    END IF;

    -- [4] 마지막 남은 천/백/십/일 자리
    SET tmp = parse_small_unit(raw);
    SET result = result + tmp;

    RETURN result;
END//
DELIMITER ;

-- 함수 etoday_corp.json_array_contains 구조 내보내기
DROP FUNCTION IF EXISTS `json_array_contains`;
DELIMITER //
CREATE FUNCTION `json_array_contains`(
	`json_array` JSON,
	`search_value` VARCHAR(255)
) RETURNS tinyint(1)
    DETERMINISTIC
BEGIN
    RETURN JSON_CONTAINS(json_array, CONCAT('"', search_value, '"'));
END//
DELIMITER ;

-- 테이블 etoday_corp.MART_ANOMALY_DETECTION 구조 내보내기
DROP TABLE IF EXISTS `MART_ANOMALY_DETECTION`;
CREATE TABLE IF NOT EXISTS `MART_ANOMALY_DETECTION` (
  `dm_id` bigint NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `relate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관계',
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 종류',
  `bsis_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 소유 주식 수',
  `bsis_posesn_stock_qota_rt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 소유 주식 지분 율',
  `trmend_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 수',
  `trmend_posesn_stock_qota_rt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 지분 율',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `rcept_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수일자',
  `report_tp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고구분',
  `repror` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표보고자',
  `stkqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유주식등의 수',
  `stkqy_irds` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유주식등의 증감',
  `stkrt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유비율 ',
  `stkrt_irds` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유비율 증감',
  `ctr_stkqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주요체결 주식등의 수',
  `ctr_stkrt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주요체결 보유비율',
  `report_resn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고사유',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`) USING BTREE,
  KEY `corp_code` (`corp_code`)
) ENGINE=InnoDB AUTO_INCREMENT=415963 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='중요한 지분 변화 데이터를 제공';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_BIG_MAJOR_HOLDER 구조 내보내기
DROP TABLE IF EXISTS `MART_BIG_MAJOR_HOLDER`;
CREATE TABLE IF NOT EXISTS `MART_BIG_MAJOR_HOLDER` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '접수 번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `repror` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '주주명',
  `stkqy` int NOT NULL COMMENT '보유주식수',
  `stkrt` float DEFAULT NULL COMMENT '보유비율',
  `created_at` datetime DEFAULT (curdate()),
  PRIMARY KEY (`rcept_no`,`repror`,`stkqy`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='5%이상 대주주 현황\r\n공시 원본 텍스트 추출';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_BONUS_ISSUE 구조 내보내기
DROP TABLE IF EXISTS `MART_BONUS_ISSUE`;
CREATE TABLE IF NOT EXISTS `MART_BONUS_ISSUE` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `nstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 종류와 수(보통주식 (주))',
  `fv_ps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 액면가액 (원)',
  `bddd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `own_stock_amount` decimal(40,0) DEFAULT NULL COMMENT '무상증자금액',
  PRIMARY KEY (`rcept_no`),
  KEY `corp_code` (`corp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='무상 증가가 많이 이루어진 기업명 및 증자 비율 제공';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_EXECUTIVE 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_EXECUTIVE`;
CREATE TABLE IF NOT EXISTS `MART_CORP_EXECUTIVE` (
  `dm_id` bigint NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `sexdstn` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성별',
  `ofcps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '직위',
  `rgist_exctv_at` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등기 임원 여부',
  `chrg_job` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당 업무',
  `hffc_pd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재직 기간',
  `tenure_end_on` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '임기 만료 일',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=573980 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업 임원 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_HOLDER 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_HOLDER`;
CREATE TABLE IF NOT EXISTS `MART_CORP_HOLDER` (
  `dm_id` bigint NOT NULL AUTO_INCREMENT,
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업코드(8자리)',
  `nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `stkqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 수',
  `stkrt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유비율',
  `corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분 : Y(유가), K(코스닥), N(코넥스), E(기타)',
  `holder_type` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '구분(대주주 / 특수관계인)',
  `stml_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=314402 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='최대주주구성';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_INFO_BASE 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_INFO_BASE`;
CREATE TABLE IF NOT EXISTS `MART_CORP_INFO_BASE` (
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '기업코드',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정식회사명칭',
  `corp_name_eng` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영문정식회사명칭',
  `stock_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목명(상장사) 또는 약식명칭(기타법인)',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `ceo_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자명',
  `corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분(Y:유가,K:코스닥,N:코넥스,E:기타)',
  `jurir_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `bizr_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `adres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `hm_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '홈페이지',
  `ir_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IR홈페이지',
  `phn_no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `fax_no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팩스번호',
  `induty_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드',
  `est_dt` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립일(YYYYMMDD)',
  `acc_mt` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산월(MM)',
  `created_at` timestamp NULL DEFAULT NULL,
  `unityGrupCode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업집단코드',
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `smerNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인',
  `repreCmpny` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표회사',
  `sumCmpnyCo` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계열회사 수',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자명',
  `fondDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업설립일',
  `grinil` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계열편입일',
  `INDEX_TYPE` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드',
  `INDEX_TYPE_NM` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종이름',
  PRIMARY KEY (`corp_code`,`unityGrupCode`),
  KEY `stock_code` (`stock_code`),
  KEY `jurir_no` (`jurir_no`),
  KEY `bizr_no` (`bizr_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업 기본 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_MAJOR_SHAREHOLDERS 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_MAJOR_SHAREHOLDERS`;
CREATE TABLE IF NOT EXISTS `MART_CORP_MAJOR_SHAREHOLDERS` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '성명',
  `relate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관계',
  `trmend_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 수',
  `trmend_posesn_stock_qota_rt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 지분 율',
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 종류',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`rcept_no`,`nm`),
  KEY `corp_code` (`corp_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업 대주주 정보 및 주식 보유량';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_OWNERSHIP 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_OWNERSHIP`;
CREATE TABLE IF NOT EXISTS `MART_CORP_OWNERSHIP` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `inv_prm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '법인명',
  `frst_acqs_de` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '최초 취득 일자',
  `invstmnt_purps` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '출자 목적',
  `frst_acqs_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최초 취득 금액',
  `bsis_blce_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 수량',
  `bsis_blce_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 지분 율',
  `bsis_blce_acntbk_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 장부 가액',
  `incrs_dcrs_acqs_dsps_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 취득 처분 수량',
  `incrs_dcrs_acqs_dsps_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 취득 처분 금액',
  `incrs_dcrs_evl_lstmn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 평가 손액',
  `trmend_blce_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 수량',
  `trmend_blce_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 지분 율',
  `trmend_blce_acntbk_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 장부 가액',
  `recent_bsns_year_fnnr_sttus_tot_assets` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최근 사업 연도 재무 현황 총 자산',
  `recent_bsns_year_fnnr_sttus_thstrm_ntpf` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최근 사업 연도 재무 현황 당기 순이익',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '결산기준일',
  `inv_corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '투자받은 기업 고유번호',
  `inv_corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '투자받은 기업 종목명(법인명)',
  `inv_corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '투자받은 기업 법인구분',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`),
  KEY `corp_code` (`corp_code`)
) ENGINE=InnoDB AUTO_INCREMENT=393211 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='타법인 투자 내역';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_REVENUE 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_REVENUE`;
CREATE TABLE IF NOT EXISTS `MART_CORP_REVENUE` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `jurir_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `reprt_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서 코드',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정식회사명칭',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업코드',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `account_nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계정명',
  `thstrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기금액',
  `thstrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기일자',
  `bsns_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업 연도',
  `fs_div` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개별/연결구분',
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5783 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업별 당기순이익';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_REVENUE_PROFIT 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_REVENUE_PROFIT`;
CREATE TABLE IF NOT EXISTS `MART_CORP_REVENUE_PROFIT` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `jurir_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정식회사명칭',
  `reprt_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서 코드',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업코드',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `account_nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계정명',
  `thstrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기금액',
  `thstrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기일자',
  `bsns_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업 연도',
  `fs_div` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개별/연결구분',
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=41524 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업별 매출액 및 영업이익';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_CORP_REVENUE_TAKE 구조 내보내기
DROP TABLE IF EXISTS `MART_CORP_REVENUE_TAKE`;
CREATE TABLE IF NOT EXISTS `MART_CORP_REVENUE_TAKE` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `jurir_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `reprt_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서 코드',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정식회사명칭',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업코드',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `account_nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계정명',
  `thstrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기금액',
  `thstrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기일자',
  `bsns_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업 연도',
  `fs_div` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개별/연결구분',
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=34253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='2024년~ 매출액 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_DISCLOSURE_SEARCH 구조 내보내기
DROP TABLE IF EXISTS `MART_DISCLOSURE_SEARCH`;
CREATE TABLE IF NOT EXISTS `MART_DISCLOSURE_SEARCH` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업 고유번호',
  `corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `report_nm` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서명',
  `flr_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시 제출인명',
  `pblntf_ty` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시유형(A~J)',
  `rcept_dt` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수일자',
  `rm` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `opensearch_push_dt` datetime DEFAULT NULL COMMENT 'OpenSearch 전송일시',
  PRIMARY KEY (`rcept_no`),
  KEY `corp_code` (`corp_code`),
  KEY `flr_nm` (`flr_nm`),
  KEY `rcept_dt` (`rcept_dt`),
  KEY `opensearch_push_dt` (`opensearch_push_dt`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공시 목록';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_DISCLOSURE_TEXT 구조 내보내기
DROP TABLE IF EXISTS `MART_DISCLOSURE_TEXT`;
CREATE TABLE IF NOT EXISTS `MART_DISCLOSURE_TEXT` (
  `rcept_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '기업개황',
  `stock_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '주주 현황보고',
  `CprInvstmnt_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '타법인출자현황',
  `majorstock_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '최대주주현황',
  `CmpnyIndx_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '주요재무지표 ',
  `created_at` datetime DEFAULT (curdate())
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공시 원문과 공시 원문을 AI로 요약하여 제공';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_LLM_SUMMARY 구조 내보내기
DROP TABLE IF EXISTS `MART_LLM_SUMMARY`;
CREATE TABLE IF NOT EXISTS `MART_LLM_SUMMARY` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `summary` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시전체요약',
  `MgDecsn_info_sumy` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주요사항요약',
  `pblntf_ty` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시유형(A~J)',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공시 원문 AI 요약 내용';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_MGDECSN_TEXT 구조 내보내기
DROP TABLE IF EXISTS `MART_MGDECSN_TEXT`;
CREATE TABLE IF NOT EXISTS `MART_MGDECSN_TEXT` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `MgDecsn_info_raw` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '주요사항보고서',
  `MgDecsn_info_sumy` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '주요사항보고서 AI 요약',
  `created_at` datetime DEFAULT (curdate())
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공시 원본 텍스트 추출(주요사항 보고서)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_MINORITY_HOLDERS_RATE 구조 내보내기
DROP TABLE IF EXISTS `MART_MINORITY_HOLDERS_RATE`;
CREATE TABLE IF NOT EXISTS `MART_MINORITY_HOLDERS_RATE` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `bsns_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준년도',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `hold_stock_rate` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소액 주주 비율',
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='소액 주주 비율 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_PERMANENT_EMPLOYEE 구조 내보내기
DROP TABLE IF EXISTS `MART_PERMANENT_EMPLOYEE`;
CREATE TABLE IF NOT EXISTS `MART_PERMANENT_EMPLOYEE` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `fo_bbm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업부문',
  `sexdstn` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성별',
  `rgllbr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정규직 수',
  `rgllbr_abacpt_labrr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정규직 단시간 근로자 수',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=655 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업별 정규직 근로자 수';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_PRV_MAJOR_HOLDER_RATE 구조 내보내기
DROP TABLE IF EXISTS `MART_PRV_MAJOR_HOLDER_RATE`;
CREATE TABLE IF NOT EXISTS `MART_PRV_MAJOR_HOLDER_RATE` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 종류',
  `trmend_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 수',
  `trmend_posesn_stock_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 지분 율',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2406 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업 최대 주주 및 특수 관계인 지분율';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_SELF_STOCK_RANK 구조 내보내기
DROP TABLE IF EXISTS `MART_SELF_STOCK_RANK`;
CREATE TABLE IF NOT EXISTS `MART_SELF_STOCK_RANK` (
  `dm_id` bigint unsigned NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `acqs_mth1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 대분류',
  `acqs_mth2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 중분류',
  `acqs_mth3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 소분류',
  `change_qy_acqs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 수량 취득',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`dm_id`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB AUTO_INCREMENT=653 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='자기 주식 취득율 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_STOCK_KND_MAPPING 구조 내보내기
DROP TABLE IF EXISTS `MART_STOCK_KND_MAPPING`;
CREATE TABLE IF NOT EXISTS `MART_STOCK_KND_MAPPING` (
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `stock_cd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `stock_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '표준 분류',
  PRIMARY KEY (`stock_knd`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='보통주 매핑 테이블';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.MART_TOP_LIST_SUBSIDIARIES 구조 내보내기
DROP TABLE IF EXISTS `MART_TOP_LIST_SUBSIDIARIES`;
CREATE TABLE IF NOT EXISTS `MART_TOP_LIST_SUBSIDIARIES` (
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '법인등록번호',
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `cdpnyLstCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자회사상장수',
  `fnncSeCodeNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사구분 - 일반 - 금융보험',
  PRIMARY KEY (`jurirno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='상장기업 및 자회사 정보 (현재 쓰지않음)';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.OP_AP_INFO 구조 내보내기
DROP TABLE IF EXISTS `OP_AP_INFO`;
CREATE TABLE IF NOT EXISTS `OP_AP_INFO` (
  `AP_KEY` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'OP_DA_AP_1_1 등',
  `AP_PATH` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'list.json, company.json 등 엔드포인트 경로\n',
  `AP_REQUIRE_PARAMS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'JSON 문자열 ex) ["corp_code","bgn_de","end_de"] **요청키는 제외**',
  `AP_OPTIONAL_PARAMS` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT 'JSON 문자열ex) ["page_count","page_no"] 등\n',
  `AP_DESCRIPTION` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주석용 설명 (공시정보 등)',
  `AP_IS_ACTIVE` tinyint DEFAULT NULL COMMENT '	사용 중지된 API 구분(0:비활성,1:활성)',
  `CREATED_AT` datetime DEFAULT NULL,
  `UPDATED_AT` datetime DEFAULT NULL,
  PRIMARY KEY (`AP_KEY`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='오픈다트 api 정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 함수 etoday_corp.parse_small_unit 구조 내보내기
DROP FUNCTION IF EXISTS `parse_small_unit`;
DELIMITER //
CREATE FUNCTION `parse_small_unit`(
    raw VARCHAR(255)
) RETURNS bigint
    DETERMINISTIC
BEGIN
    DECLARE r BIGINT DEFAULT 0;
    DECLARE section VARCHAR(255);
    DECLARE num BIGINT;

    IF LOCATE('천', raw) > 0 THEN
        SET section = SUBSTRING_INDEX(raw, '천', 1);
        SET num = IF(section = '', 1, CAST(section AS UNSIGNED));
        SET r = r + num * 1000;
        SET raw = SUBSTRING(raw, LOCATE('천', raw) + 1);
    END IF;

    IF LOCATE('백', raw) > 0 THEN
        SET section = SUBSTRING_INDEX(raw, '백', 1);
        SET num = IF(section = '', 1, CAST(section AS UNSIGNED));
        SET r = r + num * 100;
        SET raw = SUBSTRING(raw, LOCATE('백', raw) + 1);
    END IF;

    IF LOCATE('십', raw) > 0 THEN
        SET section = SUBSTRING_INDEX(raw, '십', 1);
        SET num = IF(section = '', 1, CAST(section AS UNSIGNED));
        SET r = r + num * 10;
        SET raw = SUBSTRING(raw, LOCATE('십', raw) + 1);
    END IF;

    IF raw != '' THEN
        SET r = r + CAST(raw AS UNSIGNED);
    END IF;

    RETURN r;
END//
DELIMITER ;

-- 테이블 etoday_corp.STG_EG_AP_1_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_1_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_1_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `presentnYear` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년도',
  `smerNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인',
  `caplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자본금 총액',
  `smerCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인 지분',
  `slptCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '특수관계인 지분',
  `entrprsCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소속회사 지분',
  `tesstkCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자기주식 지분',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=1108 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>내부지분 비교>지배구조>공정거래위원회_내부지분(대동비교) 현황 조회 / 기업집단별';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_1_2 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_1_2`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_1_2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appnGrupSeCode` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '집단유형구분',
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `smerNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인',
  `prvYearCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 자본금 총액',
  `curYearCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 자본금 총액',
  `prvYearSmerCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 동일인(=최대주주) 지분',
  `curYearSmerCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 동일인(=최대주주) 지분',
  `prvYearSlptCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 특수관계인 지분',
  `curYearSlptCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 특수관계인 지분',
  `prvYearEntrprsCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 소속회사 지분',
  `curYearEntrprsCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 소속회사 지분',
  `prvYearTesstkCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 자기주식 지분',
  `curYearTesstkCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 자기주식 지분',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>내부지분 비교>지배구조>공정거래위원회_내부지분(대동비교) 현황 조회 / 자산-공기업 구분별';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_2_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_2_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_2_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `fnncSeNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사구분 - 일반 - 금융보험',
  `cdpnyNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자손회사명',
  `cdpnyJurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자손회사 법인등록번호',
  `cdpnyQotaRate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자손회사 지분율',
  `hldcpSeNm` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자손회사구분',
  `parentJurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자손회사 모기업 법인등록번호',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사 사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2501 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 현황>지배구조>공정거래위원회_지주회사 자회사 및 손자회사 현황 정보 조회 서비스';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_2_3 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_2_3`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_2_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요청시 법인등록번호가 없을 때만 제공',
  `reprsntGoodsCn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표상품명',
  `indutyNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '참여업종명',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 현황>지배구조>공정거래위원회_대규모기업집단 소속회사 참여업종 정보 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_2_4 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_2_4`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_2_4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `psitnCmpnyChangeSeCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소속회사변경구분',
  `postpneConfmDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유예승인일자',
  `postpneBeginDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유예시작일자',
  `postpneEndDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유예종료일자',
  `postpneEndPrearngeDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유예종료예정일자',
  `postpnePrvonshTyCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유예사유유형',
  `incrprDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '편입일자',
  `incrprPrvonshCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '편입사유',
  `exclDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제외일자',
  `exclPrvonshCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제외사유',
  `exclTrgetJobCode` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제외대상업무',
  `bizrno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=226 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 현황>지배구조>공정거래위원회_대규모기업집단 계열 편입/제외/유예 변경내역 조회\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_3_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_3_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_3_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `appnGrupSeCode` varchar(12) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '집단유형구분',
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `smerNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인',
  `prvYearCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 자본금 총액',
  `curYearCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 자본금 총액',
  `prvYearReltivCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 친족 지분',
  `curYearReltivCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 친족 지분',
  `prvYearExctvCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 임원 지분',
  `curYearExctvCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 임원 지분',
  `prvYearNfcrCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전년도 비영리 법인단체 지분',
  `curYearNfcrCaplAmount` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당해년도 비영리 법인단체 지분',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=83 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>출자 현황>지배구조>공정거래위원회_특수관계인 내부지분 현황 정보 조회';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_3_2 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_3_2`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_3_2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `rotatInvstmntLoopCo` varchar(3) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '순환출자 고리 수',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '202505',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>출자 현황>지배구조>공정거래위원회_기업집단별 순환출자 현황 조회\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_4_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_4_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_4_1` (
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '법인등록번호',
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `assetsTotamt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자산총액',
  `debtRate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부채비율',
  `pllrRate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주비율',
  `cdpnyCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자회사수',
  `cdpnyLstCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자회사상장수',
  `grndsonCmpnyCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '손자회사수',
  `grndsonCmpnyLstCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '손자회사상장수',
  `grtgrndsonCmpnyCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증손회사수',
  `grtgrndsonCmpnyLstCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증손회사상장수',
  `hldcpFondDe` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립전환일',
  `fnncSeCodeNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사구분 - 일반 - 금융보험',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`jurirno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>지주회사 설립>지배구조>공정거래위원회_지주회사 설립 전환 신고현황 정보 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_5_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_5_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_5_1` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요청시 법인등록번호가 없을 때만 제공',
  `shrholdrNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주명',
  `shrholdrSe` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주구분',
  `posesnStockCo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소유주식수',
  `allQotaRate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전체지분율(%)',
  `onskCo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보통주수',
  `nrmltyQotaRate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보통주지분율(%)',
  `prstkCo` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우선주수',
  `priorQotaRate` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우선주지분율(%)',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7977 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>소속회사 현황>지배구조>공정거래위원회_대규모기업집단 소속회사 주주현황 정보 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_5_2 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_5_2`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_5_2` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요청시 법인등록번호가 없을 때만 제공',
  `exctvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '임원명',
  `ofcpsNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '직위',
  `smerRelateNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인과의 관계',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>소속회사 현황>지배구조>공정거래위원회_대규모기업집단 소속회사 임원현황 정보 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_5_3 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_5_3`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_5_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '요청시 법인등록번호가 없을 때만 제공',
  `fondDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업설립일',
  `grinil` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '집단편입일',
  `indutyNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종명',
  `indutyCode` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드',
  `ordtmEmplyCo` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상시종업원수',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>소속회사 현황>지배구조>공정거래위원회_대규모기업집단 소속회사 개요 정보 조회 서비스\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_5_4 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_5_4`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_5_4` (
  `id` int NOT NULL AUTO_INCREMENT,
  `unityGrupCode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단코드',
  `unityGrupNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지주회사명',
  `entrprsNm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `jurirno` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '법인등록번호',
  `rprsntvNm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자명',
  `fondDe` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업설립일',
  `grinil` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계열편입일',
  `bizrno` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '202505' COMMENT '공개년월',
  PRIMARY KEY (`id`),
  KEY `unityGrupCode` (`unityGrupCode`),
  KEY `jurirno` (`jurirno`),
  KEY `unityGrupNm` (`unityGrupNm`)
) ENGINE=InnoDB AUTO_INCREMENT=3302 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>소속회사 현황>지배구조>공정거래위원회_지정된 대규모기업집단 소속회사 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_6_1 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_6_1`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_6_1` (
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `unityGrupCode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업집단코드',
  `rn` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자산총액 순위',
  `assetsTotamt` varchar(22) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자산총액(단위: 10억원)',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT '202505' COMMENT '공개년월',
  PRIMARY KEY (`unityGrupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 조회>지배구조>공정거래위원회_지정된 대규모기업집단 자산순위 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_6_2 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_6_2`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_6_2` (
  `unityGrupNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업집단명',
  `unityGrupCode` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '기업집단코드',
  `smerNm` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '동일인',
  `repreCmpny` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표회사',
  `sumCmpnyCo` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계열회사 수',
  `invstmntLmtt` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자산별구분코드 - 상호출자제한집단 - 공시대상기업집단 - 출자총액제한집단',
  `entrprsCl` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '	공기업구분코드 - 일반 - 공기업',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공개년월',
  PRIMARY KEY (`unityGrupCode`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 조회>지배구조>공정거래위원회_지정된 대규모기업집단 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_EG_AP_6_3 구조 내보내기
DROP TABLE IF EXISTS `STG_EG_AP_6_3`;
CREATE TABLE IF NOT EXISTS `STG_EG_AP_6_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `jobSeCode` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지정: 0001, 지주: 0003',
  `othbcYm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '공개년월',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='기업집단포털>기업집단 조회>지배구조>공정거래위원회_사용 가능 공개년월 조회 서비스\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_1_1 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_1_1`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_1_1` (
  `corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목명(법인명)',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업 고유번호',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드',
  `report_nm` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서명',
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `pblntf_ty` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시유형(A~J)',
  `flr_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시 제출인명',
  `rcept_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수일자',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`) USING BTREE,
  KEY `pblntf_ty` (`pblntf_ty`) USING BTREE,
  KEY `corp_code` (`corp_code`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>공시정보>공시검색';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_1_2 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_1_2`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_1_2` (
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '기업코드',
  `corp_name` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정식회사명칭',
  `corp_name_eng` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영문정식회사명칭',
  `stock_name` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목명(상장사) 또는 약식명칭(기타법인)',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드(6자리)',
  `ceo_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표자명',
  `corp_cls` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `jurir_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인등록번호',
  `bizr_no` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업자등록번호',
  `adres` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주소',
  `hm_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '홈페이지',
  `ir_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'IR홈페이지',
  `phn_no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전화번호',
  `fax_no` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '팩스번호',
  `induty_code` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '업종코드',
  `est_dt` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립일(YYYYMMDD)',
  `acc_mt` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산월(MM)',
  `created_at` timestamp NULL DEFAULT (now()) COMMENT '등록일',
  PRIMARY KEY (`corp_code`),
  KEY `stock_code` (`stock_code`) USING BTREE,
  KEY `bizr_no` (`bizr_no`) USING BTREE,
  KEY `jurir_no` (`jurir_no`) USING BTREE,
  KEY `corp_name` (`corp_name`) USING BTREE,
  KEY `corp_name_eng` (`corp_name_eng`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>공시정보>기업대시보드';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_1_3 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_1_3`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_1_3` (
  `id` int NOT NULL AUTO_INCREMENT,
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_code` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업 고유번호',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일명',
  `file_extension` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '확장자',
  `file_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '텍스트 파일 내용',
  `file_path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일 저장 경로',
  `content_type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '파일 타입(TEXT / BINARY)',
  `file_size` bigint DEFAULT NULL COMMENT '파일 크기',
  `created_date` timestamp NULL DEFAULT NULL COMMENT '생성일시',
  PRIMARY KEY (`id`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB AUTO_INCREMENT=171981 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='오픈다트>공시 정보>공시서류원본파일\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_1_4 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_1_4`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_1_4` (
  `corp_code` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '	고유번호',
  `corp_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '	정식명칭',
  `corp_eng_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '	영문 정식명칭',
  `stock_code` char(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목코드',
  `modify_date` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최종변경일자',
  `crawling_yn` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수집여부',
  PRIMARY KEY (`corp_code`),
  KEY `corp_name` (`corp_name`),
  KEY `corp_eng_name` (`corp_eng_name`),
  KEY `stock_code` (`stock_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='공시정보 > 기업고유번호';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_1 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_1`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_1` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분 : Y(유가), K(코스닥), N(코넥스), E(기타)',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `isu_dcrs_de` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식발행 감소일자',
  `isu_dcrs_stle` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 감소 형태',
  `isu_dcrs_stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 감소 주식 종류',
  `isu_dcrs_qy` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 감소 수량',
  `isu_dcrs_mstvdv_fval_amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 감소 주당 액면 가액',
  `isu_dcrs_mstvdv_amount` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 감소 주당 가액',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>증자(감자)현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_10 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_10`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_10` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nmpr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '인원수',
  `mendng_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수 총액',
  `jan_avrg_mendng_am` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1인 평균 보수 액',
  `rm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>이사·감사 전체의 보수현황(보수지급금액 - 이사·감사 전체)	\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_11 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_11`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_11` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이름',
  `ofcps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '직위',
  `mendng_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수 총액',
  `mendng_totamt_ct_incls_mendng` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수 총액 비 포함 보수',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>개인별 보수지급 금액(5억이상 상위5인)	\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_12 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_12`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_12` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `inv_prm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `frst_acqs_de` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최초 취득 일자',
  `invstmnt_purps` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '출자 목적',
  `frst_acqs_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최초 취득 금액',
  `bsis_blce_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 수량',
  `bsis_blce_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 지분 율',
  `bsis_blce_acntbk_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 잔액 장부 가액',
  `incrs_dcrs_acqs_dsps_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 취득 처분 수량',
  `incrs_dcrs_acqs_dsps_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 취득 처분 금액',
  `incrs_dcrs_evl_lstmn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증가 감소 평가 손액',
  `trmend_blce_qy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 수량',
  `trmend_blce_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 지분 율',
  `trmend_blce_acntbk_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 잔액 장부 가액',
  `recent_bsns_year_fnnr_sttus_tot_assets` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최근 사업 연도 재무 현황 총 자산',
  `recent_bsns_year_fnnr_sttus_thstrm_ntpf` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최근 사업 연도 재무 현황 당기 순이익',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `corp_code` (`corp_code`) USING BTREE,
  KEY `rcept_no` (`rcept_no`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>타법인 출자현황\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_13 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_13`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_13` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `se` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `isu_stock_totqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행할 주식의 총수',
  `now_to_isu_stock_totqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '현재까지 발행한 주식의 총수',
  `now_to_dcrs_stock_totqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '현재까지 감소한 주식의 총수',
  `redc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자',
  `profit_incnr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이익소각',
  `rdmstk_repy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상환주식의 상환',
  `etc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기타',
  `istc_totqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행주식의 총수',
  `tesstk_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자기주식수',
  `distb_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유통주식수',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>주식의 총수 현황\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_23 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_23`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_23` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `drctr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사의 수',
  `otcmp_drctr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 수',
  `apnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 변동현황(선임)',
  `rlsofc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 변동현황(해임)',
  `mdstrm_resig` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 변동현황(중도퇴임)',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>사외이사 및 그 변동현황		\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_24 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_24`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_24` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `se` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `nmpr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '인원수',
  `fyer_salary_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '연간급여 총액',
  `jan_salary_am` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1인평균 급여액',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>미등기임원 보수현황	\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_25 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_25`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_25` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `se` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `nmpr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '인원수',
  `gmtsck_confm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 승인금액',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>이사·감사 전체의 보수현황(주주총회 승인금액)\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_26 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_26`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_26` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시대상회사의 고유번호(8자리)',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시대상회사명',
  `se` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `nmpr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '인원수',
  `pymnt_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수총액',
  `psn1_avrg_pymntamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1인당 평균보수액',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>이사·감사 전체의 보수현황(보수지급금액 - 유형별)		\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_3 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_3`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_3` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `acqs_mth1` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 대분류',
  `acqs_mth2` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 중분류',
  `acqs_mth3` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '취득방법 소분류',
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 종류',
  `bsis_qy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 수량',
  `change_qy_acqs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 수량 취득',
  `change_qy_dsps` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 수량 처분',
  `change_qy_incnr` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 수량 소각',
  `trmend_qy` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 수량',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `corp_code` (`corp_code`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>자기주식 취득 및 처분 현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_4 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_4`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_4` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `relate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관계',
  `stock_knd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식 종류',
  `bsis_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 소유 주식 수',
  `bsis_posesn_stock_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기초 소유 주식 지분 율',
  `trmend_posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 수',
  `trmend_posesn_stock_qota_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기말 소유 주식 지분 율',
  `rm` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `stock_knd_map` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '의결권 있는 Y, 기타 N',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `corp_code` (`corp_code`) USING BTREE,
  KEY `rcept_no` (`rcept_no`) USING BTREE,
  KEY `rm` (`rm`) USING BTREE,
  KEY `stock_knd_map` (`stock_knd_map`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>최대주주 현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_5 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_5`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_5` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `change_on` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 일',
  `mxmm_shrholdr_nm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최대 주주 명',
  `posesn_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '소유 주식 수',
  `qota_rt` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '지분 율',
  `change_cause` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '변동 원인',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `corp_code` (`corp_code`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>최대주주 변동현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_6 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_6`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_6` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `se` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `shrholdr_co` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주수',
  `shrholdr_tot_co` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전체 주주수',
  `shrholdr_rate` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주 비율',
  `hold_stock_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유 주식수',
  `stock_tot_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '총발행 주식수',
  `hold_stock_rate` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유 주식 비율',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`),
  KEY `corp_code` (`corp_code`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>소액주주 현황		';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_7 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_7`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_7` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성명',
  `sexdstn` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성별',
  `birth_ym` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '출생 년월',
  `ofcps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '직위',
  `rgist_exctv_at` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '등기 임원 여부',
  `fte_at` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상근 여부',
  `chrg_job` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '담당 업무',
  `main_career` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci COMMENT '주요 경력',
  `mxmm_shrholdr_relate` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최대 주주 관계',
  `hffc_pd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재직 기간',
  `tenure_end_on` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '임기 만료 일',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `corp_code` (`corp_code`),
  KEY `rcept_no` (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>임원 현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_8 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_8`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_8` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `fo_bbm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업부문',
  `sexdstn` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '성별',
  `reform_bfe_emp_co_rgllbr` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개정 전 직원 수 정규직',
  `reform_bfe_emp_co_cnttk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개정 전 직원 수 계약직',
  `reform_bfe_emp_co_etc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개정 전 직원 수 기타',
  `rgllbr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정규직 수',
  `rgllbr_abacpt_labrr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '정규직 단시간 근로자 수',
  `cnttk_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약직 수',
  `cnttk_abacpt_labrr_co` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약직 단시간 근로자 수',
  `sm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합계',
  `avrg_cnwk_sdytrn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '평균 근속 연수',
  `fyer_salary_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '연간 급여 총액',
  `jan_salary_am` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1인평균 급여 액',
  `rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '비고',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>지배구조>직원 현황';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_2_9 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_2_9`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_2_9` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인명',
  `nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이름',
  `ofcps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '직위',
  `mendng_totamt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수 총액',
  `mendng_totamt_ct_incls_mendng` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보수 총액 비 포함 보수',
  `stlm_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '결산기준일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>이사·감사의 개인별 보수현황(5억원 이상)		\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_3_1 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_3_1`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_3_1` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `bsns_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사업 연도',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '종목 코드',
  `reprt_code` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서 코드',
  `account_nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계정명',
  `fs_div` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개별/연결구분',
  `fs_nm` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '개별/연결명',
  `sj_div` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무제표구분',
  `sj_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무제표명',
  `thstrm_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기명',
  `thstrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기일자',
  `thstrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기금액',
  `thstrm_add_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '당기누적금액',
  `frmtrm_nm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전기명',
  `frmtrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전기일자',
  `frmtrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전기금액',
  `frmtrm_add_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전기누적금액',
  `bfefrmtrm_nm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전전기명',
  `bfefrmtrm_dt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전전기일자',
  `bfefrmtrm_amount` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '전전기금액',
  `ord` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계정과목 정렬순서',
  `currency` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '통화 단위',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  KEY `stock_code` (`stock_code`),
  KEY `rcept_no` (`rcept_no`),
  KEY `reprt_code` (`reprt_code`),
  KEY `idx_reprt_code` (`reprt_code`),
  KEY `account_nm` (`account_nm`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 재무정보>단일회사 주요계정\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_4_1 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_4_1`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_4_1` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `rcept_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수일자',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `report_tp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고구분',
  `repror` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '대표보고자',
  `stkqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유주식등의 수',
  `stkqy_irds` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유주식등의 증감',
  `stkrt` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유비율',
  `stkrt_irds` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보유비율 증감',
  `ctr_stkqy` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주요체결 주식등의 수',
  `ctr_stkrt` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주요체결 보유비율',
  `report_resn` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고사유',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>지분공시 종합정보>대량보유 상황보고	\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_4_2 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_4_2`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_4_2` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `rcept_dt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공시 접수일자(YYYY-MM-DD)',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `repror` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고자명',
  `isu_exctv_rgist_at` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 회사 관계 임원(등기여부)',
  `isu_exctv_ofcps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 회사 관계 임원 직위',
  `isu_main_shrholdr` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행 회사 관계 주요 주주',
  `sp_stock_lmp_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '특정 증권 등 소유 수',
  `sp_stock_lmp_irds_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '특정 증권 등 소유 증감 수',
  `sp_stock_lmp_rate` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '특정 증권 등 소유 비율',
  `sp_stock_lmp_irds_rate` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '특정 증권 등 소유 증감 비율',
  `report_tp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고구분',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>정기보고서 주요정보>임원ㆍ주요주주 소유보고		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_10 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_10`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_10` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `mngt_pcbg_dd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리절차개시 결정일자',
  `mngt_int` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리기관',
  `mngt_pd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리기간',
  `mngt_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관리사유',
  `cfd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '확인일자',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>채권은행 등의 관리절차 개시\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_11 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_11`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_11` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `icnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사건의 명칭',
  `ac_ap` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '원고ㆍ신청인',
  `rq_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '청구내용',
  `cpct` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관할법원',
  `ft_ctp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '향후대책',
  `lgd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제기일자',
  `cfd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '확인일자',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>소송 등의 제기\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_12 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_12`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_12` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `lstprstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장예정주식 종류ㆍ수(주)(보통주식)',
  `lstprstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장예정주식 종류ㆍ수(주)(기타주식)',
  `tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행주식 총수(주)(보통주식)',
  `tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '발행주식 총수(주)(기타주식)',
  `psmth_nstk_sl` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공모방법(신주발행 (주))',
  `psmth_ostk_sl` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공모방법(구주매출 (주))',
  `fdpp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달(신주발행) 목적',
  `lststk_orlst` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장증권(원주상장 (주))',
  `lststk_drlst` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장증권(DR상장 (주))',
  `lstex_nt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장거래소(소재국가)',
  `lstpp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '해외상장목적',
  `lstprd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장예정일자',
  `bddd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참(명))',
  `adt_a_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원)참석여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>해외 증권시장 주권등 상장 결정	\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_13 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_13`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_13` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `dlststk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장폐지주식 종류ㆍ수(주)(보통주식)',
  `dlststk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장폐지주식 종류ㆍ수(주)(기타주식)',
  `lstex_nt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장거래소(소재국가)',
  `dlstrq_prd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '폐지신청예정일자',
  `dlst_prd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '폐지(예정)일자',
  `dlst_rs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '폐지사유',
  `bddd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(확인일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참(명))',
  `adt_a_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원)참석여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>해외 증권시장 주권등 상장폐지 결정	\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_2 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_2`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_2` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `df_cn` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부도내용',
  `df_amt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부도금액',
  `df_bnk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부도발생은행',
  `dfd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '최종부도(당좌거래정지)일자',
  `df_rs` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '부도사유 및 경위',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>부도발생		\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_25 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_25`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_25` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `inh_bsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수영업',
  `inh_bsn_mc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수영업 주요내용',
  `inh_prc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수가액(원)',
  `absn_inh_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업전부의 양수 여부',
  `ast_inh_bsn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(양수대상 영업부문(A)))',
  `ast_cmp_all` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(당사전체(B)))',
  `ast_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(비중(%)(A/B)))',
  `sl_inh_bsn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(양수대상 영업부문(A)))',
  `sl_cmp_all` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(당사전체(B)))',
  `sl_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(비중(%)(A/B)))',
  `dbt_inh_bsn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(부채액(양수대상 영업부문(A)))',
  `dbt_cmp_all` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(부채액(당사전체(B)))',
  `dbt_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(부채액(비중(%)(A/B)))',
  `inh_pp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수목적',
  `inh_af` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수영향',
  `inh_prd_ctr_cnsd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수예정일자(계약체결일)',
  `inh_prd_inh_std` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수예정일자(양수기준일)',
  `dlptn_cmpnm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(회사명(성명))',
  `dlptn_cpt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(자본금(원))',
  `dlptn_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(주요사업)',
  `dlptn_hoadd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(본점소재지(주소))',
  `dlptn_rl_cmpn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(회사와의 관계)',
  `inh_pym` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양수대금지급',
  `exevl_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 여부)',
  `exevl_bs_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(근거 및 사유)',
  `exevl_intn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가기관의 명칭)',
  `exevl_pd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 기간)',
  `exevl_op` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 의견)',
  `gmtsck_spd_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 특별결의 여부',
  `gmtsck_prd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 예정일자',
  `aprskh_plnprc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(매수예정가격)',
  `aprskh_pym_plpd_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(지급예정시기, 지급방법)',
  `aprskh_lmt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(주식매수청구권 제한 관련 내용)',
  `aprskh_ctref` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(계약에 미치는 효력)',
  `bddd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(사외이사가 아닌 감사위원) 참석여부',
  `bdlst_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우회상장 해당 여부',
  `n6m_tpai_plann` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '향후 6월이내 제3자배정 증자 등 계획',
  `otcpr_bdlst_sf_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '타법인의 우회상장 요건 충족여부',
  `ftc_stt_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공정거래위원회 신고대상 여부',
  `popt_ctr_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>영업양수 결정	\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_26 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_26`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_26` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `trf_bsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도영업',
  `trf_bsn_mc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도영업 주요내용',
  `trf_prc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도가액(원)',
  `ast_trf_bsn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(양도대상 영업부문(A)))',
  `ast_cmp_all` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(당사전체(B)))',
  `ast_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(자산액(비중(%)(A/B)))',
  `sl_trf_bsn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(양도대상 영업부문(A)))',
  `sl_cmp_all` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(당사전체(B)))',
  `sl_rt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '재무내용(원)(매출액(비중(%)(A/B)))',
  `trf_pp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도목적',
  `trf_af` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도영향',
  `trf_prd_ctr_cnsd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도예정일자(계약체결일)',
  `trf_prd_trf_std` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도예정일자(양도기준일)',
  `dlptn_cmpnm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(회사명(성명))',
  `dlptn_cpt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(자본금(원))',
  `dlptn_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(주요사업)',
  `dlptn_hoadd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(본점소재지(주소))',
  `dlptn_rl_cmpn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '거래상대방(회사와의 관계)',
  `trf_pym` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '양도대금지급',
  `exevl_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 여부)',
  `exevl_bs_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(근거 및 사유)',
  `exevl_intn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가기관의 명칭)',
  `exevl_pd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 기간)',
  `exevl_op` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 의견)',
  `gmtsck_spd_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 특별결의 여부',
  `gmtsck_prd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 예정일자',
  `aprskh_plnprc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(매수예정가격)',
  `aprskh_pym_plpd_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(지급예정시기, 지급방법)',
  `aprskh_lmt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(주식매수청구권 제한 관련 내용)',
  `aprskh_ctref` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(계약에 미치는 효력)',
  `bddd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(사외이사가 아닌 감사위원) 참석여부',
  `ftc_stt_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공정거래위원회 신고대상 여부',
  `popt_ctr_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>영업양도 결정\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_3 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_3`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_3` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `bsnsp_rm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 분야',
  `bsnsp_amt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내역(영업정지금액)',
  `rsl` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내역(최근매출총액)',
  `sl_vs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내역(매출액 대비)',
  `ls_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내역(대규모법인여부)',
  `krx_stt_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내역(거래소 의무공시 해당 여부)',
  `bsnsp_cn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지 내용',
  `bsnsp_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지사유',
  `ft_ctp` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '향후대책',
  `bsnsp_af` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지영향',
  `bsnspd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '영업정지일자',
  `bddd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석)',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참)',
  `adt_a_atn` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원) 참석여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>영업정지\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_33 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_33`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_33` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `mg_mth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병방법',
  `mg_stn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병형태',
  `mg_pp` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병목적',
  `mg_rt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병비율',
  `mg_rt_bs` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병비율 산출근거',
  `exevl_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 여부)',
  `exevl_bs_rs` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(근거 및 사유)',
  `exevl_intn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가기관의 명칭)',
  `exevl_pd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 기간)',
  `exevl_op` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 의견)',
  `mgnstk_ostk_cnt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병신주의 종류와 수(주)(보통주식)',
  `mgnstk_cstk_cnt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병신주의 종류와 수(주)(종류주식)',
  `mgptncmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(회사명)',
  `mgptncmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(주요사업)',
  `mgptncmp_rl_cmpn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(회사와의 관계)',
  `rbsnfdtl_tast` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(자산총계))',
  `rbsnfdtl_tdbt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(부채총계))',
  `rbsnfdtl_teqt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(자본총계))',
  `rbsnfdtl_cpt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(자본금))',
  `rbsnfdtl_sl` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(매출액))',
  `rbsnfdtl_nic` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(최근 사업연도 재무내용(원)(당기순이익))',
  `eadtat_intn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(외부감사 여부(기관명))',
  `eadtat_op` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병상대회사(외부감사 여부(감사의견))',
  `nmgcmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(회사명)',
  `ffdtl_tast` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(설립시 재무내용(원)(자산총계))',
  `ffdtl_tdbt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(설립시 재무내용(원)(부채총계))',
  `ffdtl_teqt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(설립시 재무내용(원)(자본총계))',
  `ffdtl_cpt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(설립시 재무내용(원)(자본금))',
  `ffdtl_std` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(설립시 재무내용(원)(현재기준))',
  `nmgcmp_nbsn_rsl` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(신설사업부문 최근 사업연도 매출액(원))',
  `nmgcmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(주요사업)',
  `nmgcmp_rlst_atn` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설합병회사(재상장신청 여부)',
  `mgsc_mgctrd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(합병계약일)',
  `mgsc_shddstd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주주확정기준일)',
  `mgsc_shclspd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주주명부 폐쇄기간(시작일))',
  `mgsc_shclspd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주주명부 폐쇄기간(종료일))',
  `mgsc_mgop_rcpd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(합병반대의사통지 접수기간(시작일))',
  `mgsc_mgop_rcpd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(합병반대의사통지 접수기간(종료일))',
  `mgsc_gmtsck_prd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주주총회예정일자)',
  `mgsc_aprskh_expd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주식매수청구권 행사기간(시작일))',
  `mgsc_aprskh_expd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(주식매수청구권 행사기간(종료일))',
  `mgsc_osprpd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(구주권 제출기간(시작일))',
  `mgsc_osprpd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(구주권 제출기간(종료일))',
  `mgsc_trspprpd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(매매거래 정지예정기간(시작일))',
  `mgsc_trspprpd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(매매거래 정지예정기간(종료일))',
  `mgsc_cdobprpd_bgd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(채권자이의 제출기간(시작일))',
  `mgsc_cdobprpd_edd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(채권자이의 제출기간(종료일))',
  `mgsc_mgdt` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(합병기일)',
  `mgsc_ergmd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(종료보고 총회일)',
  `mgsc_mgrgsprd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(합병등기예정일자)',
  `mgsc_nstkdlprd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(신주권교부예정일)',
  `mgsc_nstklstprd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병일정(신주의 상장예정일)',
  `bdlst_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우회상장 해당 여부',
  `otcpr_bdlst_sf_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '타법인의 우회상장 요건 충족여부',
  `aprskh_plnprc` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(매수예정가격)',
  `aprskh_pym_plpd_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(지급예정시기, 지급방법)',
  `aprskh_ctref` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(계약에 미치는 효력)',
  `bddd` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(사외이사가 아닌 감사위원) 참석여부',
  `popt_ctr_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `rs_sm_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증권신고서 제출대상 여부',
  `ex_sm_r` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제출을 면제받은 경우 그 사유',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='오픈다트>주요사항보고서 주요정보>회사합병 결정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_34 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_34`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_34` (
  `rcept_no` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `dv_mth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할방법',
  `dv_impef` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할의 중요영향 및 효과',
  `dv_rt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할비율',
  `dv_trfbsnprt_cn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할로 이전할 사업 및 재산의 내용',
  `atdv_excmp_cmpnm` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(회사명)',
  `atdvfdtl_tast` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(자산총계)',
  `atdvfdtl_tdbt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(부채총계)',
  `atdvfdtl_teqt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(자본총계)',
  `atdvfdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(자본금)',
  `atdvfdtl_std` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(현재기준)',
  `atdv_excmp_exbsn_rsl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '존속사업부문 최근 사업연도매출액(원)',
  `atdv_excmp_mbsn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사(주요사업)',
  `atdv_excmp_atdv_lstmn_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할 후 존속회사 상장유지 여부',
  `dvfcmp_cmpnm` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할설립회사(회사명)',
  `ffdtl_tast` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립시 자산총계',
  `ffdtl_tdbt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립시 부채총계',
  `ffdtl_teqt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립시 자본총계',
  `ffdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립시 자본금',
  `ffdtl_std` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '설립시 현재기준',
  `dvfcmp_nbsn_rsl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신설사업부문 최근 사업연도 매출액(원)',
  `dvfcmp_mbsn` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할설립회사(주요사업)',
  `dvfcmp_rlst_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할설립회사(재상장신청 여부)',
  `abcr_crrt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자비율(%)',
  `abcr_osprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구주권 제출기간(시작일)',
  `abcr_osprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구주권 제출기간(종료일)',
  `abcr_trspprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '매매거래정지 예정기간(시작일)',
  `abcr_trspprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '매매거래정지 예정기간(종료일)',
  `abcr_nstkascnd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주배정조건',
  `abcr_shstkcnt_rt_at_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주 주식수 비례여부 및 사유',
  `abcr_nstkasstd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주배정기준일',
  `abcr_nstkdlprd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주권교부예정일',
  `abcr_nstklstprd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 상장예정일',
  `gmtsck_prd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주주총회 예정일',
  `cdobprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '채권자 이의제출기간(시작일)',
  `cdobprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '채권자 이의제출기간(종료일)',
  `dvdt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할기일',
  `dvrgsprd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할등기 예정일',
  `bddd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사위원 참석여부',
  `popt_ctr_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `rs_sm_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증권신고서 제출대상 여부',
  `ex_sm_r` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제출을 면제받은 경우 그 사유',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>회사분할 결정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_35 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_35`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_35` (
  `rcept_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `dvmg_mth` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병 방법',
  `dvmg_impef` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병의 중요영향 및 효과',
  `dv_trfbsnprt_cn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할로 이전할 사업 및 재산의 내용)',
  `atdv_excmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(회사명))',
  `atdvfdtl_tast` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할후 재무내용(원)(자산총계)))',
  `atdvfdtl_tdbt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할후 재무내용(원)(부채총계)))',
  `atdvfdtl_teqt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할후 재무내용(원)(자본총계)))',
  `atdvfdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할후 재무내용(원)(자본금)))',
  `atdvfdtl_std` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할후 재무내용(원)(현재기준)))',
  `atdv_excmp_exbsn_rsl` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(존속사업부문 최근 사업연도매출액(원)))',
  `atdv_excmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(주요사업))',
  `atdv_excmp_atdv_lstmn_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할 후 존속회사(분할 후 상장유지 여부))',
  `dvfcmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(회사명))',
  `ffdtl_tast` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(설립시 재무내용(원)(자산총계)))',
  `ffdtl_tdbt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(설립시 재무내용(원)(부채총계)))',
  `ffdtl_teqt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(설립시 재무내용(원)(자본총계)))',
  `ffdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(설립시 재무내용(원)(자본금)))',
  `ffdtl_std` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(설립시 재무내용(원)(현재기준)))',
  `dvfcmp_nbsn_rsl` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(신설사업부문 최근 사업연도 매출액(원)))',
  `dvfcmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(주요사업))',
  `dvfcmp_atdv_lstmn_at` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(분할설립 회사(분할후 상장유지여부))',
  `abcr_crrt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(감자비율(%)))',
  `abcr_osprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(구주권 제출기간(시작일)))',
  `abcr_osprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(구주권 제출기간(종료일)))',
  `abcr_trspprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(매매거래정지 예정기간(시작일)))',
  `abcr_trspprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(매매거래정지 예정기간(종료일)))',
  `abcr_nstkascnd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(신주배정조건))',
  `abcr_shstkcnt_rt_at_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(주주 주식수 비례여부 및 사유))',
  `abcr_nstkasstd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(신주배정기준일))',
  `abcr_nstkdlprd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(신주권교부예정일))',
  `abcr_nstklstprd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할에 관한 사항(감자에 관한 사항(신주의 상장예정일))',
  `mg_stn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병형태)',
  `mgptncmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(회사명))',
  `mgptncmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(주요사업))',
  `mgptncmp_rl_cmpn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(회사와의 관계))',
  `rbsnfdtl_tast` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(자산총계)))',
  `rbsnfdtl_tdbt` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(부채총계)))',
  `rbsnfdtl_teqt` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(자본총계)))',
  `rbsnfdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(자본금)))',
  `rbsnfdtl_sl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(매출액)))',
  `rbsnfdtl_nic` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(최근 사업연도 재무내용(원)(당기순이익)))',
  `eadtat_intn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(외부감사 여부(기관명)))',
  `eadtat_op` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병상대 회사(외부감사 여부(감사의견)))',
  `dvmgnstk_ostk_cnt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(분할합병신주의 종류와 수(주)(보통주식))',
  `dvmgnstk_cstk_cnt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(분할합병신주의 종류와 수(주)(종류주식))',
  `nmgcmp_cmpnm` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병신설 회사(회사명))',
  `nmgcmp_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병신설 회사(자본금(원)))',
  `nmgcmp_mbsn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병신설 회사(주요사업))',
  `nmgcmp_rlst_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '합병에 관한 사항(합병신설 회사(재상장신청 여부))',
  `dvmg_rt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병비율',
  `dvmg_rt_bs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병비율 산출근거',
  `exevl_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 여부)',
  `exevl_bs_rs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(근거 및 사유)',
  `exevl_intn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가기관의 명칭)',
  `exevl_pd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 기간)',
  `exevl_op` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 의견)',
  `dvmgsc_dvmgctrd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(분할합병계약일)',
  `dvmgsc_shddstd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주주확정기준일)',
  `dvmgsc_shclspd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주주명부 폐쇄기간(시작일))',
  `dvmgsc_shclspd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주주명부 폐쇄기간(종료일))',
  `dvmgsc_dvmgop_rcpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(분할합병반대의사통지 접수기간(시작일))',
  `dvmgsc_dvmgop_rcpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(분할합병반대의사통지 접수기간(종료일))',
  `dvmgsc_gmtsck_prd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주주총회예정일자)',
  `dvmgsc_aprskh_expd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주식매수청구권 행사기간(시작일))',
  `dvmgsc_aprskh_expd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(주식매수청구권 행사기간(종료일))',
  `dvmgsc_cdobprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(채권자 이의 제출기간(시작일))',
  `dvmgsc_cdobprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(채권자 이의 제출기간(종료일))',
  `dvmgsc_dvmgdt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(분할합병기일)',
  `dvmgsc_ergmd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(종료보고 총회일)',
  `dvmgsc_dvmgrgsprd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '분할합병일정(분할합병등기예정일)',
  `bdlst_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우회상장 해당 여부',
  `otcpr_bdlst_sf_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '타법인의 우회상장 요건 충족여부',
  `aprskh_exrq` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(행사요건)',
  `aprskh_plnprc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(매수예정가격)',
  `aprskh_ex_pc_mth_pd_pl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(행사절차, 방법, 기간, 장소)',
  `aprskh_pym_plpd_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(지급예정시기, 지급방법)',
  `aprskh_lmt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(주식매수청구권 제한 관련 내용)',
  `aprskh_ctref` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(계약에 미치는 효력)',
  `bddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(사외이사가 아닌 감사위원) 참석여부',
  `popt_ctr_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `rs_sm_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증권신고서 제출대상 여부',
  `ex_sm_r` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제출을 면제받은 경우 그 사유',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>회사분할합병 결정';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_36 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_36`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_36` (
  `rcept_no` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `extr_sen` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구분',
  `extr_stn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 형태',
  `extr_tgcmp_cmpnm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(회사명)',
  `extr_tgcmp_rp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(대표자)',
  `extr_tgcmp_mbsn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(주요사업)',
  `extr_tgcmp_rl_cmpn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(회사와의 관계)',
  `extr_tgcmp_tisstk_ostk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(발행주식총수(주)(보통주식))',
  `extr_tgcmp_tisstk_cstk` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(발행주식총수(주)(종류주식))',
  `rbsnfdtl_tast` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(최근 사업연도 요약재무내용(원)(자산총계))',
  `rbsnfdtl_tdbt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(최근 사업연도 요약재무내용(원)(부채총계))',
  `rbsnfdtl_teqt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(최근 사업연도 요약재무내용(원)(자본총계))',
  `rbsnfdtl_cpt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 대상법인(최근 사업연도 요약재무내용(원)(자본금))',
  `extr_rt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 비율',
  `extr_rt_bs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 비율 산출근거',
  `exevl_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 여부)',
  `exevl_bs_rs` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(근거 및 사유)',
  `exevl_intn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가기관의 명칭)',
  `exevl_pd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 기간)',
  `exevl_op` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '외부평가에 관한 사항(외부평가 의견)',
  `extr_pp` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 목적',
  `extrsc_extrctrd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(교환ㆍ이전계약일)',
  `extrsc_shddstd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주주확정기준일)',
  `extrsc_shclspd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주주명부 폐쇄기간(시작일))',
  `extrsc_shclspd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주주명부 폐쇄기간(종료일))',
  `extrsc_extrop_rcpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주식교환ㆍ이전 반대의사 통지접수기간(시작일))',
  `extrsc_extrop_rcpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주식교환ㆍ이전 반대의사 통지접수기간(종료일))',
  `extrsc_gmtsck_prd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주주총회 예정일자)',
  `extrsc_aprskh_expd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주식매수청구권 행사기간(시작일))',
  `extrsc_aprskh_expd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(주식매수청구권 행사기간(종료일))',
  `extrsc_osprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(구주권제출기간(시작일))',
  `extrsc_osprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(구주권제출기간(종료일))',
  `extrsc_trspprpd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(매매거래정지예정기간)',
  `extrsc_trspprpd_bgd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(매매거래정지예정기간(시작일))',
  `extrsc_trspprpd_edd` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(매매거래정지예정기간(종료일))',
  `extrsc_extrdt` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(교환ㆍ이전일자)',
  `extrsc_nstkdlprd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(신주권교부예정일)',
  `extrsc_nstklstprd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전일정(신주의 상장예정일)',
  `atextr_cpcmpnm` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '교환ㆍ이전 후 완전모회사명',
  `aprskh_plnprc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(매수예정가격)',
  `aprskh_pym_plpd_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(지급예정시기, 지급방법)',
  `aprskh_lmt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(주식매수청구권 제한 관련 내용)',
  `aprskh_ctref` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '주식매수청구권에 관한 사항(계약에 미치는 효력)',
  `bdlst_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '우회상장 해당 여부',
  `otcpr_bdlst_sf_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '타법인의 우회상장 요건 충족 여부',
  `bddd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(참석(명))',
  `od_a_at_b` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사참석여부(불참(명))',
  `adt_a_atn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(사외이사가 아닌 감사위원) 참석여부',
  `popt_ctr_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '풋옵션 등 계약 체결여부',
  `popt_ctr_cn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '계약내용',
  `rs_sm_atn` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증권신고서 제출대상 여부',
  `ex_sm_r` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '제출을 면제받은 경우 그 사유',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>주식교환·이전 결정	';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_4 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_4`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_4` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `apcnt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신청인 (회사와의 관계)',
  `cpct` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '관할법원',
  `rq_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신청사유',
  `rqd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신청일자',
  `ft_ctp_sc` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '향후대책 및 일정',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보> 회생절차 개시신청\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_5 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_5`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_5` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `ds_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '해산사유',
  `ds_rsd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '해산사유발생일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석)',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참)',
  `adt_a_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원) 참석 여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>해산사유 발생\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_6 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_6`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_6` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `nstk_ostk_cnt` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 종류와 수(보통주식 (주))',
  `nstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 종류와 수(기타주식 (주))',
  `fv_ps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 액면가액 (원)',
  `bfic_tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증자전 발행주식총수 (주)(보통주식 (주))',
  `bfic_tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증자전 발행주식총수 (주)(기타주식 (주))',
  `fdpp_fclt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(시설자금 (원))',
  `fdpp_bsninh` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(영업양수자금 (원))',
  `fdpp_op` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(운영자금 (원))',
  `fdpp_dtrp` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(채무상환자금 (원))',
  `fdpp_ocsa` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(타법인 증권 취득자금 (원))',
  `fdpp_etc` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '자금조달의 목적(기타자금 (원))',
  `ic_mthn` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증자방식',
  `ssl_at` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 해당여부',
  `ssl_bgd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 시작일',
  `ssl_edd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 종료일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>유상증자 결정		\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_7 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_7`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_7` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `nstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 종류와 수(보통주식 (주))',
  `nstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 종류와 수(기타주식 (주))',
  `fv_ps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 액면가액 (원)',
  `bfic_tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증자전 발행주식총수 (주)(보통주식 (주))',
  `bfic_tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '증자전 발행주식총수 (주)(기타주식 (주))',
  `nstk_asstd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주배정기준일',
  `nstk_ascnt_ps_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 신주배정 주식수(보통주식 (주))',
  `nstk_ascnt_ps_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 신주배정 주식수(기타주식 (주))',
  `nstk_dividrk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 배당기산일',
  `nstk_dlprd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주권교부예정일',
  `nstk_lstprd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '신주의 상장 예정일',
  `bddd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참(명))',
  `adt_a_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원)참석 여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>무상증자 결정\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_8 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_8`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_8` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `piic_nstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(신주의 종류와 수(보통주식 (주)))',
  `piic_nstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(신주의 종류와 수(기타주식 (주)))',
  `piic_fv_ps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(1주당 액면가액 (원))',
  `piic_bfic_tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(증자전 발행주식총수 (주)(보통주식 (주)))',
  `piic_bfic_tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(증자전 발행주식총수 (주)(기타주식 (주)))',
  `piic_fdpp_fclt` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(시설자금 (원)))',
  `piic_fdpp_bsninh` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(영업양수자금 (원)))',
  `piic_fdpp_op` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(운영자금 (원)))',
  `piic_fdpp_dtrp` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(채무상환자금 (원)))',
  `piic_fdpp_ocsa` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(타법인 증권 취득자금 (원)))',
  `piic_fdpp_etc` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(자금조달의 목적(기타자금 (원)))',
  `piic_ic_mthn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '유상증자(증자방식)',
  `fric_nstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주의 종류와 수(보통주식 (주)))',
  `fric_nstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주의 종류와 수(기타주식 (주)))',
  `fric_fv_ps` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(1주당 액면가액 (원))',
  `fric_bfic_tisstk_ostk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(증자전 발행주식총수(보통주식 (주)))',
  `fric_bfic_tisstk_estk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(증자전 발행주식총수(기타주식 (주)))',
  `fric_nstk_asstd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주배정기준일)',
  `fric_nstk_ascnt_ps_ostk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(1주당 신주배정 주식수(보통주식 (주)))',
  `fric_nstk_ascnt_ps_estk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(1주당 신주배정 주식수(기타주식 (주)))',
  `fric_nstk_dividrk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주의 배당기산일)',
  `fric_nstk_dlprd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주권교부예정일)',
  `fric_nstk_lstprd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(신주의 상장 예정일)',
  `fric_bddd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(이사회결의일(결정일))',
  `fric_od_a_at_t` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(사외이사 참석여부(참석(명)))',
  `fric_od_a_at_b` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(사외이사 참석여부(불참(명)))',
  `fric_adt_a_atn` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '무상증자(감사(감사위원)참석 여부)',
  `ssl_at` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 해당여부',
  `ssl_bgd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 시작일',
  `ssl_edd` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공매도 종료일',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rcept_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>유무상증자 결정\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_DA_AP_5_9 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_DA_AP_5_9`;
CREATE TABLE IF NOT EXISTS `STG_OP_DA_AP_5_9` (
  `rcept_no` varchar(14) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '접수번호',
  `corp_cls` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '법인구분',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '회사명',
  `crstk_ostk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자주식의 종류와 수(보통주식 (주))',
  `crstk_estk_cnt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자주식의 종류와 수(기타주식 (주))',
  `fv_ps` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '1주당 액면가액 (원)',
  `bfcr_cpt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 자본금(감자전 (원))',
  `atcr_cpt` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 자본금(감자후 (원))',
  `bfcr_tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 발행주식수(보통주식 (주)(감자전 (원)))',
  `atcr_tisstk_ostk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 발행주식수(보통주식 (주)(감자후 (원)))',
  `bfcr_tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 발행주식수(기타주식 (주)(감자전 (원)))',
  `atcr_tisstk_estk` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자전후 발행주식수(기타주식 (주)(감자후 (원)))',
  `cr_rt_ostk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자비율(보통주식 (%))',
  `cr_rt_estk` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자비율(기타주식 (%))',
  `cr_std` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자기준일',
  `cr_mth` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자방법',
  `cr_rs` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자사유',
  `crsc_gmtsck_prd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(주주총회 예정일)',
  `crsc_trnmsppd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(명의개서정지기간)',
  `crsc_osprpd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(구주권 제출기간)',
  `crsc_trspprpd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(매매거래 정지예정기간)',
  `crsc_osprpd_bgd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(구주권 제출기간(시작일))',
  `crsc_osprpd_edd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(구주권 제출기간(종료일))',
  `crsc_trspprpd_bgd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(매매거래 정지예정기간(시작일))',
  `crsc_trspprpd_edd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(매매거래 정지예정기간(종료일))',
  `crsc_nstkdlprd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(신주권교부예정일)',
  `crsc_nstklstprd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감자일정(신주상장예정일)',
  `cdobprpd_bgd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '채권자 이의제출기간(시작일)',
  `cdobprpd_edd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '채권자 이의제출기간(종료일)',
  `ospr_nstkdl_pl` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '구주권제출 및 신주권교부장소',
  `bddd` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '이사회결의일(결정일)',
  `od_a_at_t` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(참석(명))',
  `od_a_at_b` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '사외이사 참석여부(불참(명))',
  `adt_a_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '감사(감사위원) 참석여부',
  `ftc_stt_atn` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '공정거래위원회 신고대상 여부',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC COMMENT='오픈다트>주요사항보고서 주요정보>감자 결정\r\n\r\n\r\n		\r\n\r\n\r\n\r\n\r\n\r\n\r\n\r\n';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_GET_API_LOG 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_GET_API_LOG`;
CREATE TABLE IF NOT EXISTS `STG_OP_GET_API_LOG` (
  `SOAL_DM_ID` int NOT NULL AUTO_INCREMENT COMMENT 'P-KEY',
  `SOAL_TABLE_ID` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수집 테이블명',
  `SOAL_CORP_CODE` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업 코드',
  `SOAL_YEAR` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기준 년도',
  `SOAL_PBINTF_TY` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '보고서 구분',
  `SOAL_REPORT_CODE` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '11011-사업,11012-반기, 11013-1분기, 11014-3분기',
  `SOAL_CRD_DT` datetime DEFAULT (curdate()) COMMENT '최초수집일',
  `SOAL_UPD_DT` datetime DEFAULT (curdate()) COMMENT '최종수집일',
  `SOAL_DATA_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수신 데이터가 있는지?',
  `SOAL_RETRY_YN` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '수집중단여부',
  PRIMARY KEY (`SOAL_DM_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='오픈다트 호출 로그';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 테이블 etoday_corp.STG_OP_GOVE_MAP 구조 내보내기
DROP TABLE IF EXISTS `STG_OP_GOVE_MAP`;
CREATE TABLE IF NOT EXISTS `STG_OP_GOVE_MAP` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `file_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ex) gove/2024.pdf',
  `file_page` int DEFAULT NULL COMMENT '해당기업페이지',
  `corp_code` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업고유번호',
  `corp_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '기업명',
  `stock_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장코드',
  `stock_name` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '상장명',
  `group_code` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '그룹회사코드',
  `group_nm` varchar(6) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '그룹회사명',
  `std_year` varchar(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '조회년도',
  `created_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  KEY `idx_year_page` (`std_year`,`file_page`)
) ENGINE=InnoDB AUTO_INCREMENT=4607 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='지배구조 전체보기 PDF정보';

-- 내보낼 데이터가 선택되어 있지 않습니다.

-- 뷰 etoday_corp.VW_ANOMALY_DETECTION 구조 내보내기
DROP VIEW IF EXISTS `VW_ANOMALY_DETECTION`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_ANOMALY_DETECTION` (
	`rcept_no` VARCHAR(14) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` CHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`relate` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`stock_knd` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`bsis_posesn_stock_co` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`bsis_posesn_stock_qota_rt` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_co` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_qota_rt` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`rm` VARCHAR(500) NULL COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COLLATE 'utf8mb4_unicode_ci',
	`rcept_dt` VARCHAR(10) NULL COLLATE 'utf8mb4_unicode_ci',
	`report_tp` VARCHAR(50) NULL COLLATE 'utf8mb4_unicode_ci',
	`repror` VARCHAR(50) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkqy` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkqy_irds` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkrt` VARCHAR(15) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkrt_irds` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`ctr_stkqy` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`ctr_stkrt` VARCHAR(15) NULL COLLATE 'utf8mb4_unicode_ci',
	`report_resn` VARCHAR(500) NULL COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_BONUS_ISSUE 구조 내보내기
DROP VIEW IF EXISTS `VW_BONUS_ISSUE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_BONUS_ISSUE` (
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`rcept_no` VARCHAR(14) NOT NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '회사명' COLLATE 'utf8mb4_unicode_ci',
	`nstk_ostk_cnt` VARCHAR(25) NULL COMMENT '신주의 종류와 수(보통주식 (주))' COLLATE 'utf8mb4_unicode_ci',
	`fv_ps` VARCHAR(25) NULL COMMENT '1주당 액면가액 (원)' COLLATE 'utf8mb4_unicode_ci',
	`bddd` VARCHAR(10) NULL COMMENT '이사회결의일(결정일)' COLLATE 'utf8mb4_unicode_ci',
	`own_stock_amount` DECIMAL(40,0) NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_EXECUTIVE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_EXECUTIVE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_EXECUTIVE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` CHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(50) NULL COMMENT '성명' COLLATE 'utf8mb4_unicode_ci',
	`sexdstn` CHAR(1) NULL COMMENT '성별' COLLATE 'utf8mb4_unicode_ci',
	`ofcps` VARCHAR(25) NULL COMMENT '직위' COLLATE 'utf8mb4_unicode_ci',
	`rgist_exctv_at` VARCHAR(25) NULL COMMENT '등기 임원 여부' COLLATE 'utf8mb4_unicode_ci',
	`chrg_job` VARCHAR(500) NULL COMMENT '담당 업무' COLLATE 'utf8mb4_unicode_ci',
	`hffc_pd` VARCHAR(100) NULL COMMENT '재직 기간' COLLATE 'utf8mb4_unicode_ci',
	`tenure_end_on` VARCHAR(25) NULL COMMENT '임기 만료 일' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_HOLDER 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_HOLDER`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_HOLDER` (
	`corp_name` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`rcept_no` VARCHAR(14) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkqy` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkrt` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`holder_type` VARCHAR(5) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`stml_dt` VARCHAR(10) NULL COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_HOLDER_ORIGIN 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_HOLDER_ORIGIN`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_HOLDER_ORIGIN` (
	`corp_name` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`rcept_no` VARCHAR(14) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(100) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkqy` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`stkrt` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` VARCHAR(1) NULL COLLATE 'utf8mb4_unicode_ci',
	`holder_type` VARCHAR(5) NOT NULL COLLATE 'utf8mb4_0900_ai_ci',
	`stml_dt` VARCHAR(10) NULL COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL,
	`_corp_name` VARCHAR(500) NULL COMMENT '기업이름' COLLATE 'utf8mb4_unicode_ci',
	`_corp_code` VARCHAR(8) NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`_corp_cls` VARCHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_INFO 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_INFO`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_INFO` (
	`unityGrupCode` VARCHAR(8) NOT NULL COMMENT '기업집단코드' COLLATE 'utf8mb4_unicode_ci',
	`unityGrupNm` VARCHAR(200) NULL COMMENT '기업집단명' COLLATE 'utf8mb4_unicode_ci',
	`smerNm` VARCHAR(200) NULL COMMENT '동일인' COLLATE 'utf8mb4_unicode_ci',
	`repreCmpny` VARCHAR(200) NULL COMMENT '대표회사' COLLATE 'utf8mb4_unicode_ci',
	`sumCmpnyCo` VARCHAR(4) NULL COMMENT '계열회사 수' COLLATE 'utf8mb4_unicode_ci',
	`entrprsNm` VARCHAR(100) NULL COMMENT '기업명' COLLATE 'utf8mb4_unicode_ci',
	`jurirno` VARCHAR(13) NOT NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`rprsntvNm` VARCHAR(50) NULL COMMENT '대표자명' COLLATE 'utf8mb4_unicode_ci',
	`fondDe` VARCHAR(8) NULL COMMENT '기업설립일' COLLATE 'utf8mb4_unicode_ci',
	`grinil` VARCHAR(8) NULL COMMENT '계열편입일' COLLATE 'utf8mb4_unicode_ci',
	`bizrno` VARCHAR(10) NULL COMMENT '사업자등록번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`corp_name_eng` VARCHAR(500) NULL COMMENT '영문정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`stock_name` VARCHAR(8) NULL COMMENT '종목명(상장사) 또는 약식명칭(기타법인)' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`ceo_nm` VARCHAR(100) NULL COMMENT '대표자명' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` VARCHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`bizr_no` VARCHAR(100) NULL COMMENT '사업자등록번호' COLLATE 'utf8mb4_unicode_ci',
	`adres` VARCHAR(100) NULL COMMENT '주소' COLLATE 'utf8mb4_unicode_ci',
	`hm_url` VARCHAR(500) NULL COMMENT '홈페이지' COLLATE 'utf8mb4_unicode_ci',
	`ir_url` VARCHAR(500) NULL COMMENT 'IR홈페이지' COLLATE 'utf8mb4_unicode_ci',
	`phn_no` VARCHAR(25) NULL COMMENT '전화번호' COLLATE 'utf8mb4_unicode_ci',
	`fax_no` VARCHAR(25) NULL COMMENT '팩스번호' COLLATE 'utf8mb4_unicode_ci',
	`induty_code` VARCHAR(10) NULL COMMENT '업종코드' COLLATE 'utf8mb4_unicode_ci',
	`est_dt` VARCHAR(8) NULL COMMENT '설립일(YYYYMMDD)' COLLATE 'utf8mb4_unicode_ci',
	`acc_mt` VARCHAR(2) NULL COMMENT '결산월(MM)' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL COMMENT '등록일'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_INFO_BASE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_INFO_BASE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_INFO_BASE` (
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`corp_name_eng` VARCHAR(500) NULL COMMENT '영문정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`stock_name` VARCHAR(8) NULL COMMENT '종목명(상장사) 또는 약식명칭(기타법인)' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`ceo_nm` VARCHAR(100) NULL COMMENT '대표자명' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` VARCHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`bizr_no` VARCHAR(100) NULL COMMENT '사업자등록번호' COLLATE 'utf8mb4_unicode_ci',
	`adres` VARCHAR(100) NULL COMMENT '주소' COLLATE 'utf8mb4_unicode_ci',
	`hm_url` VARCHAR(500) NULL COMMENT '홈페이지' COLLATE 'utf8mb4_unicode_ci',
	`ir_url` VARCHAR(500) NULL COMMENT 'IR홈페이지' COLLATE 'utf8mb4_unicode_ci',
	`phn_no` VARCHAR(25) NULL COMMENT '전화번호' COLLATE 'utf8mb4_unicode_ci',
	`fax_no` VARCHAR(25) NULL COMMENT '팩스번호' COLLATE 'utf8mb4_unicode_ci',
	`induty_code` VARCHAR(10) NULL COMMENT '업종코드' COLLATE 'utf8mb4_unicode_ci',
	`est_dt` VARCHAR(8) NULL COMMENT '설립일(YYYYMMDD)' COLLATE 'utf8mb4_unicode_ci',
	`acc_mt` VARCHAR(2) NULL COMMENT '결산월(MM)' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL COMMENT '등록일',
	`unityGrupCode` VARCHAR(8) NULL COMMENT '기업집단코드' COLLATE 'utf8mb4_unicode_ci',
	`unityGrupNm` VARCHAR(200) NULL COMMENT '기업집단명' COLLATE 'utf8mb4_unicode_ci',
	`smerNm` VARCHAR(200) NULL COMMENT '동일인' COLLATE 'utf8mb4_unicode_ci',
	`repreCmpny` VARCHAR(200) NULL COMMENT '대표회사' COLLATE 'utf8mb4_unicode_ci',
	`sumCmpnyCo` VARCHAR(4) NULL COMMENT '계열회사 수' COLLATE 'utf8mb4_unicode_ci',
	`entrprsNm` VARCHAR(100) NULL COMMENT '기업명' COLLATE 'utf8mb4_unicode_ci',
	`rprsntvNm` VARCHAR(50) NULL COMMENT '대표자명' COLLATE 'utf8mb4_unicode_ci',
	`fondDe` VARCHAR(8) NULL COMMENT '기업설립일' COLLATE 'utf8mb4_unicode_ci',
	`grinil` VARCHAR(8) NULL COMMENT '계열편입일' COLLATE 'utf8mb4_unicode_ci',
	`INDEX_TYPE` VARCHAR(10) NULL COMMENT '업종코드' COLLATE 'utf8mb4_unicode_ci',
	`INDEX_TYPE_NM` VARCHAR(15) NULL COMMENT '업종명' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_OWNERSHIP 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_OWNERSHIP`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_OWNERSHIP` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` CHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '회사명' COLLATE 'utf8mb4_unicode_ci',
	`inv_prm` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`frst_acqs_de` VARCHAR(10) NULL COMMENT '최초 취득 일자' COLLATE 'utf8mb4_unicode_ci',
	`invstmnt_purps` VARCHAR(50) NULL COMMENT '출자 목적' COLLATE 'utf8mb4_unicode_ci',
	`frst_acqs_amount` VARCHAR(25) NULL COMMENT '최초 취득 금액' COLLATE 'utf8mb4_unicode_ci',
	`bsis_blce_qy` VARCHAR(25) NULL COMMENT '기초 잔액 수량' COLLATE 'utf8mb4_unicode_ci',
	`bsis_blce_qota_rt` VARCHAR(25) NULL COMMENT '기초 잔액 지분 율' COLLATE 'utf8mb4_unicode_ci',
	`bsis_blce_acntbk_amount` VARCHAR(25) NULL COMMENT '기초 잔액 장부 가액' COLLATE 'utf8mb4_unicode_ci',
	`incrs_dcrs_acqs_dsps_qy` VARCHAR(25) NULL COMMENT '증가 감소 취득 처분 수량' COLLATE 'utf8mb4_unicode_ci',
	`incrs_dcrs_acqs_dsps_amount` VARCHAR(25) NULL COMMENT '증가 감소 취득 처분 금액' COLLATE 'utf8mb4_unicode_ci',
	`incrs_dcrs_evl_lstmn` VARCHAR(25) NULL COMMENT '증가 감소 평가 손액' COLLATE 'utf8mb4_unicode_ci',
	`trmend_blce_qy` VARCHAR(25) NULL COMMENT '기말 잔액 수량' COLLATE 'utf8mb4_unicode_ci',
	`trmend_blce_qota_rt` VARCHAR(25) NULL COMMENT '기말 잔액 지분 율' COLLATE 'utf8mb4_unicode_ci',
	`trmend_blce_acntbk_amount` VARCHAR(25) NULL COMMENT '기말 잔액 장부 가액' COLLATE 'utf8mb4_unicode_ci',
	`recent_bsns_year_fnnr_sttus_tot_assets` VARCHAR(25) NULL COMMENT '최근 사업 연도 재무 현황 총 자산' COLLATE 'utf8mb4_unicode_ci',
	`recent_bsns_year_fnnr_sttus_thstrm_ntpf` VARCHAR(25) NULL COMMENT '최근 사업 연도 재무 현황 당기 순이익' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL,
	`_corp_code` VARCHAR(8) NULL COMMENT '기업 고유번호' COLLATE 'utf8mb4_unicode_ci',
	`_corp_name` VARCHAR(500) NULL COMMENT '종목명(법인명)' COLLATE 'utf8mb4_unicode_ci',
	`_corp_cls` VARCHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_REVENUE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_REVENUE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`reprt_code` VARCHAR(5) NULL COMMENT '보고서 코드' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`account_nm` VARCHAR(25) NULL COMMENT '계정명' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_amount` VARCHAR(25) NULL COMMENT '당기금액' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_dt` VARCHAR(25) NULL COMMENT '당기일자' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COMMENT '사업 연도' COLLATE 'utf8mb4_unicode_ci',
	`fs_div` VARCHAR(25) NULL COMMENT '개별/연결구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_REVENUE_PROFIT 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE_PROFIT`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_REVENUE_PROFIT` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`reprt_code` VARCHAR(5) NULL COMMENT '보고서 코드' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`account_nm` VARCHAR(25) NULL COMMENT '계정명' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_amount` VARCHAR(25) NULL COMMENT '당기금액' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_dt` VARCHAR(25) NULL COMMENT '당기일자' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COMMENT '사업 연도' COLLATE 'utf8mb4_unicode_ci',
	`fs_div` VARCHAR(25) NULL COMMENT '개별/연결구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_CORP_REVENUE_TAKE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE_TAKE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_CORP_REVENUE_TAKE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`reprt_code` VARCHAR(5) NULL COMMENT '보고서 코드' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`account_nm` VARCHAR(25) NULL COMMENT '계정명' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_amount` VARCHAR(25) NULL COMMENT '당기금액' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_dt` VARCHAR(25) NULL COMMENT '당기일자' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COMMENT '사업 연도' COLLATE 'utf8mb4_unicode_ci',
	`fs_div` VARCHAR(25) NULL COMMENT '개별/연결구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_DISCLOSURE_SEARCH 구조 내보내기
DROP VIEW IF EXISTS `VW_DISCLOSURE_SEARCH`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_DISCLOSURE_SEARCH` (
	`corp_code` VARCHAR(8) NULL COMMENT '기업 고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` VARCHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`report_nm` VARCHAR(500) NULL COMMENT '보고서명' COLLATE 'utf8mb4_unicode_ci',
	`rcept_no` VARCHAR(14) NOT NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`flr_nm` VARCHAR(100) NULL COMMENT '공시 제출인명' COLLATE 'utf8mb4_unicode_ci',
	`pblntf_ty` VARCHAR(1) NULL COMMENT '공시유형(A~J)' COLLATE 'utf8mb4_unicode_ci',
	`rcept_dt` VARCHAR(10) NULL COMMENT '접수일자' COLLATE 'utf8mb4_unicode_ci',
	`rm` VARCHAR(100) NULL COMMENT '비고' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_DISCLOSURE_SUMMARY 구조 내보내기
DROP VIEW IF EXISTS `VW_DISCLOSURE_SUMMARY`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_DISCLOSURE_SUMMARY` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`file_name` VARCHAR(255) NULL COMMENT '파일명' COLLATE 'utf8mb4_unicode_ci',
	`content` VARBINARY NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_FILE_CONTENT_FILTER 구조 내보내기
DROP VIEW IF EXISTS `VW_FILE_CONTENT_FILTER`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_FILE_CONTENT_FILTER` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`file_content` LONGTEXT NULL COMMENT '텍스트 파일 내용' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_MAJOR_HOLDER 구조 내보내기
DROP VIEW IF EXISTS `VW_MAJOR_HOLDER`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_MAJOR_HOLDER` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(100) NULL COMMENT '성명' COLLATE 'utf8mb4_unicode_ci',
	`relate` VARCHAR(100) NULL COMMENT '관계' COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_co` VARCHAR(25) NULL COMMENT '기말 소유 주식 수' COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_qota_rt` VARCHAR(25) NULL COMMENT '기말 소유 주식 지분 율' COLLATE 'utf8mb4_unicode_ci',
	`stock_knd` VARCHAR(100) NULL COMMENT '주식 종류' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_MINORITY_HOLDERS_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_MINORITY_HOLDERS_RATE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_MINORITY_HOLDERS_RATE` (
	`rcept_no` VARCHAR(14) NOT NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`hold_stock_rate` VARCHAR(25) NULL COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_NPS_INVESTED_COMPANY 구조 내보내기
DROP VIEW IF EXISTS `VW_NPS_INVESTED_COMPANY`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_NPS_INVESTED_COMPANY` (
	`rcept_no` VARCHAR(14) NOT NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(50) NULL COMMENT '회사명' COLLATE 'utf8mb4_unicode_ci',
	`stkqy` VARCHAR(25) NULL COMMENT '보유주식등의 수' COLLATE 'utf8mb4_unicode_ci',
	`stkrt` VARCHAR(15) NULL COMMENT '보유비율' COLLATE 'utf8mb4_unicode_ci',
	`repror` VARCHAR(50) NULL COMMENT '대표보고자' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` CHAR(6) NULL COMMENT '종목코드' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_OWN_STOCK_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_OWN_STOCK_RATE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_OWN_STOCK_RATE` (
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`rcept_no` VARCHAR(14) NOT NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '회사명' COLLATE 'utf8mb4_unicode_ci',
	`nstk_ostk_cnt` VARCHAR(25) NULL COMMENT '신주의 종류와 수(보통주식 (주))' COLLATE 'utf8mb4_unicode_ci',
	`bfic_tisstk_ostk` VARCHAR(25) NULL COMMENT '증자전 발행주식총수 (주)(보통주식 (주))' COLLATE 'utf8mb4_unicode_ci',
	`own_stock_rate` DECIMAL(36,2) NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_PERMANANT_EMPLOYEE 구조 내보내기
DROP VIEW IF EXISTS `VW_PERMANANT_EMPLOYEE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_PERMANANT_EMPLOYEE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`fo_bbm` VARCHAR(50) NULL COMMENT '사업부문' COLLATE 'utf8mb4_unicode_ci',
	`sexdstn` CHAR(1) NULL COMMENT '성별' COLLATE 'utf8mb4_unicode_ci',
	`rgllbr_co` VARCHAR(25) NULL COMMENT '정규직 수' COLLATE 'utf8mb4_unicode_ci',
	`rgllbr_abacpt_labrr_co` VARCHAR(25) NULL COMMENT '정규직 단시간 근로자 수' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_PRV_MAJOR_HOLDER_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_PRV_MAJOR_HOLDER_RATE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_PRV_MAJOR_HOLDER_RATE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`nm` VARCHAR(100) NULL COMMENT '성명' COLLATE 'utf8mb4_unicode_ci',
	`stock_knd` VARCHAR(100) NULL COMMENT '주식 종류' COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_co` VARCHAR(25) NULL COMMENT '기말 소유 주식 수' COLLATE 'utf8mb4_unicode_ci',
	`trmend_posesn_stock_qota_rt` VARCHAR(25) NULL COMMENT '기말 소유 주식 지분 율' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_REVENUE_PROFIT 구조 내보내기
DROP VIEW IF EXISTS `VW_REVENUE_PROFIT`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_REVENUE_PROFIT` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`jurir_no` VARCHAR(100) NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(500) NULL COMMENT '정식회사명칭' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NOT NULL COMMENT '기업코드' COLLATE 'utf8mb4_unicode_ci',
	`stock_code` VARCHAR(6) NULL COMMENT '종목코드(6자리)' COLLATE 'utf8mb4_unicode_ci',
	`account_nm` VARCHAR(25) NULL COMMENT '계정명' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_amount` VARCHAR(25) NULL COMMENT '당기금액' COLLATE 'utf8mb4_unicode_ci',
	`thstrm_dt` VARCHAR(25) NULL COMMENT '당기일자' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COMMENT '사업 연도' COLLATE 'utf8mb4_unicode_ci',
	`fs_div` VARCHAR(25) NULL COMMENT '개별/연결구분' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_SELF_STOCK_RANK 구조 내보내기
DROP VIEW IF EXISTS `VW_SELF_STOCK_RANK`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_SELF_STOCK_RANK` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_cls` CHAR(1) NULL COMMENT '법인구분' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '법인명' COLLATE 'utf8mb4_unicode_ci',
	`acqs_mth1` VARCHAR(100) NULL COMMENT '취득방법 대분류' COLLATE 'utf8mb4_unicode_ci',
	`acqs_mth2` VARCHAR(100) NULL COMMENT '취득방법 중분류' COLLATE 'utf8mb4_unicode_ci',
	`acqs_mth3` VARCHAR(100) NULL COMMENT '취득방법 소분류' COLLATE 'utf8mb4_unicode_ci',
	`change_qy_acqs` VARCHAR(100) NULL COMMENT '변동 수량 취득' COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`created_at` TIMESTAMP NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_SELF_STOCK_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_SELF_STOCK_RATE`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_SELF_STOCK_RATE` (
	`rcept_no` VARCHAR(14) NULL COMMENT '접수번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_code` VARCHAR(8) NULL COMMENT '고유번호' COLLATE 'utf8mb4_unicode_ci',
	`corp_name` VARCHAR(100) NULL COMMENT '회사명' COLLATE 'utf8mb4_unicode_ci',
	`tesstk_co` VARCHAR(25) NULL COMMENT '자기주식수' COLLATE 'utf8mb4_unicode_ci',
	`istc_totqy` VARCHAR(25) NULL COMMENT '발행주식의 총수' COLLATE 'utf8mb4_unicode_ci',
	`bsns_year` VARCHAR(4) NULL COLLATE 'utf8mb4_unicode_ci',
	`stlm_dt` VARCHAR(10) NULL COMMENT '결산기준일' COLLATE 'utf8mb4_unicode_ci',
	`self_stock_rate` DECIMAL(26,2) NULL
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_TOP_LIST_SUBSIDIARIES 구조 내보내기
DROP VIEW IF EXISTS `VW_TOP_LIST_SUBSIDIARIES`;
-- VIEW 종속성 오류를 극복하기 위해 임시 테이블을 생성합니다.
CREATE TABLE `VW_TOP_LIST_SUBSIDIARIES` (
	`jurirno` VARCHAR(13) NOT NULL COMMENT '법인등록번호' COLLATE 'utf8mb4_unicode_ci',
	`unityGrupNm` VARCHAR(200) NULL COMMENT '지주회사명' COLLATE 'utf8mb4_unicode_ci',
	`cdpnyLstCo` VARCHAR(10) NULL COMMENT '자회사상장수' COLLATE 'utf8mb4_unicode_ci',
	`fnncSeCodeNm` VARCHAR(50) NULL COMMENT '회사구분 - 일반 - 금융보험' COLLATE 'utf8mb4_unicode_ci'
) ENGINE=MyISAM;

-- 뷰 etoday_corp.VW_ANOMALY_DETECTION 구조 내보내기
DROP VIEW IF EXISTS `VW_ANOMALY_DETECTION`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_ANOMALY_DETECTION`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_ANOMALY_DETECTION` AS select `STG_OP_DA_AP_2_4`.`rcept_no` AS `rcept_no`,`STG_OP_DA_AP_2_4`.`corp_code` AS `corp_code`,`STG_OP_DA_AP_2_4`.`corp_name` AS `corp_name`,`STG_OP_DA_AP_2_4`.`corp_cls` AS `corp_cls`,`STG_OP_DA_AP_2_4`.`nm` AS `nm`,`STG_OP_DA_AP_2_4`.`relate` AS `relate`,`STG_OP_DA_AP_2_4`.`stock_knd` AS `stock_knd`,`STG_OP_DA_AP_2_4`.`bsis_posesn_stock_co` AS `bsis_posesn_stock_co`,`STG_OP_DA_AP_2_4`.`bsis_posesn_stock_qota_rt` AS `bsis_posesn_stock_qota_rt`,`STG_OP_DA_AP_2_4`.`trmend_posesn_stock_co` AS `trmend_posesn_stock_co`,`STG_OP_DA_AP_2_4`.`trmend_posesn_stock_qota_rt` AS `trmend_posesn_stock_qota_rt`,`STG_OP_DA_AP_2_4`.`rm` AS `rm`,`STG_OP_DA_AP_2_4`.`stlm_dt` AS `stlm_dt`,NULL AS `rcept_dt`,NULL AS `report_tp`,NULL AS `repror`,NULL AS `stkqy`,NULL AS `stkqy_irds`,NULL AS `stkrt`,NULL AS `stkrt_irds`,NULL AS `ctr_stkqy`,NULL AS `ctr_stkrt`,NULL AS `report_resn`,`STG_OP_DA_AP_2_4`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_4` union all select `STG_OP_DA_AP_4_1`.`rcept_no` AS `rcept_no`,`STG_OP_DA_AP_4_1`.`corp_code` AS `corp_code`,`STG_OP_DA_AP_4_1`.`corp_name` AS `corp_name`,NULL AS `corp_cls`,NULL AS `nm`,NULL AS `relate`,NULL AS `stock_knd`,NULL AS `bsis_posesn_stock_co`,NULL AS `bsis_posesn_stock_qota_rt`,NULL AS `trmend_posesn_stock_co`,NULL AS `trmend_posesn_stock_qota_rt`,NULL AS `rm`,NULL AS `stlm_dt`,`STG_OP_DA_AP_4_1`.`rcept_dt` AS `rcept_dt`,`STG_OP_DA_AP_4_1`.`report_tp` AS `report_tp`,`STG_OP_DA_AP_4_1`.`repror` AS `repror`,`STG_OP_DA_AP_4_1`.`stkqy` AS `stkqy`,`STG_OP_DA_AP_4_1`.`stkqy_irds` AS `stkqy_irds`,`STG_OP_DA_AP_4_1`.`stkrt` AS `stkrt`,`STG_OP_DA_AP_4_1`.`stkrt_irds` AS `stkrt_irds`,`STG_OP_DA_AP_4_1`.`ctr_stkqy` AS `ctr_stkqy`,`STG_OP_DA_AP_4_1`.`ctr_stkrt` AS `ctr_stkrt`,`STG_OP_DA_AP_4_1`.`report_resn` AS `report_resn`,`STG_OP_DA_AP_4_1`.`created_at` AS `created_at` from `STG_OP_DA_AP_4_1` order by `rcept_no` desc;

-- 뷰 etoday_corp.VW_BONUS_ISSUE 구조 내보내기
DROP VIEW IF EXISTS `VW_BONUS_ISSUE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_BONUS_ISSUE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_BONUS_ISSUE` AS select `a`.`corp_code` AS `corp_code`,`a`.`rcept_no` AS `rcept_no`,`a`.`corp_name` AS `corp_name`,`a`.`nstk_ostk_cnt` AS `nstk_ostk_cnt`,`a`.`fv_ps` AS `fv_ps`,`a`.`bddd` AS `bddd`,(cast(regexp_replace(`a`.`nstk_ostk_cnt`,'[^0-9.-]','') as decimal(20,0)) * cast(regexp_replace(`a`.`fv_ps`,'[^0-9.-]','') as decimal(20,0))) AS `own_stock_amount` from `STG_OP_DA_AP_5_7` `a`;

-- 뷰 etoday_corp.VW_CORP_EXECUTIVE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_EXECUTIVE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_EXECUTIVE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_EXECUTIVE` AS select `STG_OP_DA_AP_2_7`.`rcept_no` AS `rcept_no`,`STG_OP_DA_AP_2_7`.`corp_cls` AS `corp_cls`,`STG_OP_DA_AP_2_7`.`corp_code` AS `corp_code`,`STG_OP_DA_AP_2_7`.`corp_name` AS `corp_name`,`STG_OP_DA_AP_2_7`.`nm` AS `nm`,`STG_OP_DA_AP_2_7`.`sexdstn` AS `sexdstn`,`STG_OP_DA_AP_2_7`.`ofcps` AS `ofcps`,`STG_OP_DA_AP_2_7`.`rgist_exctv_at` AS `rgist_exctv_at`,`STG_OP_DA_AP_2_7`.`chrg_job` AS `chrg_job`,`STG_OP_DA_AP_2_7`.`hffc_pd` AS `hffc_pd`,`STG_OP_DA_AP_2_7`.`tenure_end_on` AS `tenure_end_on`,`STG_OP_DA_AP_2_7`.`stlm_dt` AS `stlm_dt`,`STG_OP_DA_AP_2_7`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_7`;

-- 뷰 etoday_corp.VW_CORP_HOLDER 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_HOLDER`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_HOLDER`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_HOLDER` AS select `a`.`corp_name` AS `corp_name`,`a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`repror` AS `nm`,`a`.`stkqy` AS `stkqy`,`a`.`stkrt` AS `stkrt`,`g`.`corp_cls` AS `corp_cls`,'대주주' AS `holder_type`,`a`.`rcept_dt` AS `stml_dt`,`a`.`created_at` AS `created_at` from (`STG_OP_DA_AP_4_1` `a` left join `STG_OP_DA_AP_1_2` `g` on((`a`.`corp_code` = `g`.`corp_code`))) where (`a`.`stkrt` <> '0') union all select `b`.`corp_name` AS `corp_name`,`b`.`rcept_no` AS `rcept_no`,`b`.`corp_code` AS `corp_code`,`b`.`nm` AS `nm`,`b`.`trmend_posesn_stock_co` AS `stkqy`,`b`.`trmend_posesn_stock_qota_rt` AS `stkrt`,`b`.`corp_cls` AS `corp_cls`,'특수관계인' AS `holder_type`,`b`.`stlm_dt` AS `stml_dt`,`b`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_4` `b` where ((`b`.`nm` <> '계') and (`b`.`nm` <> '-') and (`b`.`trmend_posesn_stock_co` <> '0') and (`b`.`trmend_posesn_stock_qota_rt` <> '0'));

-- 뷰 etoday_corp.VW_CORP_HOLDER_ORIGIN 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_HOLDER_ORIGIN`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_HOLDER_ORIGIN`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_HOLDER_ORIGIN` AS with `hh` as (select `a`.`corp_name` AS `corp_name`,`a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`repror` AS `nm`,`a`.`stkqy` AS `stkqy`,`a`.`stkrt` AS `stkrt`,`g`.`corp_cls` AS `corp_cls`,'대주주' AS `holder_type`,`a`.`rcept_dt` AS `stml_dt`,`a`.`created_at` AS `created_at` from (`STG_OP_DA_AP_4_1` `a` left join `STG_OP_DA_AP_1_2` `g` on((`a`.`corp_code` = `g`.`corp_code`))) where (`a`.`stkrt` <> '0') union all select `b`.`corp_name` AS `corp_name`,`b`.`rcept_no` AS `rcept_no`,`b`.`corp_code` AS `corp_code`,`b`.`nm` AS `nm`,`b`.`trmend_posesn_stock_co` AS `stkqy`,`b`.`trmend_posesn_stock_qota_rt` AS `stkrt`,`b`.`corp_cls` AS `corp_cls`,'특수관계인' AS `holder_type`,`b`.`stlm_dt` AS `stml_dt`,`b`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_4` `b` where ((`b`.`nm` <> '계') and (`b`.`nm` <> '-') and (`b`.`trmend_posesn_stock_co` <> '0') and (`b`.`trmend_posesn_stock_qota_rt` <> '0'))), `names` as (select distinct trim(`hh`.`nm`) AS `nm` from `hh`), `map_exp` as (select `jt`.`name` AS `name`,`m`.`corp_code` AS `corp_code`,`m`.`corp_name` AS `corp_name` from ((`MART_CORP_NAME_MAP` `m` join json_table(`m`.`corp_same_name`, '$[*]' columns (`name` varchar(100) character set utf8mb4 collate utf8mb4_unicode_ci path '$')) `jt` on((0 <> 1))) join `names` `n` on((`n`.`nm` = `jt`.`name`)))), `map_best` as (select `map_exp`.`name` AS `name`,`map_exp`.`corp_code` AS `corp_code`,`map_exp`.`corp_name` AS `corp_name`,row_number() OVER (PARTITION BY `map_exp`.`name` ORDER BY `map_exp`.`corp_code` desc )  AS `rn` from `map_exp`) select `hh`.`corp_name` AS `corp_name`,`hh`.`rcept_no` AS `rcept_no`,`hh`.`corp_code` AS `corp_code`,`hh`.`nm` AS `nm`,`hh`.`stkqy` AS `stkqy`,`hh`.`stkrt` AS `stkrt`,`hh`.`corp_cls` AS `corp_cls`,`hh`.`holder_type` AS `holder_type`,`hh`.`stml_dt` AS `stml_dt`,`hh`.`created_at` AS `created_at`,`mb`.`corp_name` AS `_corp_name`,`mb`.`corp_code` AS `_corp_code`,`cls`.`corp_cls` AS `_corp_cls` from ((`hh` left join `map_best` `mb` on(((`mb`.`name` = trim(`hh`.`nm`)) and (`mb`.`rn` = 1)))) left join `STG_OP_DA_AP_1_2` `cls` on((`cls`.`corp_code` = `mb`.`corp_code`)));

-- 뷰 etoday_corp.VW_CORP_INFO 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_INFO`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_INFO`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_INFO` AS select `c`.`unityGrupCode` AS `unityGrupCode`,`c`.`unityGrupNm` AS `unityGrupNm`,`c`.`smerNm` AS `smerNm`,`c`.`repreCmpny` AS `repreCmpny`,`c`.`sumCmpnyCo` AS `sumCmpnyCo`,`c`.`entrprsNm` AS `entrprsNm`,`c`.`jurirno` AS `jurirno`,`c`.`rprsntvNm` AS `rprsntvNm`,`c`.`fondDe` AS `fondDe`,`c`.`grinil` AS `grinil`,`c`.`bizrno` AS `bizrno`,`d`.`corp_code` AS `corp_code`,`d`.`corp_name` AS `corp_name`,`d`.`corp_name_eng` AS `corp_name_eng`,`d`.`stock_name` AS `stock_name`,`d`.`stock_code` AS `stock_code`,`d`.`ceo_nm` AS `ceo_nm`,`d`.`corp_cls` AS `corp_cls`,`d`.`jurir_no` AS `jurir_no`,`d`.`bizr_no` AS `bizr_no`,`d`.`adres` AS `adres`,`d`.`hm_url` AS `hm_url`,`d`.`ir_url` AS `ir_url`,`d`.`phn_no` AS `phn_no`,`d`.`fax_no` AS `fax_no`,`d`.`induty_code` AS `induty_code`,`d`.`est_dt` AS `est_dt`,`d`.`acc_mt` AS `acc_mt`,`d`.`created_at` AS `created_at` from (`STG_OP_DA_AP_1_2` `d` join (select `a`.`unityGrupCode` AS `unityGrupCode`,`a`.`unityGrupNm` AS `unityGrupNm`,`a`.`smerNm` AS `smerNm`,`a`.`repreCmpny` AS `repreCmpny`,`a`.`sumCmpnyCo` AS `sumCmpnyCo`,`b`.`entrprsNm` AS `entrprsNm`,`b`.`jurirno` AS `jurirno`,`b`.`rprsntvNm` AS `rprsntvNm`,`b`.`fondDe` AS `fondDe`,`b`.`grinil` AS `grinil`,`b`.`bizrno` AS `bizrno` from (`STG_EG_AP_6_2` `a` join `STG_EG_AP_5_4` `b` on((`a`.`unityGrupNm` = `b`.`unityGrupNm`)))) `c` on((`d`.`jurir_no` = `c`.`jurirno`)));

-- 뷰 etoday_corp.VW_CORP_INFO_BASE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_INFO_BASE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_INFO_BASE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_INFO_BASE` AS select distinct `g`.`corp_code` AS `corp_code`,`g`.`corp_name` AS `corp_name`,`g`.`corp_name_eng` AS `corp_name_eng`,`g`.`stock_name` AS `stock_name`,`g`.`stock_code` AS `stock_code`,`g`.`ceo_nm` AS `ceo_nm`,`g`.`corp_cls` AS `corp_cls`,`g`.`jurir_no` AS `jurir_no`,`g`.`bizr_no` AS `bizr_no`,`g`.`adres` AS `adres`,`g`.`hm_url` AS `hm_url`,`g`.`ir_url` AS `ir_url`,`g`.`phn_no` AS `phn_no`,`g`.`fax_no` AS `fax_no`,`g`.`induty_code` AS `induty_code`,`g`.`est_dt` AS `est_dt`,`g`.`acc_mt` AS `acc_mt`,`g`.`created_at` AS `created_at`,`e`.`unityGrupCode` AS `unityGrupCode`,`e`.`unityGrupNm` AS `unityGrupNm`,`e`.`smerNm` AS `smerNm`,`e`.`repreCmpny` AS `repreCmpny`,`e`.`sumCmpnyCo` AS `sumCmpnyCo`,`e`.`entrprsNm` AS `entrprsNm`,`e`.`rprsntvNm` AS `rprsntvNm`,`e`.`fondDe` AS `fondDe`,`e`.`grinil` AS `grinil`,`ee`.`INDEX_TYPE` AS `INDEX_TYPE`,`ee`.`INDEX_TYPE_NM` AS `INDEX_TYPE_NM` from ((`STG_OP_DA_AP_1_2` `g` left join (select `a`.`unityGrupCode` AS `unityGrupCode`,`a`.`unityGrupNm` AS `unityGrupNm`,`a`.`smerNm` AS `smerNm`,`a`.`repreCmpny` AS `repreCmpny`,`a`.`sumCmpnyCo` AS `sumCmpnyCo`,`b`.`entrprsNm` AS `entrprsNm`,`b`.`jurirno` AS `jurirno`,`b`.`rprsntvNm` AS `rprsntvNm`,`b`.`fondDe` AS `fondDe`,`b`.`grinil` AS `grinil`,`b`.`bizrno` AS `bizrno` from (`STG_EG_AP_6_2` `a` join `STG_EG_AP_5_4` `b` on((`a`.`unityGrupNm` = `b`.`unityGrupNm`)))) `e` on((`g`.`jurir_no` = `e`.`jurirno`))) left join (select `ea`.`STK_CD` AS `STK_CD`,`ea`.`NAME_KOREAN` AS `NAME_KOREAN`,`ea`.`INDEX_TYPE` AS `INDEX_TYPE`,`eb`.`INDEX_TYPE_NM` AS `INDEX_TYPE_NM` from (`ET_KRX_STK_LIST` `ea` left join `ET_KRX_BIZCODE` `eb` on((`ea`.`INDEX_TYPE` = `eb`.`INDEX_TYPE_ID`)))) `ee` on((`g`.`stock_code` = `ee`.`STK_CD`))) where ((`g`.`stock_code` <> '') or (`e`.`unityGrupCode` is not null));

-- 뷰 etoday_corp.VW_CORP_OWNERSHIP 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_OWNERSHIP`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_OWNERSHIP`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_OWNERSHIP` AS with `b_dedup` as (select `x`.`corp_name` AS `corp_name`,`x`.`corp_code` AS `corp_code`,`x`.`corp_cls` AS `corp_cls` from (select `b`.`corp_cls` AS `corp_cls`,`b`.`corp_name` AS `corp_name`,`b`.`corp_code` AS `corp_code`,`b`.`stock_code` AS `stock_code`,`b`.`report_nm` AS `report_nm`,`b`.`rcept_no` AS `rcept_no`,`b`.`pblntf_ty` AS `pblntf_ty`,`b`.`flr_nm` AS `flr_nm`,`b`.`rcept_dt` AS `rcept_dt`,`b`.`rm` AS `rm`,`b`.`created_at` AS `created_at`,row_number() OVER (PARTITION BY `b`.`corp_name` ORDER BY `b`.`created_at` desc,`b`.`rcept_no` desc )  AS `rn` from `STG_OP_DA_AP_1_1` `b`) `x` where (`x`.`rn` = 1)) select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_cls` AS `corp_cls`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`inv_prm` AS `inv_prm`,`a`.`frst_acqs_de` AS `frst_acqs_de`,`a`.`invstmnt_purps` AS `invstmnt_purps`,`a`.`frst_acqs_amount` AS `frst_acqs_amount`,`a`.`bsis_blce_qy` AS `bsis_blce_qy`,`a`.`bsis_blce_qota_rt` AS `bsis_blce_qota_rt`,`a`.`bsis_blce_acntbk_amount` AS `bsis_blce_acntbk_amount`,`a`.`incrs_dcrs_acqs_dsps_qy` AS `incrs_dcrs_acqs_dsps_qy`,`a`.`incrs_dcrs_acqs_dsps_amount` AS `incrs_dcrs_acqs_dsps_amount`,`a`.`incrs_dcrs_evl_lstmn` AS `incrs_dcrs_evl_lstmn`,`a`.`trmend_blce_qy` AS `trmend_blce_qy`,`a`.`trmend_blce_qota_rt` AS `trmend_blce_qota_rt`,`a`.`trmend_blce_acntbk_amount` AS `trmend_blce_acntbk_amount`,`a`.`recent_bsns_year_fnnr_sttus_tot_assets` AS `recent_bsns_year_fnnr_sttus_tot_assets`,`a`.`recent_bsns_year_fnnr_sttus_thstrm_ntpf` AS `recent_bsns_year_fnnr_sttus_thstrm_ntpf`,`a`.`stlm_dt` AS `stlm_dt`,`a`.`created_at` AS `created_at`,`b_dedup`.`corp_code` AS `_corp_code`,`b_dedup`.`corp_name` AS `_corp_name`,`b_dedup`.`corp_cls` AS `_corp_cls` from (`STG_OP_DA_AP_2_12` `a` left join `b_dedup` on((`a`.`inv_prm` = `b_dedup`.`corp_name`))) where ((`a`.`inv_prm` <> '합계') and (`a`.`trmend_blce_acntbk_amount` <> '-'));

-- 뷰 etoday_corp.VW_CORP_REVENUE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_REVENUE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_REVENUE` AS select `b`.`rcept_no` AS `rcept_no`,`a`.`jurir_no` AS `jurir_no`,`b`.`reprt_code` AS `reprt_code`,`a`.`corp_name` AS `corp_name`,`a`.`corp_code` AS `corp_code`,`a`.`stock_code` AS `stock_code`,`b`.`account_nm` AS `account_nm`,`b`.`thstrm_amount` AS `thstrm_amount`,`b`.`thstrm_dt` AS `thstrm_dt`,`b`.`bsns_year` AS `bsns_year`,`b`.`fs_div` AS `fs_div` from (`STG_OP_DA_AP_1_2` `a` join `STG_OP_DA_AP_3_1` `b` on((`a`.`stock_code` = `b`.`stock_code`))) where ((`b`.`account_nm` like '%당기순이익%') and (`b`.`thstrm_dt` like '%12.31%') and (`b`.`bsns_year` >= 2024));

-- 뷰 etoday_corp.VW_CORP_REVENUE_PROFIT 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE_PROFIT`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_REVENUE_PROFIT`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_REVENUE_PROFIT` AS select `b`.`rcept_no` AS `rcept_no`,`a`.`jurir_no` AS `jurir_no`,`a`.`corp_name` AS `corp_name`,`b`.`reprt_code` AS `reprt_code`,`a`.`corp_code` AS `corp_code`,`a`.`stock_code` AS `stock_code`,`b`.`account_nm` AS `account_nm`,`b`.`thstrm_amount` AS `thstrm_amount`,`b`.`thstrm_dt` AS `thstrm_dt`,`b`.`bsns_year` AS `bsns_year`,`b`.`fs_div` AS `fs_div` from (`STG_OP_DA_AP_1_2` `a` join `STG_OP_DA_AP_3_1` `b` on((`a`.`stock_code` = `b`.`stock_code`))) where (((`b`.`account_nm` like '매출액%') or (`b`.`account_nm` like '영업이익%')) and (`b`.`thstrm_dt` like '%12.31')) order by `b`.`stock_code`,`b`.`bsns_year` desc;

-- 뷰 etoday_corp.VW_CORP_REVENUE_TAKE 구조 내보내기
DROP VIEW IF EXISTS `VW_CORP_REVENUE_TAKE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_CORP_REVENUE_TAKE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_CORP_REVENUE_TAKE` AS select `b`.`rcept_no` AS `rcept_no`,`a`.`jurir_no` AS `jurir_no`,`b`.`reprt_code` AS `reprt_code`,`a`.`corp_name` AS `corp_name`,`a`.`corp_code` AS `corp_code`,`a`.`stock_code` AS `stock_code`,`b`.`account_nm` AS `account_nm`,`b`.`thstrm_amount` AS `thstrm_amount`,`b`.`thstrm_dt` AS `thstrm_dt`,`b`.`bsns_year` AS `bsns_year`,`b`.`fs_div` AS `fs_div` from (`STG_OP_DA_AP_1_2` `a` join `STG_OP_DA_AP_3_1` `b` on((`a`.`stock_code` = `b`.`stock_code`))) where ((`b`.`account_nm` like '매출액%') and (`b`.`thstrm_dt` like '%12.31') and (`b`.`bsns_year` >= 2024));

-- 뷰 etoday_corp.VW_DISCLOSURE_SEARCH 구조 내보내기
DROP VIEW IF EXISTS `VW_DISCLOSURE_SEARCH`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_DISCLOSURE_SEARCH`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_DISCLOSURE_SEARCH` AS select `a`.`corp_code` AS `corp_code`,`a`.`corp_cls` AS `corp_cls`,`a`.`report_nm` AS `report_nm`,`a`.`rcept_no` AS `rcept_no`,`a`.`flr_nm` AS `flr_nm`,`a`.`pblntf_ty` AS `pblntf_ty`,`a`.`rcept_dt` AS `rcept_dt`,`a`.`rm` AS `rm` from `STG_OP_DA_AP_1_1` `a`;

-- 뷰 etoday_corp.VW_DISCLOSURE_SUMMARY 구조 내보내기
DROP VIEW IF EXISTS `VW_DISCLOSURE_SUMMARY`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_DISCLOSURE_SUMMARY`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_DISCLOSURE_SUMMARY` AS select `STG_OP_DA_AP_1_3`.`rcept_no` AS `rcept_no`,`STG_OP_DA_AP_1_3`.`file_name` AS `file_name`,NULL AS `content` from `STG_OP_DA_AP_1_3`;

-- 뷰 etoday_corp.VW_FILE_CONTENT_FILTER 구조 내보내기
DROP VIEW IF EXISTS `VW_FILE_CONTENT_FILTER`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_FILE_CONTENT_FILTER`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_FILE_CONTENT_FILTER` AS select `s`.`rcept_no` AS `rcept_no`,`s`.`file_content` AS `file_content` from `STG_OP_DA_AP_1_3` `s` where `s`.`rcept_no` in (select `a`.`rcept_no` from `MART_DISCLOSURE_SEARCH` `a` where (`a`.`pblntf_ty` not in ('A','B')));

-- 뷰 etoday_corp.VW_MAJOR_HOLDER 구조 내보내기
DROP VIEW IF EXISTS `VW_MAJOR_HOLDER`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_MAJOR_HOLDER`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_MAJOR_HOLDER` AS select `ranked`.`rcept_no` AS `rcept_no`,`ranked`.`corp_code` AS `corp_code`,`ranked`.`nm` AS `nm`,`ranked`.`relate` AS `relate`,`ranked`.`trmend_posesn_stock_co` AS `trmend_posesn_stock_co`,`ranked`.`trmend_posesn_stock_qota_rt` AS `trmend_posesn_stock_qota_rt`,`ranked`.`stock_knd` AS `stock_knd`,`ranked`.`stlm_dt` AS `stlm_dt`,`ranked`.`created_at` AS `created_at` from (select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_cls` AS `corp_cls`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`nm` AS `nm`,`a`.`relate` AS `relate`,`a`.`stock_knd` AS `stock_knd`,`a`.`bsis_posesn_stock_co` AS `bsis_posesn_stock_co`,`a`.`bsis_posesn_stock_qota_rt` AS `bsis_posesn_stock_qota_rt`,`a`.`trmend_posesn_stock_co` AS `trmend_posesn_stock_co`,`a`.`trmend_posesn_stock_qota_rt` AS `trmend_posesn_stock_qota_rt`,`a`.`rm` AS `rm`,`a`.`stlm_dt` AS `stlm_dt`,`a`.`stock_knd_map` AS `stock_knd_map`,`a`.`created_at` AS `created_at`,`m`.`stock_cd` AS `stock_cd`,`m`.`stock_type` AS `stock_type`,row_number() OVER (PARTITION BY `a`.`corp_code`,`a`.`nm` ORDER BY cast(`a`.`rcept_no` as unsigned) desc )  AS `rn` from (`STG_OP_DA_AP_2_4` `a` join `MART_STOCK_KND_MAPPING` `m` on((`a`.`stock_knd` = `m`.`stock_knd`))) where ((`a`.`trmend_posesn_stock_co` <> '0') and (`a`.`nm` <> '계') and (`a`.`relate` <> ''))) `ranked` where (`ranked`.`rn` = 1) order by `ranked`.`corp_code`,cast(`ranked`.`trmend_posesn_stock_qota_rt` as decimal(5,2)) desc,`ranked`.`stlm_dt` desc;

-- 뷰 etoday_corp.VW_MINORITY_HOLDERS_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_MINORITY_HOLDERS_RATE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_MINORITY_HOLDERS_RATE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_MINORITY_HOLDERS_RATE` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,left(`a`.`stlm_dt`,4) AS `bsns_year`,`a`.`stlm_dt` AS `stlm_dt`,replace(`a`.`hold_stock_rate`,'%','') AS `hold_stock_rate` from `STG_OP_DA_AP_2_6` `a` order by replace(`a`.`hold_stock_rate`,'%','') desc;

-- 뷰 etoday_corp.VW_NPS_INVESTED_COMPANY 구조 내보내기
DROP VIEW IF EXISTS `VW_NPS_INVESTED_COMPANY`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_NPS_INVESTED_COMPANY`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_NPS_INVESTED_COMPANY` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`stkqy` AS `stkqy`,`a`.`stkrt` AS `stkrt`,`a`.`repror` AS `repror`,`b`.`stock_code` AS `stock_code` from (`STG_OP_DA_AP_4_1` `a` join `STG_OP_DA_AP_1_4` `b` on((`a`.`corp_code` = `b`.`corp_code`))) where (`a`.`repror` like '국민연금%') order by cast(replace(`a`.`stkrt`,',','') as decimal(30,10)) desc;

-- 뷰 etoday_corp.VW_OWN_STOCK_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_OWN_STOCK_RATE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_OWN_STOCK_RATE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_OWN_STOCK_RATE` AS select `a`.`corp_code` AS `corp_code`,`a`.`rcept_no` AS `rcept_no`,`a`.`corp_name` AS `corp_name`,`a`.`nstk_ostk_cnt` AS `nstk_ostk_cnt`,`a`.`bfic_tisstk_ostk` AS `bfic_tisstk_ostk`,round(((cast(replace(`a`.`nstk_ostk_cnt`,',','') as decimal(30,10)) / cast(replace(`a`.`bfic_tisstk_ostk`,',','') as decimal(30,10))) * 100),2) AS `own_stock_rate` from `STG_OP_DA_AP_5_7` `a`;

-- 뷰 etoday_corp.VW_PERMANANT_EMPLOYEE 구조 내보내기
DROP VIEW IF EXISTS `VW_PERMANANT_EMPLOYEE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_PERMANANT_EMPLOYEE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_PERMANANT_EMPLOYEE` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`fo_bbm` AS `fo_bbm`,`a`.`sexdstn` AS `sexdstn`,`a`.`rgllbr_co` AS `rgllbr_co`,`a`.`rgllbr_abacpt_labrr_co` AS `rgllbr_abacpt_labrr_co`,`a`.`stlm_dt` AS `stlm_dt`,`a`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_8` `a` where ((`a`.`fo_bbm` <> '-') and (`a`.`fo_bbm` like '%성별합계%')) order by `a`.`stlm_dt` desc,`a`.`corp_code` desc;

-- 뷰 etoday_corp.VW_PRV_MAJOR_HOLDER_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_PRV_MAJOR_HOLDER_RATE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_PRV_MAJOR_HOLDER_RATE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_PRV_MAJOR_HOLDER_RATE` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`nm` AS `nm`,`a`.`stock_knd` AS `stock_knd`,`a`.`trmend_posesn_stock_co` AS `trmend_posesn_stock_co`,`a`.`trmend_posesn_stock_qota_rt` AS `trmend_posesn_stock_qota_rt`,`a`.`stlm_dt` AS `stlm_dt`,`a`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_4` `a` where ((`a`.`trmend_posesn_stock_qota_rt` <> '-') and (`a`.`trmend_posesn_stock_qota_rt` <> '0.00') and (`a`.`nm` = '계') and (left(`a`.`stlm_dt`,7) = '2024-12')) group by `a`.`corp_code` order by cast(regexp_replace(`a`.`trmend_posesn_stock_qota_rt`,'[^0-9]','') as unsigned) desc,`a`.`stlm_dt` desc;

-- 뷰 etoday_corp.VW_REVENUE_PROFIT 구조 내보내기
DROP VIEW IF EXISTS `VW_REVENUE_PROFIT`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_REVENUE_PROFIT`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_REVENUE_PROFIT` AS select `b`.`rcept_no` AS `rcept_no`,`a`.`jurir_no` AS `jurir_no`,`a`.`corp_name` AS `corp_name`,`a`.`corp_code` AS `corp_code`,`a`.`stock_code` AS `stock_code`,`b`.`account_nm` AS `account_nm`,`b`.`thstrm_amount` AS `thstrm_amount`,`b`.`thstrm_dt` AS `thstrm_dt`,`b`.`bsns_year` AS `bsns_year`,`b`.`fs_div` AS `fs_div` from (`STG_OP_DA_AP_1_2` `a` join `STG_OP_DA_AP_3_1` `b` on((`a`.`stock_code` = `b`.`stock_code`))) where (((`b`.`account_nm` like '매출액%') or (`b`.`account_nm` like '영업이익%')) and (`b`.`fs_div` = 'CFS')) order by `a`.`corp_code`;

-- 뷰 etoday_corp.VW_SELF_STOCK_RANK 구조 내보내기
DROP VIEW IF EXISTS `VW_SELF_STOCK_RANK`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_SELF_STOCK_RANK`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_SELF_STOCK_RANK` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_cls` AS `corp_cls`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`acqs_mth1` AS `acqs_mth1`,`a`.`acqs_mth2` AS `acqs_mth2`,`a`.`acqs_mth3` AS `acqs_mth3`,`a`.`change_qy_acqs` AS `change_qy_acqs`,`a`.`stlm_dt` AS `stlm_dt`,`a`.`created_at` AS `created_at` from `STG_OP_DA_AP_2_3` `a` where ((`a`.`acqs_mth1` = '총계') and (`a`.`stock_knd` like '%보통%') and (left(`a`.`stlm_dt`,4) = 2024) and (substr(`a`.`stlm_dt`,6,2) = 12) and (`a`.`corp_cls` <> 'E') and (`a`.`change_qy_acqs` <> '-')) group by `a`.`corp_code` order by cast(replace(`a`.`change_qy_acqs`,',','') as unsigned) desc;

-- 뷰 etoday_corp.VW_SELF_STOCK_RATE 구조 내보내기
DROP VIEW IF EXISTS `VW_SELF_STOCK_RATE`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_SELF_STOCK_RATE`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_SELF_STOCK_RATE` AS select `a`.`rcept_no` AS `rcept_no`,`a`.`corp_code` AS `corp_code`,`a`.`corp_name` AS `corp_name`,`a`.`tesstk_co` AS `tesstk_co`,`a`.`istc_totqy` AS `istc_totqy`,left(`a`.`stlm_dt`,4) AS `bsns_year`,`a`.`stlm_dt` AS `stlm_dt`,round(((cast(replace(`a`.`tesstk_co`,',','') as decimal(20,2)) / cast(replace(`a`.`istc_totqy`,',','') as decimal(20,2))) * 100),2) AS `self_stock_rate` from `STG_OP_DA_AP_2_13` `a` where ((`a`.`tesstk_co` <> '-') and (`a`.`istc_totqy` <> '-') and (`a`.`tesstk_co` > 0) and (`a`.`istc_totqy` > 0)) order by round(((cast(replace(`a`.`tesstk_co`,',','') as decimal(20,2)) / cast(replace(`a`.`istc_totqy`,',','') as decimal(20,2))) * 100),2) desc;

-- 뷰 etoday_corp.VW_TOP_LIST_SUBSIDIARIES 구조 내보내기
DROP VIEW IF EXISTS `VW_TOP_LIST_SUBSIDIARIES`;
-- 임시 테이블을 제거하고 최종 VIEW 구조를 생성
DROP TABLE IF EXISTS `VW_TOP_LIST_SUBSIDIARIES`;
CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `VW_TOP_LIST_SUBSIDIARIES` AS select `a`.`jurirno` AS `jurirno`,`a`.`unityGrupNm` AS `unityGrupNm`,`a`.`cdpnyLstCo` AS `cdpnyLstCo`,`a`.`fnncSeCodeNm` AS `fnncSeCodeNm` from `STG_EG_AP_4_1` `a` order by `a`.`cdpnyLstCo` desc;

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
