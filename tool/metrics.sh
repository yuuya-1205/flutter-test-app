#!/usr/bin/env bash
#
# プロジェクトのコードメトリクスをローカルで算出する。
#   - 物理KLOC（lib/ の物理行数 / 1000）
#   - テスト件数（test/ 内の test / testWidgets / blocTest の登録数）
#   - テスト密度（テスト件数 / KLOC）
#   - バグ密度（バグ件数 / KLOC）
#
# 使い方:
#   tool/metrics.sh          # バグ件数 0 で算出
#   tool/metrics.sh 3        # バグ件数 3 を指定
#   BUGS=3 tool/metrics.sh   # 環境変数でも指定可
#
# 「物理」行数 = 空行・コメントを含む生の行数（physical lines of code）。

set -u

# リポジトリルートへ移動（どこから実行しても動くように）。
cd "$(dirname "$0")/.."

BUGS="${1:-${BUGS:-0}}"

# 物理行数を数える（対象ディレクトリの *.dart）。
count_loc() {
  local dir="$1"
  if [ -d "$dir" ]; then
    find "$dir" -name '*.dart' -exec cat {} + 2>/dev/null | wc -l | tr -d ' '
  else
    echo 0
  fi
}

lib_loc=$(count_loc lib)
test_loc=$(count_loc test)

# テスト件数: 行頭（インデント可）が test( / testWidgets( / blocTest< or ( のものを数える。
test_count=$(
  { grep -rhE "^[[:space:]]*(test|testWidgets|blocTest)[(<]" test --include='*.dart' 2>/dev/null || true; } \
    | wc -l | tr -d ' '
)

# KLOC と各密度（小数）を算出。
metrics=$(awk -v loc="$lib_loc" -v tc="$test_count" -v bugs="$BUGS" 'BEGIN{
  kloc = loc / 1000.0;
  if (loc > 0) { td = tc * 1000.0 / loc; bd = bugs * 1000.0 / loc; } else { td = 0; bd = 0; }
  printf "%.3f %.2f %.2f", kloc, td, bd;
}')
read -r kloc test_density bug_density <<EOF
$metrics
EOF

cat <<TXT
==== Code Metrics ====
物理LOC (lib/)   : ${lib_loc} 行  (${kloc} KLOC)
テストLOC (test/) : ${test_loc} 行
テスト件数        : ${test_count}
バグ件数 (入力)   : ${BUGS}

テスト密度 : ${test_density} 件 / KLOC
バグ密度   : ${bug_density} 件 / KLOC

---- PR貼り付け用 (Markdown) ----
| 指標 | 値 |
| --- | --- |
| 物理KLOC (lib) | ${kloc} |
| テスト件数 | ${test_count} |
| テスト密度 | ${test_density} 件/KLOC |
| バグ密度 | ${bug_density} 件/KLOC |
TXT
