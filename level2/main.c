#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "check.h"

#define CODE_LEN 32

int main() {
  char* code = calloc(sizeof(char), CODE_LEN);

  puts("what's the code?");

  fgets(code, CODE_LEN - 1, stdin);

  uint64_t result = check(code);
  uint64_t nextport = (result % 4096) + 4096;

  printf("congratulations! %llu\n", nextport);

  return 0;
}
