// Physical memory allocator, intended to allocate
// memory for user processes, kernel stacks, page table pages,
// and pipe buffers. Allocates 4096-byte pages.

#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "spinlock.h"
#include "proc.h"


void freerange(void *vstart, void *vend);
extern char end[]; // first address after kernel loaded from ELF file
                   // defined by the kernel linker script in kernel.ld

struct run {
  struct run *next;
};

struct {
  struct spinlock lock;
  int use_lock;
  struct run *freelist;
} kmem;

struct {
  int count;
  struct run *freelist;
} pkmem[MAX_CPU] = {{ 0 }};


// Initialization happens in two phases.
// 1. main() calls kinit1() while still using entrypgdir to place just
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
  initlock(&kmem.lock, "kmem");
  kmem.use_lock = 0;
  freerange(vstart, vend);
}

void
kinit2(void *vstart, void *vend)
{
  freerange(vstart, vend);
  kmem.use_lock = 1;
}

void
freerange(void *vstart, void *vend)
{
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
    kfree(p);
}

//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
	if (ncpu==0)
	{
		skfree(v);
		return;
	}
  
  struct run *r;
  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
  pushcli();
  int currentCpu = cpuid();
  if(pkmem[currentCpu].count >= PLIST_MAX)
  {
    skfree(v);
    popcli();
    return;
  }

  r = (struct run*)v;
  r->next = pkmem[currentCpu].freelist;
  pkmem[currentCpu].freelist = r;
  pkmem[currentCpu].count++;
  cpu_pg_stats.pg_stat[currentCpu].pool = pkmem[currentCpu].count;
  cpu_pg_stats.pg_stat[currentCpu].total_freed++;
  popcli();

}


//PAGEBREAK: 21
// Free the page of physical memory pointed at by v,
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
skfree(char *v)
{
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = (struct run*)v;
  r->next = kmem.freelist;
  kmem.freelist = r;
  if(kmem.use_lock)
    release(&kmem.lock);
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
skalloc(void)
{
  struct run *r;

  if(kmem.use_lock)
    acquire(&kmem.lock);
  r = kmem.freelist;
  if(r)
    kmem.freelist = r->next;
  if(kmem.use_lock)
    release(&kmem.lock);
  return (char*)r;
}

// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
	if (ncpu==0)
		return skalloc();

  struct run *r;
  pushcli();
  int currentCpu = cpuid();

  while (pkmem[currentCpu].count <= PLIST_MIN)
  {
	  r = (struct run*)skalloc();
	  kfree((char*)r);
  }

  r = pkmem[currentCpu].freelist;
  if(r)
  {
    pkmem[currentCpu].count--;
    cpu_pg_stats.pg_stat[currentCpu].pool = pkmem[currentCpu].count;
    cpu_pg_stats.pg_stat[currentCpu].total_alloc++;
    pkmem[currentCpu].freelist = r->next;
  }
    
  popcli();
  return (char*)r;
}