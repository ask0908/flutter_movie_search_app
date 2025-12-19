import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // ============ Display (매우 큰 제목) ============
  /// Display Small - 로고, 특별한 강조
  static const TextStyle displaySmall = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w600, // semibold
    color: AppColors.lightText,
    letterSpacing: 0,
    height: 1.2,
  );

  // ============ Headline (화면 제목) ============
  /// Headline Small - 영화 상세 화면 제목
  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0,
    height: 1.3,
  );

  // ============ Title (섹션 제목) ============
  /// Title Large - 큰 섹션 제목
  static const TextStyle titleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400, // regular
    color: AppColors.lightText,
    letterSpacing: 0,
    height: 1.27,
  );

  /// Title Medium - 영화 카드 제목
  static const TextStyle titleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0.15,
    height: 1.5,
  );

  /// Title Small - 작은 제목
  static const TextStyle titleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0.1,
    height: 1.43,
  );

  // ============ Body (본문 텍스트) ============
  /// Body Large - 영화 상세 줄거리
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400, // regular
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.5,
    height: 1.5,
  );

  /// Body Medium - 영화 카드 설명
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400, // regular
    color: AppColors.lightTextSecondary,
    letterSpacing: 0.25,
    height: 1.43,
  );

  /// Body Small - 작은 메타 정보
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // regular
    color: AppColors.hintText,
    letterSpacing: 0.4,
    height: 1.33,
  );

  // ============ Label (버튼, 칩 텍스트) ============
  /// Label Large - 버튼 텍스트
  static const TextStyle labelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0.1,
    height: 1.43,
  );

  /// Label Medium - 중간 크기 라벨
  static const TextStyle labelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0.5,
    height: 1.33,
  );

  /// Label Small - 장르 칩 텍스트
  static const TextStyle labelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500, // medium
    color: AppColors.lightText,
    letterSpacing: 0.5,
    height: 1.45,
  );

  // ============ 특수 용도 ============
  /// 검색 바 플레이스홀더
  static const TextStyle searchPlaceholder = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.hintText,
    letterSpacing: 0.15,
  );

  /// AppBar 제목
  static const TextStyle appBarTitle = titleLarge;
}