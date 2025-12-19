import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // private 생성자 (인스턴스화 방지)

  // ============ 주요 색상 ============
  /// 주요 색상 (Primary) - 앱 바, 주요 버튼, 하이라이트
  static const Color primary = Color(0xFFBB86FC);

  /// 보조 색상 (Secondary) - FAB, 보조 강조 요소
  static const Color secondary = Color(0xFF03DAC6);

  // ============ 배경 색상 ============
  /// 전반적인 배경 색상
  static const Color background = Color(0xFF121212);

  /// 카드, 시트, 다이얼로그 등 서페이스 배경
  static const Color surface = Color(0xFF1E1E1E);

  // ============ 텍스트 색상 ============
  /// 밝은 텍스트 - 일반 텍스트, 제목
  static const Color lightText = Color(0xFFFFFFFF);

  /// 밝은 회색 텍스트 - 부제목, 본문
  static const Color lightTextSecondary = Color(0xFFE0E0E0);

  /// 흐린 텍스트 - 플레이스홀더, 비활성 상태
  static const Color hintText = Color(0xFF888888);

  // ============ 오류 색상 ============
  /// 오류 메시지, 경고
  static const Color error = Color(0xFFCF6679);

  // ============ 아이콘 색상 ============
  /// 기본 아이콘
  static const Color icon = Color(0xFFFFFFFF);

  /// 좋아요 아이콘 (활성화)
  static const Color likeActive = Color(0xFFFF6B6B);

  /// 좋아요 아이콘 (비활성화)
  static const Color likeInactive = Color(0xFF888888);

  // ============ 컴포넌트별 색상 ============
  /// FAB 배경색
  static const Color fabBackground = secondary;

  /// FAB 아이콘 색상
  static const Color fabIcon = background;

  /// AppBar 배경색
  static const Color appBarBackground = surface;

  /// 영화 카드 배경색
  static const Color cardBackground = surface;

  /// 검색 바 배경색
  static const Color searchBarBackground = surface;
}