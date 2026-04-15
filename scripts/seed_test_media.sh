#!/bin/bash
# Test Media Setup Script
set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROJECT_ROOT="/home/chibuzor_dev/WeWatch"
TEST_MEDIA_DIR="$PROJECT_ROOT/backend/uploads/test_media"

echo -e "${GREEN}Creating test media directories...${NC}"
mkdir -p "$TEST_MEDIA_DIR/videos/pg"
mkdir -p "$TEST_MEDIA_DIR/videos/18plus"
mkdir -p "$TEST_MEDIA_DIR/videos/general"

if ! command -v ffmpeg &> /dev/null; then
  echo -e "${YELLOW}⚠️  ffmpeg not installed${NC}"
  echo -e "${YELLOW}Install: sudo apt install ffmpeg${NC}"
else
  echo -e "${GREEN}Generating test videos...${NC}"
  
  ffmpeg -f lavfi -i color=c=blue:s=1920x1080:d=30 \
    -f lavfi -i sine=frequency=1000:duration=30 \
    -vf "drawtext=text='PG Video':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" \
    "$TEST_MEDIA_DIR/videos/pg/test_pg_video.mp4" -y -loglevel error 2>/dev/null || true
  
  ffmpeg -f lavfi -i color=c=red:s=1920x1080:d=30 \
    -f lavfi -i sine=frequency=1500:duration=30 \
    -vf "drawtext=text='18+ Video':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" \
    "$TEST_MEDIA_DIR/videos/18plus/test_18plus_video.mp4" -y -loglevel error 2>/dev/null || true
  
  ffmpeg -f lavfi -i color=c=green:s=1920x1080:d=30 \
    -f lavfi -i sine=frequency=800:duration=30 \
    -vf "drawtext=text='G-Rated':fontsize=60:fontcolor=white:x=(w-text_w)/2:y=(h-text_h)/2" \
    "$TEST_MEDIA_DIR/videos/general/test_g_video.mp4" -y -loglevel error 2>/dev/null || true
  
  echo -e "${GREEN}✅ Test videos created${NC}"
fi

echo -e "${GREEN}✅ Test media setup complete!${NC}"
echo -e "Location: $TEST_MEDIA_DIR"
