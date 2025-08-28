# 📱 가족 시간표 PWA

우리 가족의 주간 시간표를 실시간으로 확인할 수 있는 **Progressive Web App** 입니다.

## 🚀 **빠른 시작**

### 📱 **스마트폰에 PWA 설치**
1. Safari/Chrome에서 PWA URL 접속
2. "홈 화면에 추가" 클릭
3. 앱처럼 사용 가능!

### 💻 **PC에서 관리**
- **일정 편집**: 상위 폴더의 `editor.html` 사용
- **데이터 관리**: 상위 폴더의 `manager.html` 사용

## 📁 **파일 구조**
```
pwa-app/           # 📱 PWA 배포 폴더
├── index.html     # PWA 메인 앱
├── manifest.json  # PWA 설정
├── sw.js         # 서비스 워커
├── deploy.sh     # GitHub Pages 배포 스크립트
└── README.md     # 이 파일

../                # 💻 관리 도구들
├── editor.html   # 일정 편집기
├── manager.html  # 데이터 관리자
└── *.py         # Python 업로드 스크립트들
```

## 🌐 **배포하기**

### **GitHub Pages 배포**
```bash
cd pwa-app
chmod +x deploy.sh
./deploy.sh
```

## 🔧 **주요 기능**
- ✅ **실시간 동기화**: Google Sheets와 연동
- ✅ **4등분 레이아웃**: 가족 구성원별 고정 위치
- ✅ **PWA 설치**: 홈 화면에 앱으로 추가 가능
- ✅ **오프라인 지원**: 서비스 워커로 기본 기능 유지
- ✅ **반응형 디자인**: 모바일/데스크톱 최적화

## 🎨 **테마 색상**
현재 테마: `#6366f1` (보라색/인디고)
- 변경 위치: `manifest.json` + `index.html`

## 📞 **지원**
문제가 있으면 상위 폴더의 문서들을 참고하세요.

---
*마지막 업데이트: 2025년 8월 28일*