#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include "check.h"

#define CODE_LEN 32

int main() {
  char* code = calloc(sizeof(char), CODE_LEN);

  puts("what's the code?");
  fflush(stdout);

  fgets(code, CODE_LEN - 1, stdin);

  uint32_t result = check(code);
  uint32_t nextport = (result % 8191) + 4096;

  printf("congratulations! http://10.219.2.1:%u/\n", nextport);
  fflush(stdout);

  return 0;
}
