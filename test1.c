#include "types.h"
#include "stat.h"
#include "user.h"
#define	N	3
#define	STDI	0
#define STDO	1


void
printerr()
{
  printf(1,"fork failed , existing..)\n");
  exit();
}


//<Ami main>
int main(int argc, char *argv[])
{

	int pid, i, status;

	for (i = 1; i <= N; i++) {
		pid = fork();
		if (pid == 0) { //son code 			
			printf(STD_OUT, "my pid is <%d> going to exit(%d)\n", getpid(), i);
			exit2(i);
		}
	}

	for (i = 1; i <= N; i++) {
		pid = wait2(&status); //waiting till son is killed
		printf(STD_OUT, "child <%d> exited with status <%d>\n", pid, status);
	}

	exit();
	return -1;
}

//<Roma main>
//int
//main(int argc, char *argv[])
//{
//
//	// int i;
//	// int pid = 0;
//	// int status;
//
//	// for(i= 0 ;i <5 ;i++)
//	// {
//	//   pid = fork();
//	//   if(pid == 0)
//	//   {
//	//     printf(1,"enter %d %d\n",getpid(),i);
//	//     exit2(i);
//	//   }
//	//   wait2(&status);
//	//   printf(1,"%d %d \n",pid,status);
//	// }
//
//	int* status = (int*)malloc(N * sizeof(int));
//	int* children = (int*)malloc(N * sizeof(int));
//	int* pipes = (int*)malloc(N * sizeof(int) * 2);
//	char *catargs[] = { "cat" };
//	int i, pid;
//
//
//	for (i = 0; i < N; ++i)
//	{
//		pipe(pipes + 2 * i);
//		pid = fork();
//		if (pid == 0)
//		{
//			close(1);
//			dup(pipes[2 * i + 1]);
//			close(pipes[2 * i]);
//			close(pipes[2 * i + 1]);
//			printf(1, "my pid is %d going to exit(%d)\n", getpid(), i + 1);
//			exit2(i + 1);
//		}
//		if (pid == -1)
//			printerr();
//		else
//			children[i] = pid;
//	}
//
//
//	for (i = 0; i < N; ++i)
//	{
//		children[i] = wait2(&status[i]);
//	}
//
//	for (i = 0; i < N; ++i)
//	{
//		pid = fork();
//		if (pid == 0)
//		{
//			close(0);
//			dup(pipes[2 * i]);
//			close(pipes[2 * i]);
//			close(pipes[2 * i + 1]);
//			exec("cat", catargs);
//			exit();
//		}
//		if (pid != -1)
//		{
//			close(pipes[2 * i]);
//			close(pipes[2 * i + 1]);
//			wait();
//		}
//		else
//			printerr();
//	}
//
//	for (i = 0; i < N; ++i)
//	{
//		printf(1, "child %d exited with status %d\n", children[i], status[i]);
//	}
//
//	exit();
//}