#include <stdint.h>
#include <stdlib.h>
int32_t check_0(int64_t cur) {
  // 84 - 1 => 83
  cur = cur - 1;
  // 83 - 4 => 79
  cur = cur - 4;
  // 79 - 15 => 64
  cur = cur - 15;
  // 64 - 5 => 59
  cur = cur - 5;
  if (59 != cur) exit(-1);
  return cur;
}

int32_t check_1(int64_t cur) {
  // 104 - 3 => 101
  cur = cur - 3;
  // 101 - 4 => 97
  cur = cur - 4;
  // 97 - 2 => 95
  cur = cur - 2;
  // 95 - 6 => 89
  cur = cur - 6;
  if (89 != cur) exit(-1);
  return cur;
}

int32_t check_2(int64_t cur) {
  // 101 + 3 => 104
  cur = cur + 3;
  // 104 - 12 => 92
  cur = cur - 12;
  // 92 - 15 => 77
  cur = cur - 15;
  // 77 - 13 => 64
  cur = cur - 13;
  if (64 != cur) exit(-1);
  return cur;
}

int32_t check_3(int64_t cur) {
  // 82 - 4 => 78
  cur = cur - 4;
  // 78 + 9 => 87
  cur = cur + 9;
  // 87 + 9 => 96
  cur = cur + 9;
  // 96 + 10 => 106
  cur = cur + 10;
  if (106 != cur) exit(-1);
  return cur;
}

int32_t check_4(int64_t cur) {
  // 101 - 3 => 98
  cur = cur - 3;
  // 98 - 4 => 94
  cur = cur - 4;
  // 94 - 7 => 87
  cur = cur - 7;
  // 87 + 8 => 95
  cur = cur + 8;
  if (95 != cur) exit(-1);
  return cur;
}

int32_t check_5(int64_t cur) {
  // 97 - 16 => 81
  cur = cur - 16;
  // 81 - 7 => 74
  cur = cur - 7;
  // 74 - 8 => 66
  cur = cur - 8;
  // 66 + 4 => 70
  cur = cur + 4;
  if (70 != cur) exit(-1);
  return cur;
}

int32_t check_6(int64_t cur) {
  // 108 + 5 => 113
  cur = cur + 5;
  // 113 - 4 => 109
  cur = cur - 4;
  // 109 + 8 => 117
  cur = cur + 8;
  // 117 - 14 => 103
  cur = cur - 14;
  if (103 != cur) exit(-1);
  return cur;
}

int32_t check_7(int64_t cur) {
  // 81 + 7 => 88
  cur = cur + 7;
  // 88 - 16 => 72
  cur = cur - 16;
  // 72 + 15 => 87
  cur = cur + 15;
  // 87 + 14 => 101
  cur = cur + 14;
  if (101 != cur) exit(-1);
  return cur;
}

int32_t check_8(int64_t cur) {
  // 117 + 2 => 119
  cur = cur + 2;
  // 119 - 11 => 108
  cur = cur - 11;
  // 108 - 15 => 93
  cur = cur - 15;
  // 93 + 14 => 107
  cur = cur + 14;
  if (107 != cur) exit(-1);
  return cur;
}

int32_t check_9(int64_t cur) {
  // 97 + 15 => 112
  cur = cur + 15;
  // 112 - 12 => 100
  cur = cur - 12;
  // 100 + 4 => 104
  cur = cur + 4;
  // 104 - 4 => 100
  cur = cur - 4;
  if (100 != cur) exit(-1);
  return cur;
}

int32_t check_10(int64_t cur) {
  // 105 + 5 => 110
  cur = cur + 5;
  // 110 + 13 => 123
  cur = cur + 13;
  // 123 - 13 => 110
  cur = cur - 13;
  // 110 - 16 => 94
  cur = cur - 16;
  if (94 != cur) exit(-1);
  return cur;
}

int32_t check_11(int64_t cur) {
  // 100 + 6 => 106
  cur = cur + 6;
  // 106 + 5 => 111
  cur = cur + 5;
  // 111 - 16 => 95
  cur = cur - 16;
  // 95 + 7 => 102
  cur = cur + 7;
  if (102 != cur) exit(-1);
  return cur;
}

uint32_t check(char* got) {
  uint32_t sum = 0;
  sum += check_0(got[0]);
  sum += check_1(got[1]);
  sum += check_2(got[2]);
  sum += check_3(got[3]);
  sum += check_4(got[4]);
  sum += check_5(got[5]);
  sum += check_6(got[6]);
  sum += check_7(got[7]);
  sum += check_8(got[8]);
  sum += check_9(got[9]);
  sum += check_10(got[10]);
  sum += check_11(got[11]);
  return sum;
}
