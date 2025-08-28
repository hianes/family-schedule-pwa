// 가족 시간표 PWA Service Worker
const CACHE_NAME = 'family-schedule-v3.0';
const CACHE_URLS = [
  './index.html',           // 📱 PWA 메인 앱
  './manifest.json',        // 🔧 PWA 설정  
  './editor.html',          // 💻 관리용 에디터
  './manager.html'          // 🛠️ 관리용 매니저
];

// Service Worker 설치
self.addEventListener('install', event => {
  console.log('📱 PWA Service Worker 설치 중...');
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then(cache => {
        console.log('✅ 캐시 생성 완료');
        return cache.addAll(CACHE_URLS);
      })
      .catch(error => {
        console.log('❌ 캐시 생성 실패:', error);
      })
  );
  // 즉시 활성화
  self.skipWaiting();
});

// Service Worker 활성화
self.addEventListener('activate', event => {
  console.log('🚀 PWA Service Worker 활성화');
  event.waitUntil(
    caches.keys().then(cacheNames => {
      return Promise.all(
        cacheNames.map(cacheName => {
          // 이전 버전 캐시 삭제
          if (cacheName !== CACHE_NAME) {
            console.log('🗑️ 이전 캐시 삭제:', cacheName);
            return caches.delete(cacheName);
          }
        })
      );
    })
  );
  // 즉시 클라이언트 제어
  self.clients.claim();
});

// 네트워크 요청 처리 (오프라인 지원)
self.addEventListener('fetch', event => {
  event.respondWith(
    caches.match(event.request)
      .then(response => {
        // 캐시에 있으면 캐시 반환
        if (response) {
          console.log('📦 캐시에서 로드:', event.request.url);
          return response;
        }
        
        // 캐시에 없으면 네트워크에서 가져와서 캐시에 저장
        return fetch(event.request)
          .then(response => {
            // 응답이 유효한지 확인
            if (!response || response.status !== 200 || response.type !== 'basic') {
              return response;
            }
            
            // 응답 복제해서 캐시에 저장
            const responseToCache = response.clone();
            caches.open(CACHE_NAME)
              .then(cache => {
                cache.put(event.request, responseToCache);
              });
            
            return response;
          })
          .catch(() => {
            // 네트워크 실패시 기본 오프라인 페이지 반환
            console.log('🔌 오프라인 모드 - 캐시된 데이터 사용');
            return caches.match('./index.html');
          });
      })
  );
});

// 백그라운드 동기화 (미래 구현용)
self.addEventListener('sync', event => {
  if (event.tag === 'background-sync-schedule') {
    console.log('🔄 백그라운드 동기화 시작');
    event.waitUntil(
      syncScheduleData()
    );
  }
});

// 푸시 알림 (미래 구현용)
self.addEventListener('push', event => {
  console.log('🔔 푸시 알림 수신:', event.data?.text());
  
  const options = {
    body: event.data?.text() || '가족 시간표가 업데이트되었습니다',
    icon: './manifest.json',
    badge: './manifest.json',
    vibrate: [100, 50, 100],
    data: {
      dateOfArrival: Date.now(),
      primaryKey: 1
    },
    actions: [
      {
        action: 'explore',
        title: '시간표 확인',
        icon: './manifest.json'
      },
      {
        action: 'close',
        title: '닫기'
      }
    ]
  };
  
  event.waitUntil(
    self.registration.showNotification('가족 시간표 알림', options)
  );
});

// 동기화 함수 (Google Sheets API 호출)
async function syncScheduleData() {
  try {
    console.log('📊 Google Sheets 데이터 동기화 시작...');
    // 실제 구현은 다음 단계에서
    return true;
  } catch (error) {
    console.error('❌ 동기화 실패:', error);
    throw error;
  }
}