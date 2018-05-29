#include "types.h"
#include "user.h"
#define MAX_CPU 4
#define	STDO	1
#define	STDI	0

struct cpu_pg_stat
{
	int cpu;
	int pool;
	int total_alloc;
	int total_freed;
};
struct system_pg_stat
{
	int ncpu;
	struct cpu_pg_stat pg_stat[MAX_CPU];
};

int main(int argc, char *argv[])
{
	int i;
	struct system_pg_stat pagesStats;

	system_pg_stat(&pagesStats);
	printf(STDO, "\nMemory allocation data\n");
	for (i = 0; i < pagesStats.ncpu; ++i)
	{
		printf(STDO, "cpu #%d pool: %d total alloc: %d total freed: %d\n", pagesStats.pg_stat[i].cpu,
			pagesStats.pg_stat[i].pool,
			pagesStats.pg_stat[i].total_alloc,
			pagesStats.pg_stat[i].total_freed);
	}

	exit();
	return -1;
}