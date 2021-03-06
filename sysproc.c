#include "types.h"
#include "x86.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
  return fork();
}

int
sys_exit(void)
{
  exit();
  return 0;  // not reached
}

int
sys_wait(void)
{
  return wait();
}

int
sys_kill(void)
{
  int pid;

  if(argint(0, &pid) < 0)
    return -1;
  return kill(pid);
}

int
sys_getpid(void)
{
  return myproc()->pid;
}

int
sys_sbrk(void)
{
  int addr;
  int n;

  if(argint(0, &n) < 0)
    return -1;
  addr = myproc()->sz;
  if(growproc(n) < 0)
    return -1;
  return addr;
}

int
sys_sleep(void)
{
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    return -1;
  acquire(&tickslock);
  ticks0 = ticks;
  while(ticks - ticks0 < n){
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
  }
  release(&tickslock);
  return 0;
}

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
  uint xticks;

  acquire(&tickslock);
  xticks = ticks;
  release(&tickslock);
  return xticks;
}

int
sys_exit2(void)
{
  int e;

  if(argint(0, &e) < 0)
    return -1;
  exit2(e);
  return 0;  // not reached
}

int
sys_wait2(void)
{
  int *e;

  if(argptr(0, (char**)&e, sizeof(int*)) < 0)
    return -1;
    
  return wait2(e);
}

int sys_mutex_acquire(void)
{
	int id;

	if (argint(0, &id) < 0)
		return -1;
	return 0;
}

int sys_mutex_release(void)
{
	return 0;
}

int sys_getppid(void)
{
	return myproc()->parent->pid;
}

int sys_system_pg_stat(void)
{
	struct system_pg_stat* stat;
	argptr(0, (char**)&stat, sizeof(struct system_pg_stat*));
	return system_pg_stat(stat);
}
