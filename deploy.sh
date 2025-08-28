#!/bin/bash

# 🚀 가족 시간표 PWA GitHub Pages 배포 스크립트

echo "📱 가족 시간표 PWA 배포 시작..."
echo "================================"

# 현재 디렉토리 확인
if [ ! -f "manifest.json" ]; then
    echo "❌ PWA 폴더에서 실행해주세요!"
    echo "올바른 경로: .../pwa/"
    exit 1
fi

# Git 사용자 정보 확인
echo "🔍 Git 설정 확인 중..."
if ! git config user.name >/dev/null || ! git config user.email >/dev/null; then
    echo "⚠️ Git 사용자 정보를 설정해주세요:"
    echo "git config --global user.name '당신의 이름'"
    echo "git config --global user.email '당신의 이메일'"
    exit 1
fi

echo "👤 Git 사용자: $(git config user.name) <$(git config user.email)>"

# GitHub 사용자명 입력
echo ""
read -p "📝 GitHub 사용자명을 입력하세요: " github_username

if [ -z "$github_username" ]; then
    echo "❌ GitHub 사용자명이 필요합니다!"
    exit 1
fi

# 리포지토리 이름 설정
repo_name="family-schedule-pwa"
echo "📦 리포지토리 이름: $repo_name"

# Git 초기화 및 커밋
echo ""
echo "📂 Git 리포지토리 초기화..."

if [ ! -d ".git" ]; then
    git init
    echo "✅ Git 초기화 완료"
else
    echo "✅ 기존 Git 리포지토리 사용"
fi

# 파일 추가
echo "📁 파일 추가 중..."
git add .

# 커밋
echo "💾 커밋 생성 중..."
commit_message="PWA 배포 - $(date '+%Y-%m-%d %H:%M:%S')"
git commit -m "$commit_message"

# 원격 저장소 설정
echo "🌐 GitHub 원격 저장소 설정..."
remote_url="https://github.com/$github_username/$repo_name.git"

if git remote get-url origin >/dev/null 2>&1; then
    echo "🔄 기존 원격 저장소 업데이트: $remote_url"
    git remote set-url origin "$remote_url"
else
    echo "➕ 새 원격 저장소 추가: $remote_url"
    git remote add origin "$remote_url"
fi

# 메인 브랜치 설정
echo "🌟 메인 브랜치 설정..."
git branch -M main

# GitHub 리포지토리 생성 안내
echo ""
echo "🔥 GitHub에서 리포지토리를 생성해야 합니다!"
echo "================================"
echo "1. https://github.com/new 접속"
echo "2. Repository name: $repo_name"
echo "3. Public 선택"
echo "4. 'Create repository' 클릭"
echo ""
read -p "✅ GitHub 리포지토리 생성 완료했으면 Enter를 누르세요..."

# GitHub에 푸시
echo ""
echo "🚀 GitHub에 푸시 중..."
if git push -u origin main; then
    echo "✅ GitHub 푸시 성공!"
else
    echo "❌ GitHub 푸시 실패!"
    echo "💡 GitHub에서 리포지토리가 제대로 생성되었는지 확인하세요."
    exit 1
fi

# GitHub Pages 설정 안내
echo ""
echo "🌐 GitHub Pages 설정 안내"
echo "=========================="
echo "1. https://github.com/$github_username/$repo_name/settings/pages 접속"
echo "2. Source: 'Deploy from a branch' 선택"
echo "3. Branch: 'main' 선택"
echo "4. Folder: '/ (root)' 선택"
echo "5. 'Save' 클릭"
echo ""
echo "⏱️ 배포까지 5-10분 소요됩니다."
echo ""

# 최종 URL 표시
pwa_url="https://$github_username.github.io/$repo_name/"
editor_url="https://$github_username.github.io/$repo_name/editor.html"

echo "🎉 배포 완료!"
echo "============="
echo "📱 PWA URL (아이폰용): $pwa_url"
echo "🖥️ 편집기 URL (PC용): $editor_url"
echo ""
echo "📋 다음 단계:"
echo "1. Google Sheets API 설정 (SETUP_GUIDE.md 참고)"
echo "2. 아이폰 Safari에서 PWA URL 접속 → 홈화면 추가"
echo "3. PC에서 편집기 URL로 시간표 편집"
echo ""

# 설정 파일 생성
echo "⚙️ 배포 설정 저장 중..."
cat > deployment-config.json << EOF
{
  "github_username": "$github_username",
  "repository_name": "$repo_name",
  "pwa_url": "$pwa_url",
  "editor_url": "$editor_url",
  "deployed_at": "$(date -u +%Y-%m-%dT%H:%M:%SZ)"
}
EOF

echo "✅ 설정 파일 저장: deployment-config.json"

# 브라우저에서 열기
echo ""
read -p "🌐 브라우저에서 GitHub Pages 설정 페이지를 열까요? (y/n): " open_browser

if [ "$open_browser" = "y" ] || [ "$open_browser" = "Y" ]; then
    open "https://github.com/$github_username/$repo_name/settings/pages"
    echo "🚀 GitHub Pages 설정 페이지가 열렸습니다!"
fi

echo ""
echo "🎯 배포 스크립트 완료!"
echo "문제가 있으면 SETUP_GUIDE.md를 참고하세요."