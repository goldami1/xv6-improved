#include "types.h"
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
  int pid;
  pid = fork();
  if (pid == 0)
  {
    exit2(6);
  }
  wait2(&pid);
  printf(2,"%d",pid);
  exit();
}
