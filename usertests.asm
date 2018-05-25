
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return randstate;
}

int
main(int argc, char *argv[])
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  printf(1, "usertests starting\n");
       9:	c7 44 24 04 92 4e 00 	movl   $0x4e92,0x4(%esp)
      10:	00 
      11:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      18:	e8 5f 3b 00 00       	call   3b7c <printf>

  if(open("usertests.ran", 0) >= 0){
      1d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
      24:	00 
      25:	c7 04 24 a6 4e 00 00 	movl   $0x4ea6,(%esp)
      2c:	e8 57 3a 00 00       	call   3a88 <open>
      31:	85 c0                	test   %eax,%eax
      33:	78 19                	js     4e <main+0x4e>
    printf(1, "already ran user tests -- rebuild fs.img\n");
      35:	c7 44 24 04 10 56 00 	movl   $0x5610,0x4(%esp)
      3c:	00 
      3d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
      44:	e8 33 3b 00 00       	call   3b7c <printf>
    exit();
      49:	e8 fa 39 00 00       	call   3a48 <exit>
  }
  close(open("usertests.ran", O_CREATE));
      4e:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
      55:	00 
      56:	c7 04 24 a6 4e 00 00 	movl   $0x4ea6,(%esp)
      5d:	e8 26 3a 00 00       	call   3a88 <open>
      62:	89 04 24             	mov    %eax,(%esp)
      65:	e8 06 3a 00 00       	call   3a70 <close>

  argptest();
      6a:	e8 6d 37 00 00       	call   37dc <argptest>
  createdelete();
      6f:	e8 a8 11 00 00       	call   121c <createdelete>
  linkunlink();
      74:	e8 9f 1a 00 00       	call   1b18 <linkunlink>
  concreate();
      79:	e8 be 17 00 00       	call   183c <concreate>
  fourfiles();
      7e:	e8 b1 0f 00 00       	call   1034 <fourfiles>
  sharedfd();
      83:	e8 e0 0d 00 00       	call   e68 <sharedfd>

  bigargtest();
      88:	e8 a3 33 00 00       	call   3430 <bigargtest>
  bigwrite();
      8d:	e8 62 24 00 00       	call   24f4 <bigwrite>
  bigargtest();
      92:	e8 99 33 00 00       	call   3430 <bigargtest>
  bsstest();
      97:	e8 24 33 00 00       	call   33c0 <bsstest>
  sbrktest();
      9c:	e8 23 2e 00 00       	call   2ec4 <sbrktest>
  validatetest();
      a1:	e8 72 32 00 00       	call   3318 <validatetest>

  opentest();
      a6:	e8 35 03 00 00       	call   3e0 <opentest>
  writetest();
      ab:	e8 d0 03 00 00       	call   480 <writetest>
  writetest1();
      b0:	e8 cb 05 00 00       	call   680 <writetest1>
  createtest();
      b5:	e8 a6 07 00 00       	call   860 <createtest>

  openiputtest();
      ba:	e8 25 02 00 00       	call   2e4 <openiputtest>
  exitiputtest();
      bf:	e8 3c 01 00 00       	call   200 <exitiputtest>
  iputtest();
      c4:	e8 57 00 00 00       	call   120 <iputtest>

  mem();
      c9:	e8 d6 0c 00 00       	call   da4 <mem>
  pipe1();
      ce:	e8 55 09 00 00       	call   a28 <pipe1>
  preempt();
      d3:	e8 00 0b 00 00       	call   bd8 <preempt>
  exitwait();
      d8:	e8 47 0c 00 00       	call   d24 <exitwait>

  rmdot();
      dd:	e8 56 28 00 00       	call   2938 <rmdot>
  fourteen();
      e2:	e8 f9 26 00 00       	call   27e0 <fourteen>
  bigfile();
      e7:	e8 00 25 00 00       	call   25ec <bigfile>
  subdir();
      ec:	e8 7b 1c 00 00       	call   1d6c <subdir>
  linktest();
      f1:	e8 ee 14 00 00       	call   15e4 <linktest>
  unlinkread();
      f6:	e8 19 13 00 00       	call   1414 <unlinkread>
  dirfile();
      fb:	e8 c8 29 00 00       	call   2ac8 <dirfile>
  iref();
     100:	e8 f7 2b 00 00       	call   2cfc <iref>
  forktest();
     105:	e8 06 2d 00 00       	call   2e10 <forktest>
  bigdir(); // slow
     10a:	e8 21 1b 00 00       	call   1c30 <bigdir>

  uio();
     10f:	e8 48 36 00 00       	call   375c <uio>

  exectest();
     114:	e8 bf 08 00 00       	call   9d8 <exectest>

  exit();
     119:	e8 2a 39 00 00       	call   3a48 <exit>
     11e:	66 90                	xchg   %ax,%ax

00000120 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
     120:	55                   	push   %ebp
     121:	89 e5                	mov    %esp,%ebp
     123:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "iput test\n");
     126:	c7 44 24 04 38 3f 00 	movl   $0x3f38,0x4(%esp)
     12d:	00 
     12e:	a1 20 5f 00 00       	mov    0x5f20,%eax
     133:	89 04 24             	mov    %eax,(%esp)
     136:	e8 41 3a 00 00       	call   3b7c <printf>

  if(mkdir("iputdir") < 0){
     13b:	c7 04 24 cb 3e 00 00 	movl   $0x3ecb,(%esp)
     142:	e8 69 39 00 00       	call   3ab0 <mkdir>
     147:	85 c0                	test   %eax,%eax
     149:	78 4b                	js     196 <iputtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
     14b:	c7 04 24 cb 3e 00 00 	movl   $0x3ecb,(%esp)
     152:	e8 61 39 00 00       	call   3ab8 <chdir>
     157:	85 c0                	test   %eax,%eax
     159:	0f 88 85 00 00 00    	js     1e4 <iputtest+0xc4>
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
     15f:	c7 04 24 c8 3e 00 00 	movl   $0x3ec8,(%esp)
     166:	e8 2d 39 00 00       	call   3a98 <unlink>
     16b:	85 c0                	test   %eax,%eax
     16d:	78 5b                	js     1ca <iputtest+0xaa>
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
     16f:	c7 04 24 ed 3e 00 00 	movl   $0x3eed,(%esp)
     176:	e8 3d 39 00 00       	call   3ab8 <chdir>
     17b:	85 c0                	test   %eax,%eax
     17d:	78 31                	js     1b0 <iputtest+0x90>
    printf(stdout, "chdir / failed\n");
    exit();
  }
  printf(stdout, "iput test ok\n");
     17f:	c7 44 24 04 70 3f 00 	movl   $0x3f70,0x4(%esp)
     186:	00 
     187:	a1 20 5f 00 00       	mov    0x5f20,%eax
     18c:	89 04 24             	mov    %eax,(%esp)
     18f:	e8 e8 39 00 00       	call   3b7c <printf>
}
     194:	c9                   	leave  
     195:	c3                   	ret    
iputtest(void)
{
  printf(stdout, "iput test\n");

  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
     196:	c7 44 24 04 a4 3e 00 	movl   $0x3ea4,0x4(%esp)
     19d:	00 
     19e:	a1 20 5f 00 00       	mov    0x5f20,%eax
     1a3:	89 04 24             	mov    %eax,(%esp)
     1a6:	e8 d1 39 00 00       	call   3b7c <printf>
    exit();
     1ab:	e8 98 38 00 00       	call   3a48 <exit>
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
    exit();
  }
  if(chdir("/") < 0){
    printf(stdout, "chdir / failed\n");
     1b0:	c7 44 24 04 ef 3e 00 	movl   $0x3eef,0x4(%esp)
     1b7:	00 
     1b8:	a1 20 5f 00 00       	mov    0x5f20,%eax
     1bd:	89 04 24             	mov    %eax,(%esp)
     1c0:	e8 b7 39 00 00       	call   3b7c <printf>
    exit();
     1c5:	e8 7e 38 00 00       	call   3a48 <exit>
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
    exit();
  }
  if(unlink("../iputdir") < 0){
    printf(stdout, "unlink ../iputdir failed\n");
     1ca:	c7 44 24 04 d3 3e 00 	movl   $0x3ed3,0x4(%esp)
     1d1:	00 
     1d2:	a1 20 5f 00 00       	mov    0x5f20,%eax
     1d7:	89 04 24             	mov    %eax,(%esp)
     1da:	e8 9d 39 00 00       	call   3b7c <printf>
    exit();
     1df:	e8 64 38 00 00       	call   3a48 <exit>
  if(mkdir("iputdir") < 0){
    printf(stdout, "mkdir failed\n");
    exit();
  }
  if(chdir("iputdir") < 0){
    printf(stdout, "chdir iputdir failed\n");
     1e4:	c7 44 24 04 b2 3e 00 	movl   $0x3eb2,0x4(%esp)
     1eb:	00 
     1ec:	a1 20 5f 00 00       	mov    0x5f20,%eax
     1f1:	89 04 24             	mov    %eax,(%esp)
     1f4:	e8 83 39 00 00       	call   3b7c <printf>
    exit();
     1f9:	e8 4a 38 00 00       	call   3a48 <exit>
     1fe:	66 90                	xchg   %ax,%ax

00000200 <exitiputtest>:
}

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
     200:	55                   	push   %ebp
     201:	89 e5                	mov    %esp,%ebp
     203:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
     206:	c7 44 24 04 ff 3e 00 	movl   $0x3eff,0x4(%esp)
     20d:	00 
     20e:	a1 20 5f 00 00       	mov    0x5f20,%eax
     213:	89 04 24             	mov    %eax,(%esp)
     216:	e8 61 39 00 00       	call   3b7c <printf>

  pid = fork();
     21b:	e8 20 38 00 00       	call   3a40 <fork>
  if(pid < 0){
     220:	85 c0                	test   %eax,%eax
     222:	78 72                	js     296 <exitiputtest+0x96>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     224:	75 3a                	jne    260 <exitiputtest+0x60>
    if(mkdir("iputdir") < 0){
     226:	c7 04 24 cb 3e 00 00 	movl   $0x3ecb,(%esp)
     22d:	e8 7e 38 00 00       	call   3ab0 <mkdir>
     232:	85 c0                	test   %eax,%eax
     234:	0f 88 90 00 00 00    	js     2ca <exitiputtest+0xca>
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
     23a:	c7 04 24 cb 3e 00 00 	movl   $0x3ecb,(%esp)
     241:	e8 72 38 00 00       	call   3ab8 <chdir>
     246:	85 c0                	test   %eax,%eax
     248:	78 66                	js     2b0 <exitiputtest+0xb0>
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
     24a:	c7 04 24 c8 3e 00 00 	movl   $0x3ec8,(%esp)
     251:	e8 42 38 00 00       	call   3a98 <unlink>
     256:	85 c0                	test   %eax,%eax
     258:	78 22                	js     27c <exitiputtest+0x7c>
      printf(stdout, "unlink ../iputdir failed\n");
      exit();
    }
    exit();
     25a:	e8 e9 37 00 00       	call   3a48 <exit>
     25f:	90                   	nop
  }
  wait();
     260:	e8 eb 37 00 00       	call   3a50 <wait>
  printf(stdout, "exitiput test ok\n");
     265:	c7 44 24 04 22 3f 00 	movl   $0x3f22,0x4(%esp)
     26c:	00 
     26d:	a1 20 5f 00 00       	mov    0x5f20,%eax
     272:	89 04 24             	mov    %eax,(%esp)
     275:	e8 02 39 00 00       	call   3b7c <printf>
}
     27a:	c9                   	leave  
     27b:	c3                   	ret    
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
      exit();
    }
    if(unlink("../iputdir") < 0){
      printf(stdout, "unlink ../iputdir failed\n");
     27c:	c7 44 24 04 d3 3e 00 	movl   $0x3ed3,0x4(%esp)
     283:	00 
     284:	a1 20 5f 00 00       	mov    0x5f20,%eax
     289:	89 04 24             	mov    %eax,(%esp)
     28c:	e8 eb 38 00 00       	call   3b7c <printf>
      exit();
     291:	e8 b2 37 00 00       	call   3a48 <exit>

  printf(stdout, "exitiput test\n");

  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     296:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
     29d:	00 
     29e:	a1 20 5f 00 00       	mov    0x5f20,%eax
     2a3:	89 04 24             	mov    %eax,(%esp)
     2a6:	e8 d1 38 00 00       	call   3b7c <printf>
    exit();
     2ab:	e8 98 37 00 00       	call   3a48 <exit>
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
      exit();
    }
    if(chdir("iputdir") < 0){
      printf(stdout, "child chdir failed\n");
     2b0:	c7 44 24 04 0e 3f 00 	movl   $0x3f0e,0x4(%esp)
     2b7:	00 
     2b8:	a1 20 5f 00 00       	mov    0x5f20,%eax
     2bd:	89 04 24             	mov    %eax,(%esp)
     2c0:	e8 b7 38 00 00       	call   3b7c <printf>
      exit();
     2c5:	e8 7e 37 00 00       	call   3a48 <exit>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
    if(mkdir("iputdir") < 0){
      printf(stdout, "mkdir failed\n");
     2ca:	c7 44 24 04 a4 3e 00 	movl   $0x3ea4,0x4(%esp)
     2d1:	00 
     2d2:	a1 20 5f 00 00       	mov    0x5f20,%eax
     2d7:	89 04 24             	mov    %eax,(%esp)
     2da:	e8 9d 38 00 00       	call   3b7c <printf>
      exit();
     2df:	e8 64 37 00 00       	call   3a48 <exit>

000002e4 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     2e4:	55                   	push   %ebp
     2e5:	89 e5                	mov    %esp,%ebp
     2e7:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     2ea:	c7 44 24 04 34 3f 00 	movl   $0x3f34,0x4(%esp)
     2f1:	00 
     2f2:	a1 20 5f 00 00       	mov    0x5f20,%eax
     2f7:	89 04 24             	mov    %eax,(%esp)
     2fa:	e8 7d 38 00 00       	call   3b7c <printf>
  if(mkdir("oidir") < 0){
     2ff:	c7 04 24 43 3f 00 00 	movl   $0x3f43,(%esp)
     306:	e8 a5 37 00 00       	call   3ab0 <mkdir>
     30b:	85 c0                	test   %eax,%eax
     30d:	0f 88 96 00 00 00    	js     3a9 <openiputtest+0xc5>
    printf(stdout, "mkdir oidir failed\n");
    exit();
  }
  pid = fork();
     313:	e8 28 37 00 00       	call   3a40 <fork>
  if(pid < 0){
     318:	85 c0                	test   %eax,%eax
     31a:	0f 88 a3 00 00 00    	js     3c3 <openiputtest+0xdf>
    printf(stdout, "fork failed\n");
    exit();
  }
  if(pid == 0){
     320:	75 32                	jne    354 <openiputtest+0x70>
    int fd = open("oidir", O_RDWR);
     322:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
     329:	00 
     32a:	c7 04 24 43 3f 00 00 	movl   $0x3f43,(%esp)
     331:	e8 52 37 00 00       	call   3a88 <open>
    if(fd >= 0){
     336:	85 c0                	test   %eax,%eax
     338:	78 6a                	js     3a4 <openiputtest+0xc0>
      printf(stdout, "open directory for write succeeded\n");
     33a:	c7 44 24 04 c8 4e 00 	movl   $0x4ec8,0x4(%esp)
     341:	00 
     342:	a1 20 5f 00 00       	mov    0x5f20,%eax
     347:	89 04 24             	mov    %eax,(%esp)
     34a:	e8 2d 38 00 00       	call   3b7c <printf>
      exit();
     34f:	e8 f4 36 00 00       	call   3a48 <exit>
    }
    exit();
  }
  sleep(1);
     354:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     35b:	e8 78 37 00 00       	call   3ad8 <sleep>
  if(unlink("oidir") != 0){
     360:	c7 04 24 43 3f 00 00 	movl   $0x3f43,(%esp)
     367:	e8 2c 37 00 00       	call   3a98 <unlink>
     36c:	85 c0                	test   %eax,%eax
     36e:	75 1c                	jne    38c <openiputtest+0xa8>
    printf(stdout, "unlink failed\n");
    exit();
  }
  wait();
     370:	e8 db 36 00 00       	call   3a50 <wait>
  printf(stdout, "openiput test ok\n");
     375:	c7 44 24 04 6c 3f 00 	movl   $0x3f6c,0x4(%esp)
     37c:	00 
     37d:	a1 20 5f 00 00       	mov    0x5f20,%eax
     382:	89 04 24             	mov    %eax,(%esp)
     385:	e8 f2 37 00 00       	call   3b7c <printf>
}
     38a:	c9                   	leave  
     38b:	c3                   	ret    
    }
    exit();
  }
  sleep(1);
  if(unlink("oidir") != 0){
    printf(stdout, "unlink failed\n");
     38c:	c7 44 24 04 5d 3f 00 	movl   $0x3f5d,0x4(%esp)
     393:	00 
     394:	a1 20 5f 00 00       	mov    0x5f20,%eax
     399:	89 04 24             	mov    %eax,(%esp)
     39c:	e8 db 37 00 00       	call   3b7c <printf>
     3a1:	8d 76 00             	lea    0x0(%esi),%esi
    exit();
     3a4:	e8 9f 36 00 00       	call   3a48 <exit>
{
  int pid;

  printf(stdout, "openiput test\n");
  if(mkdir("oidir") < 0){
    printf(stdout, "mkdir oidir failed\n");
     3a9:	c7 44 24 04 49 3f 00 	movl   $0x3f49,0x4(%esp)
     3b0:	00 
     3b1:	a1 20 5f 00 00       	mov    0x5f20,%eax
     3b6:	89 04 24             	mov    %eax,(%esp)
     3b9:	e8 be 37 00 00       	call   3b7c <printf>
    exit();
     3be:	e8 85 36 00 00       	call   3a48 <exit>
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "fork failed\n");
     3c3:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
     3ca:	00 
     3cb:	a1 20 5f 00 00       	mov    0x5f20,%eax
     3d0:	89 04 24             	mov    %eax,(%esp)
     3d3:	e8 a4 37 00 00       	call   3b7c <printf>
    exit();
     3d8:	e8 6b 36 00 00       	call   3a48 <exit>
     3dd:	8d 76 00             	lea    0x0(%esi),%esi

000003e0 <opentest>:

// simple file system tests

void
opentest(void)
{
     3e0:	55                   	push   %ebp
     3e1:	89 e5                	mov    %esp,%ebp
     3e3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     3e6:	c7 44 24 04 7e 3f 00 	movl   $0x3f7e,0x4(%esp)
     3ed:	00 
     3ee:	a1 20 5f 00 00       	mov    0x5f20,%eax
     3f3:	89 04 24             	mov    %eax,(%esp)
     3f6:	e8 81 37 00 00       	call   3b7c <printf>
  fd = open("echo", 0);
     3fb:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     402:	00 
     403:	c7 04 24 89 3f 00 00 	movl   $0x3f89,(%esp)
     40a:	e8 79 36 00 00       	call   3a88 <open>
  if(fd < 0){
     40f:	85 c0                	test   %eax,%eax
     411:	78 37                	js     44a <opentest+0x6a>
    printf(stdout, "open echo failed!\n");
    exit();
  }
  close(fd);
     413:	89 04 24             	mov    %eax,(%esp)
     416:	e8 55 36 00 00       	call   3a70 <close>
  fd = open("doesnotexist", 0);
     41b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     422:	00 
     423:	c7 04 24 a1 3f 00 00 	movl   $0x3fa1,(%esp)
     42a:	e8 59 36 00 00       	call   3a88 <open>
  if(fd >= 0){
     42f:	85 c0                	test   %eax,%eax
     431:	79 31                	jns    464 <opentest+0x84>
    printf(stdout, "open doesnotexist succeeded!\n");
    exit();
  }
  printf(stdout, "open test ok\n");
     433:	c7 44 24 04 cc 3f 00 	movl   $0x3fcc,0x4(%esp)
     43a:	00 
     43b:	a1 20 5f 00 00       	mov    0x5f20,%eax
     440:	89 04 24             	mov    %eax,(%esp)
     443:	e8 34 37 00 00       	call   3b7c <printf>
}
     448:	c9                   	leave  
     449:	c3                   	ret    
  int fd;

  printf(stdout, "open test\n");
  fd = open("echo", 0);
  if(fd < 0){
    printf(stdout, "open echo failed!\n");
     44a:	c7 44 24 04 8e 3f 00 	movl   $0x3f8e,0x4(%esp)
     451:	00 
     452:	a1 20 5f 00 00       	mov    0x5f20,%eax
     457:	89 04 24             	mov    %eax,(%esp)
     45a:	e8 1d 37 00 00       	call   3b7c <printf>
    exit();
     45f:	e8 e4 35 00 00       	call   3a48 <exit>
  }
  close(fd);
  fd = open("doesnotexist", 0);
  if(fd >= 0){
    printf(stdout, "open doesnotexist succeeded!\n");
     464:	c7 44 24 04 ae 3f 00 	movl   $0x3fae,0x4(%esp)
     46b:	00 
     46c:	a1 20 5f 00 00       	mov    0x5f20,%eax
     471:	89 04 24             	mov    %eax,(%esp)
     474:	e8 03 37 00 00       	call   3b7c <printf>
    exit();
     479:	e8 ca 35 00 00       	call   3a48 <exit>
     47e:	66 90                	xchg   %ax,%ax

00000480 <writetest>:
  printf(stdout, "open test ok\n");
}

void
writetest(void)
{
     480:	55                   	push   %ebp
     481:	89 e5                	mov    %esp,%ebp
     483:	56                   	push   %esi
     484:	53                   	push   %ebx
     485:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     488:	c7 44 24 04 da 3f 00 	movl   $0x3fda,0x4(%esp)
     48f:	00 
     490:	a1 20 5f 00 00       	mov    0x5f20,%eax
     495:	89 04 24             	mov    %eax,(%esp)
     498:	e8 df 36 00 00       	call   3b7c <printf>
  fd = open("small", O_CREATE|O_RDWR);
     49d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     4a4:	00 
     4a5:	c7 04 24 eb 3f 00 00 	movl   $0x3feb,(%esp)
     4ac:	e8 d7 35 00 00       	call   3a88 <open>
     4b1:	89 c6                	mov    %eax,%esi
  if(fd >= 0){
     4b3:	85 c0                	test   %eax,%eax
     4b5:	0f 88 ab 01 00 00    	js     666 <writetest+0x1e6>
    printf(stdout, "creat small succeeded; ok\n");
     4bb:	c7 44 24 04 f1 3f 00 	movl   $0x3ff1,0x4(%esp)
     4c2:	00 
     4c3:	a1 20 5f 00 00       	mov    0x5f20,%eax
     4c8:	89 04 24             	mov    %eax,(%esp)
     4cb:	e8 ac 36 00 00       	call   3b7c <printf>
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     4d0:	31 db                	xor    %ebx,%ebx
     4d2:	66 90                	xchg   %ax,%ax
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     4d4:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     4db:	00 
     4dc:	c7 44 24 04 28 40 00 	movl   $0x4028,0x4(%esp)
     4e3:	00 
     4e4:	89 34 24             	mov    %esi,(%esp)
     4e7:	e8 7c 35 00 00       	call   3a68 <write>
     4ec:	83 f8 0a             	cmp    $0xa,%eax
     4ef:	0f 85 e7 00 00 00    	jne    5dc <writetest+0x15c>
      printf(stdout, "error: write aa %d new file failed\n", i);
      exit();
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     4f5:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     4fc:	00 
     4fd:	c7 44 24 04 33 40 00 	movl   $0x4033,0x4(%esp)
     504:	00 
     505:	89 34 24             	mov    %esi,(%esp)
     508:	e8 5b 35 00 00       	call   3a68 <write>
     50d:	83 f8 0a             	cmp    $0xa,%eax
     510:	0f 85 e4 00 00 00    	jne    5fa <writetest+0x17a>
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     516:	43                   	inc    %ebx
     517:	83 fb 64             	cmp    $0x64,%ebx
     51a:	75 b8                	jne    4d4 <writetest+0x54>
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
      exit();
    }
  }
  printf(stdout, "writes ok\n");
     51c:	c7 44 24 04 3e 40 00 	movl   $0x403e,0x4(%esp)
     523:	00 
     524:	a1 20 5f 00 00       	mov    0x5f20,%eax
     529:	89 04 24             	mov    %eax,(%esp)
     52c:	e8 4b 36 00 00       	call   3b7c <printf>
  close(fd);
     531:	89 34 24             	mov    %esi,(%esp)
     534:	e8 37 35 00 00       	call   3a70 <close>
  fd = open("small", O_RDONLY);
     539:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     540:	00 
     541:	c7 04 24 eb 3f 00 00 	movl   $0x3feb,(%esp)
     548:	e8 3b 35 00 00       	call   3a88 <open>
     54d:	89 c3                	mov    %eax,%ebx
  if(fd >= 0){
     54f:	85 c0                	test   %eax,%eax
     551:	0f 88 c1 00 00 00    	js     618 <writetest+0x198>
    printf(stdout, "open small succeeded ok\n");
     557:	c7 44 24 04 49 40 00 	movl   $0x4049,0x4(%esp)
     55e:	00 
     55f:	a1 20 5f 00 00       	mov    0x5f20,%eax
     564:	89 04 24             	mov    %eax,(%esp)
     567:	e8 10 36 00 00       	call   3b7c <printf>
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     56c:	c7 44 24 08 d0 07 00 	movl   $0x7d0,0x8(%esp)
     573:	00 
     574:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     57b:	00 
     57c:	89 1c 24             	mov    %ebx,(%esp)
     57f:	e8 dc 34 00 00       	call   3a60 <read>
  if(i == 2000){
     584:	3d d0 07 00 00       	cmp    $0x7d0,%eax
     589:	0f 85 a3 00 00 00    	jne    632 <writetest+0x1b2>
    printf(stdout, "read succeeded ok\n");
     58f:	c7 44 24 04 7d 40 00 	movl   $0x407d,0x4(%esp)
     596:	00 
     597:	a1 20 5f 00 00       	mov    0x5f20,%eax
     59c:	89 04 24             	mov    %eax,(%esp)
     59f:	e8 d8 35 00 00       	call   3b7c <printf>
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     5a4:	89 1c 24             	mov    %ebx,(%esp)
     5a7:	e8 c4 34 00 00       	call   3a70 <close>

  if(unlink("small") < 0){
     5ac:	c7 04 24 eb 3f 00 00 	movl   $0x3feb,(%esp)
     5b3:	e8 e0 34 00 00       	call   3a98 <unlink>
     5b8:	85 c0                	test   %eax,%eax
     5ba:	0f 88 8c 00 00 00    	js     64c <writetest+0x1cc>
    printf(stdout, "unlink small failed\n");
    exit();
  }
  printf(stdout, "small file test ok\n");
     5c0:	c7 44 24 04 a5 40 00 	movl   $0x40a5,0x4(%esp)
     5c7:	00 
     5c8:	a1 20 5f 00 00       	mov    0x5f20,%eax
     5cd:	89 04 24             	mov    %eax,(%esp)
     5d0:	e8 a7 35 00 00       	call   3b7c <printf>
}
     5d5:	83 c4 10             	add    $0x10,%esp
     5d8:	5b                   	pop    %ebx
     5d9:	5e                   	pop    %esi
     5da:	5d                   	pop    %ebp
     5db:	c3                   	ret    
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
    if(write(fd, "aaaaaaaaaa", 10) != 10){
      printf(stdout, "error: write aa %d new file failed\n", i);
     5dc:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     5e0:	c7 44 24 04 ec 4e 00 	movl   $0x4eec,0x4(%esp)
     5e7:	00 
     5e8:	a1 20 5f 00 00       	mov    0x5f20,%eax
     5ed:	89 04 24             	mov    %eax,(%esp)
     5f0:	e8 87 35 00 00       	call   3b7c <printf>
      exit();
     5f5:	e8 4e 34 00 00       	call   3a48 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
      printf(stdout, "error: write bb %d new file failed\n", i);
     5fa:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     5fe:	c7 44 24 04 10 4f 00 	movl   $0x4f10,0x4(%esp)
     605:	00 
     606:	a1 20 5f 00 00       	mov    0x5f20,%eax
     60b:	89 04 24             	mov    %eax,(%esp)
     60e:	e8 69 35 00 00       	call   3b7c <printf>
      exit();
     613:	e8 30 34 00 00       	call   3a48 <exit>
  close(fd);
  fd = open("small", O_RDONLY);
  if(fd >= 0){
    printf(stdout, "open small succeeded ok\n");
  } else {
    printf(stdout, "error: open small failed!\n");
     618:	c7 44 24 04 62 40 00 	movl   $0x4062,0x4(%esp)
     61f:	00 
     620:	a1 20 5f 00 00       	mov    0x5f20,%eax
     625:	89 04 24             	mov    %eax,(%esp)
     628:	e8 4f 35 00 00       	call   3b7c <printf>
    exit();
     62d:	e8 16 34 00 00       	call   3a48 <exit>
  }
  i = read(fd, buf, 2000);
  if(i == 2000){
    printf(stdout, "read succeeded ok\n");
  } else {
    printf(stdout, "read failed\n");
     632:	c7 44 24 04 a9 43 00 	movl   $0x43a9,0x4(%esp)
     639:	00 
     63a:	a1 20 5f 00 00       	mov    0x5f20,%eax
     63f:	89 04 24             	mov    %eax,(%esp)
     642:	e8 35 35 00 00       	call   3b7c <printf>
    exit();
     647:	e8 fc 33 00 00       	call   3a48 <exit>
  }
  close(fd);

  if(unlink("small") < 0){
    printf(stdout, "unlink small failed\n");
     64c:	c7 44 24 04 90 40 00 	movl   $0x4090,0x4(%esp)
     653:	00 
     654:	a1 20 5f 00 00       	mov    0x5f20,%eax
     659:	89 04 24             	mov    %eax,(%esp)
     65c:	e8 1b 35 00 00       	call   3b7c <printf>
    exit();
     661:	e8 e2 33 00 00       	call   3a48 <exit>
  printf(stdout, "small file test\n");
  fd = open("small", O_CREATE|O_RDWR);
  if(fd >= 0){
    printf(stdout, "creat small succeeded; ok\n");
  } else {
    printf(stdout, "error: creat small failed!\n");
     666:	c7 44 24 04 0c 40 00 	movl   $0x400c,0x4(%esp)
     66d:	00 
     66e:	a1 20 5f 00 00       	mov    0x5f20,%eax
     673:	89 04 24             	mov    %eax,(%esp)
     676:	e8 01 35 00 00       	call   3b7c <printf>
    exit();
     67b:	e8 c8 33 00 00       	call   3a48 <exit>

00000680 <writetest1>:
  printf(stdout, "small file test ok\n");
}

void
writetest1(void)
{
     680:	55                   	push   %ebp
     681:	89 e5                	mov    %esp,%ebp
     683:	56                   	push   %esi
     684:	53                   	push   %ebx
     685:	83 ec 10             	sub    $0x10,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     688:	c7 44 24 04 b9 40 00 	movl   $0x40b9,0x4(%esp)
     68f:	00 
     690:	a1 20 5f 00 00       	mov    0x5f20,%eax
     695:	89 04 24             	mov    %eax,(%esp)
     698:	e8 df 34 00 00       	call   3b7c <printf>

  fd = open("big", O_CREATE|O_RDWR);
     69d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     6a4:	00 
     6a5:	c7 04 24 33 41 00 00 	movl   $0x4133,(%esp)
     6ac:	e8 d7 33 00 00       	call   3a88 <open>
     6b1:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     6b3:	85 c0                	test   %eax,%eax
     6b5:	0f 88 70 01 00 00    	js     82b <writetest1+0x1ab>
     6bb:	31 db                	xor    %ebx,%ebx
     6bd:	8d 76 00             	lea    0x0(%esi),%esi
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
     6c0:	89 1d 00 87 00 00    	mov    %ebx,0x8700
    if(write(fd, buf, 512) != 512){
     6c6:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     6cd:	00 
     6ce:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     6d5:	00 
     6d6:	89 34 24             	mov    %esi,(%esp)
     6d9:	e8 8a 33 00 00       	call   3a68 <write>
     6de:	3d 00 02 00 00       	cmp    $0x200,%eax
     6e3:	0f 85 a8 00 00 00    	jne    791 <writetest1+0x111>
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
    exit();
  }

  for(i = 0; i < MAXFILE; i++){
     6e9:	43                   	inc    %ebx
     6ea:	81 fb 8c 00 00 00    	cmp    $0x8c,%ebx
     6f0:	75 ce                	jne    6c0 <writetest1+0x40>
      printf(stdout, "error: write big file failed\n", i);
      exit();
    }
  }

  close(fd);
     6f2:	89 34 24             	mov    %esi,(%esp)
     6f5:	e8 76 33 00 00       	call   3a70 <close>

  fd = open("big", O_RDONLY);
     6fa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     701:	00 
     702:	c7 04 24 33 41 00 00 	movl   $0x4133,(%esp)
     709:	e8 7a 33 00 00       	call   3a88 <open>
     70e:	89 c6                	mov    %eax,%esi
  if(fd < 0){
     710:	85 c0                	test   %eax,%eax
     712:	0f 88 f9 00 00 00    	js     811 <writetest1+0x191>
     718:	31 db                	xor    %ebx,%ebx
     71a:	eb 15                	jmp    731 <writetest1+0xb1>
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
     71c:	3d 00 02 00 00       	cmp    $0x200,%eax
     721:	0f 85 aa 00 00 00    	jne    7d1 <writetest1+0x151>
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
     727:	a1 00 87 00 00       	mov    0x8700,%eax
     72c:	39 d8                	cmp    %ebx,%eax
     72e:	75 7f                	jne    7af <writetest1+0x12f>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
     730:	43                   	inc    %ebx
    exit();
  }

  n = 0;
  for(;;){
    i = read(fd, buf, 512);
     731:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
     738:	00 
     739:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     740:	00 
     741:	89 34 24             	mov    %esi,(%esp)
     744:	e8 17 33 00 00       	call   3a60 <read>
    if(i == 0){
     749:	85 c0                	test   %eax,%eax
     74b:	75 cf                	jne    71c <writetest1+0x9c>
      if(n == MAXFILE - 1){
     74d:	81 fb 8b 00 00 00    	cmp    $0x8b,%ebx
     753:	0f 84 96 00 00 00    	je     7ef <writetest1+0x16f>
             n, ((int*)buf)[0]);
      exit();
    }
    n++;
  }
  close(fd);
     759:	89 34 24             	mov    %esi,(%esp)
     75c:	e8 0f 33 00 00       	call   3a70 <close>
  if(unlink("big") < 0){
     761:	c7 04 24 33 41 00 00 	movl   $0x4133,(%esp)
     768:	e8 2b 33 00 00       	call   3a98 <unlink>
     76d:	85 c0                	test   %eax,%eax
     76f:	0f 88 d0 00 00 00    	js     845 <writetest1+0x1c5>
    printf(stdout, "unlink big failed\n");
    exit();
  }
  printf(stdout, "big files ok\n");
     775:	c7 44 24 04 5a 41 00 	movl   $0x415a,0x4(%esp)
     77c:	00 
     77d:	a1 20 5f 00 00       	mov    0x5f20,%eax
     782:	89 04 24             	mov    %eax,(%esp)
     785:	e8 f2 33 00 00       	call   3b7c <printf>
}
     78a:	83 c4 10             	add    $0x10,%esp
     78d:	5b                   	pop    %ebx
     78e:	5e                   	pop    %esi
     78f:	5d                   	pop    %ebp
     790:	c3                   	ret    
  }

  for(i = 0; i < MAXFILE; i++){
    ((int*)buf)[0] = i;
    if(write(fd, buf, 512) != 512){
      printf(stdout, "error: write big file failed\n", i);
     791:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     795:	c7 44 24 04 e3 40 00 	movl   $0x40e3,0x4(%esp)
     79c:	00 
     79d:	a1 20 5f 00 00       	mov    0x5f20,%eax
     7a2:	89 04 24             	mov    %eax,(%esp)
     7a5:	e8 d2 33 00 00       	call   3b7c <printf>
      exit();
     7aa:	e8 99 32 00 00       	call   3a48 <exit>
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
      exit();
    }
    if(((int*)buf)[0] != n){
      printf(stdout, "read content of block %d is %d\n",
     7af:	89 44 24 0c          	mov    %eax,0xc(%esp)
     7b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
     7b7:	c7 44 24 04 34 4f 00 	movl   $0x4f34,0x4(%esp)
     7be:	00 
     7bf:	a1 20 5f 00 00       	mov    0x5f20,%eax
     7c4:	89 04 24             	mov    %eax,(%esp)
     7c7:	e8 b0 33 00 00       	call   3b7c <printf>
             n, ((int*)buf)[0]);
      exit();
     7cc:	e8 77 32 00 00       	call   3a48 <exit>
        printf(stdout, "read only %d blocks from big", n);
        exit();
      }
      break;
    } else if(i != 512){
      printf(stdout, "read failed %d\n", i);
     7d1:	89 44 24 08          	mov    %eax,0x8(%esp)
     7d5:	c7 44 24 04 37 41 00 	movl   $0x4137,0x4(%esp)
     7dc:	00 
     7dd:	a1 20 5f 00 00       	mov    0x5f20,%eax
     7e2:	89 04 24             	mov    %eax,(%esp)
     7e5:	e8 92 33 00 00       	call   3b7c <printf>
      exit();
     7ea:	e8 59 32 00 00       	call   3a48 <exit>
  n = 0;
  for(;;){
    i = read(fd, buf, 512);
    if(i == 0){
      if(n == MAXFILE - 1){
        printf(stdout, "read only %d blocks from big", n);
     7ef:	c7 44 24 08 8b 00 00 	movl   $0x8b,0x8(%esp)
     7f6:	00 
     7f7:	c7 44 24 04 1a 41 00 	movl   $0x411a,0x4(%esp)
     7fe:	00 
     7ff:	a1 20 5f 00 00       	mov    0x5f20,%eax
     804:	89 04 24             	mov    %eax,(%esp)
     807:	e8 70 33 00 00       	call   3b7c <printf>
        exit();
     80c:	e8 37 32 00 00       	call   3a48 <exit>

  close(fd);

  fd = open("big", O_RDONLY);
  if(fd < 0){
    printf(stdout, "error: open big failed!\n");
     811:	c7 44 24 04 01 41 00 	movl   $0x4101,0x4(%esp)
     818:	00 
     819:	a1 20 5f 00 00       	mov    0x5f20,%eax
     81e:	89 04 24             	mov    %eax,(%esp)
     821:	e8 56 33 00 00       	call   3b7c <printf>
    exit();
     826:	e8 1d 32 00 00       	call   3a48 <exit>

  printf(stdout, "big files test\n");

  fd = open("big", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(stdout, "error: creat big failed!\n");
     82b:	c7 44 24 04 c9 40 00 	movl   $0x40c9,0x4(%esp)
     832:	00 
     833:	a1 20 5f 00 00       	mov    0x5f20,%eax
     838:	89 04 24             	mov    %eax,(%esp)
     83b:	e8 3c 33 00 00       	call   3b7c <printf>
    exit();
     840:	e8 03 32 00 00       	call   3a48 <exit>
    }
    n++;
  }
  close(fd);
  if(unlink("big") < 0){
    printf(stdout, "unlink big failed\n");
     845:	c7 44 24 04 47 41 00 	movl   $0x4147,0x4(%esp)
     84c:	00 
     84d:	a1 20 5f 00 00       	mov    0x5f20,%eax
     852:	89 04 24             	mov    %eax,(%esp)
     855:	e8 22 33 00 00       	call   3b7c <printf>
    exit();
     85a:	e8 e9 31 00 00       	call   3a48 <exit>
     85f:	90                   	nop

00000860 <createtest>:
  printf(stdout, "big files ok\n");
}

void
createtest(void)
{
     860:	55                   	push   %ebp
     861:	89 e5                	mov    %esp,%ebp
     863:	53                   	push   %ebx
     864:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     867:	c7 44 24 04 54 4f 00 	movl   $0x4f54,0x4(%esp)
     86e:	00 
     86f:	a1 20 5f 00 00       	mov    0x5f20,%eax
     874:	89 04 24             	mov    %eax,(%esp)
     877:	e8 00 33 00 00       	call   3b7c <printf>

  name[0] = 'a';
     87c:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
  name[2] = '\0';
     883:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     88a:	b3 30                	mov    $0x30,%bl
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     88c:	88 1d 01 a7 00 00    	mov    %bl,0xa701
    fd = open(name, O_CREATE|O_RDWR);
     892:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     899:	00 
     89a:	c7 04 24 00 a7 00 00 	movl   $0xa700,(%esp)
     8a1:	e8 e2 31 00 00       	call   3a88 <open>
    close(fd);
     8a6:	89 04 24             	mov    %eax,(%esp)
     8a9:	e8 c2 31 00 00       	call   3a70 <close>
     8ae:	43                   	inc    %ebx

  printf(stdout, "many creates, followed by unlink test\n");

  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8af:	80 fb 64             	cmp    $0x64,%bl
     8b2:	75 d8                	jne    88c <createtest+0x2c>
    name[1] = '0' + i;
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
     8b4:	c6 05 00 a7 00 00 61 	movb   $0x61,0xa700
  name[2] = '\0';
     8bb:	c6 05 02 a7 00 00 00 	movb   $0x0,0xa702
     8c2:	b3 30                	mov    $0x30,%bl
  for(i = 0; i < 52; i++){
    name[1] = '0' + i;
     8c4:	88 1d 01 a7 00 00    	mov    %bl,0xa701
    unlink(name);
     8ca:	c7 04 24 00 a7 00 00 	movl   $0xa700,(%esp)
     8d1:	e8 c2 31 00 00       	call   3a98 <unlink>
     8d6:	43                   	inc    %ebx
    fd = open(name, O_CREATE|O_RDWR);
    close(fd);
  }
  name[0] = 'a';
  name[2] = '\0';
  for(i = 0; i < 52; i++){
     8d7:	80 fb 64             	cmp    $0x64,%bl
     8da:	75 e8                	jne    8c4 <createtest+0x64>
    name[1] = '0' + i;
    unlink(name);
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     8dc:	c7 44 24 04 7c 4f 00 	movl   $0x4f7c,0x4(%esp)
     8e3:	00 
     8e4:	a1 20 5f 00 00       	mov    0x5f20,%eax
     8e9:	89 04 24             	mov    %eax,(%esp)
     8ec:	e8 8b 32 00 00       	call   3b7c <printf>
}
     8f1:	83 c4 14             	add    $0x14,%esp
     8f4:	5b                   	pop    %ebx
     8f5:	5d                   	pop    %ebp
     8f6:	c3                   	ret    
     8f7:	90                   	nop

000008f8 <dirtest>:

void dirtest(void)
{
     8f8:	55                   	push   %ebp
     8f9:	89 e5                	mov    %esp,%ebp
     8fb:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "mkdir test\n");
     8fe:	c7 44 24 04 68 41 00 	movl   $0x4168,0x4(%esp)
     905:	00 
     906:	a1 20 5f 00 00       	mov    0x5f20,%eax
     90b:	89 04 24             	mov    %eax,(%esp)
     90e:	e8 69 32 00 00       	call   3b7c <printf>

  if(mkdir("dir0") < 0){
     913:	c7 04 24 74 41 00 00 	movl   $0x4174,(%esp)
     91a:	e8 91 31 00 00       	call   3ab0 <mkdir>
     91f:	85 c0                	test   %eax,%eax
     921:	78 4b                	js     96e <dirtest+0x76>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
     923:	c7 04 24 74 41 00 00 	movl   $0x4174,(%esp)
     92a:	e8 89 31 00 00       	call   3ab8 <chdir>
     92f:	85 c0                	test   %eax,%eax
     931:	0f 88 85 00 00 00    	js     9bc <dirtest+0xc4>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
     937:	c7 04 24 19 47 00 00 	movl   $0x4719,(%esp)
     93e:	e8 75 31 00 00       	call   3ab8 <chdir>
     943:	85 c0                	test   %eax,%eax
     945:	78 5b                	js     9a2 <dirtest+0xaa>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
     947:	c7 04 24 74 41 00 00 	movl   $0x4174,(%esp)
     94e:	e8 45 31 00 00       	call   3a98 <unlink>
     953:	85 c0                	test   %eax,%eax
     955:	78 31                	js     988 <dirtest+0x90>
    printf(stdout, "unlink dir0 failed\n");
    exit();
  }
  printf(stdout, "mkdir test ok\n");
     957:	c7 44 24 04 b1 41 00 	movl   $0x41b1,0x4(%esp)
     95e:	00 
     95f:	a1 20 5f 00 00       	mov    0x5f20,%eax
     964:	89 04 24             	mov    %eax,(%esp)
     967:	e8 10 32 00 00       	call   3b7c <printf>
}
     96c:	c9                   	leave  
     96d:	c3                   	ret    
void dirtest(void)
{
  printf(stdout, "mkdir test\n");

  if(mkdir("dir0") < 0){
    printf(stdout, "mkdir failed\n");
     96e:	c7 44 24 04 a4 3e 00 	movl   $0x3ea4,0x4(%esp)
     975:	00 
     976:	a1 20 5f 00 00       	mov    0x5f20,%eax
     97b:	89 04 24             	mov    %eax,(%esp)
     97e:	e8 f9 31 00 00       	call   3b7c <printf>
    exit();
     983:	e8 c0 30 00 00       	call   3a48 <exit>
    printf(stdout, "chdir .. failed\n");
    exit();
  }

  if(unlink("dir0") < 0){
    printf(stdout, "unlink dir0 failed\n");
     988:	c7 44 24 04 9d 41 00 	movl   $0x419d,0x4(%esp)
     98f:	00 
     990:	a1 20 5f 00 00       	mov    0x5f20,%eax
     995:	89 04 24             	mov    %eax,(%esp)
     998:	e8 df 31 00 00       	call   3b7c <printf>
    exit();
     99d:	e8 a6 30 00 00       	call   3a48 <exit>
    printf(stdout, "chdir dir0 failed\n");
    exit();
  }

  if(chdir("..") < 0){
    printf(stdout, "chdir .. failed\n");
     9a2:	c7 44 24 04 8c 41 00 	movl   $0x418c,0x4(%esp)
     9a9:	00 
     9aa:	a1 20 5f 00 00       	mov    0x5f20,%eax
     9af:	89 04 24             	mov    %eax,(%esp)
     9b2:	e8 c5 31 00 00       	call   3b7c <printf>
    exit();
     9b7:	e8 8c 30 00 00       	call   3a48 <exit>
    printf(stdout, "mkdir failed\n");
    exit();
  }

  if(chdir("dir0") < 0){
    printf(stdout, "chdir dir0 failed\n");
     9bc:	c7 44 24 04 79 41 00 	movl   $0x4179,0x4(%esp)
     9c3:	00 
     9c4:	a1 20 5f 00 00       	mov    0x5f20,%eax
     9c9:	89 04 24             	mov    %eax,(%esp)
     9cc:	e8 ab 31 00 00       	call   3b7c <printf>
    exit();
     9d1:	e8 72 30 00 00       	call   3a48 <exit>
     9d6:	66 90                	xchg   %ax,%ax

000009d8 <exectest>:
  printf(stdout, "mkdir test ok\n");
}

void
exectest(void)
{
     9d8:	55                   	push   %ebp
     9d9:	89 e5                	mov    %esp,%ebp
     9db:	83 ec 18             	sub    $0x18,%esp
  printf(stdout, "exec test\n");
     9de:	c7 44 24 04 c0 41 00 	movl   $0x41c0,0x4(%esp)
     9e5:	00 
     9e6:	a1 20 5f 00 00       	mov    0x5f20,%eax
     9eb:	89 04 24             	mov    %eax,(%esp)
     9ee:	e8 89 31 00 00       	call   3b7c <printf>
  if(exec("echo", echoargv) < 0){
     9f3:	c7 44 24 04 24 5f 00 	movl   $0x5f24,0x4(%esp)
     9fa:	00 
     9fb:	c7 04 24 89 3f 00 00 	movl   $0x3f89,(%esp)
     a02:	e8 79 30 00 00       	call   3a80 <exec>
     a07:	85 c0                	test   %eax,%eax
     a09:	78 02                	js     a0d <exectest+0x35>
    printf(stdout, "exec echo failed\n");
    exit();
  }
}
     a0b:	c9                   	leave  
     a0c:	c3                   	ret    
void
exectest(void)
{
  printf(stdout, "exec test\n");
  if(exec("echo", echoargv) < 0){
    printf(stdout, "exec echo failed\n");
     a0d:	c7 44 24 04 cb 41 00 	movl   $0x41cb,0x4(%esp)
     a14:	00 
     a15:	a1 20 5f 00 00       	mov    0x5f20,%eax
     a1a:	89 04 24             	mov    %eax,(%esp)
     a1d:	e8 5a 31 00 00       	call   3b7c <printf>
    exit();
     a22:	e8 21 30 00 00       	call   3a48 <exit>
     a27:	90                   	nop

00000a28 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     a28:	55                   	push   %ebp
     a29:	89 e5                	mov    %esp,%ebp
     a2b:	57                   	push   %edi
     a2c:	56                   	push   %esi
     a2d:	53                   	push   %ebx
     a2e:	83 ec 2c             	sub    $0x2c,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     a31:	8d 45 e0             	lea    -0x20(%ebp),%eax
     a34:	89 04 24             	mov    %eax,(%esp)
     a37:	e8 1c 30 00 00       	call   3a58 <pipe>
     a3c:	85 c0                	test   %eax,%eax
     a3e:	0f 85 48 01 00 00    	jne    b8c <pipe1+0x164>
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
     a44:	e8 f7 2f 00 00       	call   3a40 <fork>
  seq = 0;
  if(pid == 0){
     a49:	83 f8 00             	cmp    $0x0,%eax
     a4c:	0f 84 8e 00 00 00    	je     ae0 <pipe1+0xb8>
        printf(1, "pipe1 oops 1\n");
        exit();
      }
    }
    exit();
  } else if(pid > 0){
     a52:	0f 8e 4d 01 00 00    	jle    ba5 <pipe1+0x17d>
    close(fds[1]);
     a58:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     a5b:	89 04 24             	mov    %eax,(%esp)
     a5e:	e8 0d 30 00 00       	call   3a70 <close>
    total = 0;
     a63:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
    cc = 1;
     a6a:	bf 01 00 00 00       	mov    $0x1,%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     a6f:	31 db                	xor    %ebx,%ebx
    exit();
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
     a71:	89 7c 24 08          	mov    %edi,0x8(%esp)
     a75:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     a7c:	00 
     a7d:	8b 45 e0             	mov    -0x20(%ebp),%eax
     a80:	89 04 24             	mov    %eax,(%esp)
     a83:	e8 d8 2f 00 00       	call   3a60 <read>
     a88:	85 c0                	test   %eax,%eax
     a8a:	0f 8e ad 00 00 00    	jle    b3d <pipe1+0x115>
     a90:	8d 34 03             	lea    (%ebx,%eax,1),%esi
     a93:	89 d9                	mov    %ebx,%ecx
     a95:	f7 d9                	neg    %ecx
     a97:	eb 05                	jmp    a9e <pipe1+0x76>
     a99:	8d 76 00             	lea    0x0(%esi),%esi
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     a9c:	89 d3                	mov    %edx,%ebx
     a9e:	8d 53 01             	lea    0x1(%ebx),%edx
     aa1:	38 9c 0b 00 87 00 00 	cmp    %bl,0x8700(%ebx,%ecx,1)
     aa8:	75 1a                	jne    ac4 <pipe1+0x9c>
  } else if(pid > 0){
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
     aaa:	39 f2                	cmp    %esi,%edx
     aac:	75 ee                	jne    a9c <pipe1+0x74>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
          printf(1, "pipe1 oops 2\n");
          return;
        }
      }
      total += n;
     aae:	01 45 d4             	add    %eax,-0x2c(%ebp)
      cc = cc * 2;
     ab1:	01 ff                	add    %edi,%edi
      if(cc > sizeof(buf))
     ab3:	81 ff 00 20 00 00    	cmp    $0x2000,%edi
     ab9:	76 05                	jbe    ac0 <pipe1+0x98>
        cc = sizeof(buf);
     abb:	bf 00 20 00 00       	mov    $0x2000,%edi
    close(fds[1]);
    total = 0;
    cc = 1;
    while((n = read(fds[0], buf, cc)) > 0){
      for(i = 0; i < n; i++){
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     ac0:	89 d3                	mov    %edx,%ebx
     ac2:	eb ad                	jmp    a71 <pipe1+0x49>
          printf(1, "pipe1 oops 2\n");
     ac4:	c7 44 24 04 fa 41 00 	movl   $0x41fa,0x4(%esp)
     acb:	00 
     acc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ad3:	e8 a4 30 00 00       	call   3b7c <printf>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
}
     ad8:	83 c4 2c             	add    $0x2c,%esp
     adb:	5b                   	pop    %ebx
     adc:	5e                   	pop    %esi
     add:	5f                   	pop    %edi
     ade:	5d                   	pop    %ebp
     adf:	c3                   	ret    
    exit();
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
     ae0:	8b 45 e0             	mov    -0x20(%ebp),%eax
     ae3:	89 04 24             	mov    %eax,(%esp)
     ae6:	e8 85 2f 00 00       	call   3a70 <close>
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  pid = fork();
  seq = 0;
     aeb:	31 f6                	xor    %esi,%esi
     aed:	8d 96 09 04 00 00    	lea    0x409(%esi),%edx

// simple fork and pipe read/write

void
pipe1(void)
{
     af3:	89 f3                	mov    %esi,%ebx
     af5:	89 f0                	mov    %esi,%eax
     af7:	f7 d8                	neg    %eax
     af9:	8d 76 00             	lea    0x0(%esi),%esi
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
     afc:	88 9c 18 00 87 00 00 	mov    %bl,0x8700(%eax,%ebx,1)
     b03:	43                   	inc    %ebx
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
     b04:	39 d3                	cmp    %edx,%ebx
     b06:	75 f4                	jne    afc <pipe1+0xd4>
     b08:	89 de                	mov    %ebx,%esi
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
     b0a:	c7 44 24 08 09 04 00 	movl   $0x409,0x8(%esp)
     b11:	00 
     b12:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     b19:	00 
     b1a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     b1d:	89 04 24             	mov    %eax,(%esp)
     b20:	e8 43 2f 00 00       	call   3a68 <write>
     b25:	3d 09 04 00 00       	cmp    $0x409,%eax
     b2a:	0f 85 8e 00 00 00    	jne    bbe <pipe1+0x196>
  }
  pid = fork();
  seq = 0;
  if(pid == 0){
    close(fds[0]);
    for(n = 0; n < 5; n++){
     b30:	81 fb 2d 14 00 00    	cmp    $0x142d,%ebx
     b36:	75 b5                	jne    aed <pipe1+0xc5>
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
     b38:	e8 0b 2f 00 00       	call   3a48 <exit>
      total += n;
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
     b3d:	81 7d d4 2d 14 00 00 	cmpl   $0x142d,-0x2c(%ebp)
     b44:	75 29                	jne    b6f <pipe1+0x147>
      printf(1, "pipe1 oops 3 total %d\n", total);
      exit();
    }
    close(fds[0]);
     b46:	8b 45 e0             	mov    -0x20(%ebp),%eax
     b49:	89 04 24             	mov    %eax,(%esp)
     b4c:	e8 1f 2f 00 00       	call   3a70 <close>
    wait();
     b51:	e8 fa 2e 00 00       	call   3a50 <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b56:	c7 44 24 04 1f 42 00 	movl   $0x421f,0x4(%esp)
     b5d:	00 
     b5e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b65:	e8 12 30 00 00       	call   3b7c <printf>
     b6a:	e9 69 ff ff ff       	jmp    ad8 <pipe1+0xb0>
      cc = cc * 2;
      if(cc > sizeof(buf))
        cc = sizeof(buf);
    }
    if(total != 5 * 1033){
      printf(1, "pipe1 oops 3 total %d\n", total);
     b6f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     b72:	89 44 24 08          	mov    %eax,0x8(%esp)
     b76:	c7 44 24 04 08 42 00 	movl   $0x4208,0x4(%esp)
     b7d:	00 
     b7e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b85:	e8 f2 2f 00 00       	call   3b7c <printf>
     b8a:	eb ac                	jmp    b38 <pipe1+0x110>
{
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
     b8c:	c7 44 24 04 dd 41 00 	movl   $0x41dd,0x4(%esp)
     b93:	00 
     b94:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     b9b:	e8 dc 2f 00 00       	call   3b7c <printf>
    exit();
     ba0:	e8 a3 2e 00 00       	call   3a48 <exit>
      exit();
    }
    close(fds[0]);
    wait();
  } else {
    printf(1, "fork() failed\n");
     ba5:	c7 44 24 04 29 42 00 	movl   $0x4229,0x4(%esp)
     bac:	00 
     bad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bb4:	e8 c3 2f 00 00       	call   3b7c <printf>
    exit();
     bb9:	e8 8a 2e 00 00       	call   3a48 <exit>
    close(fds[0]);
    for(n = 0; n < 5; n++){
      for(i = 0; i < 1033; i++)
        buf[i] = seq++;
      if(write(fds[1], buf, 1033) != 1033){
        printf(1, "pipe1 oops 1\n");
     bbe:	c7 44 24 04 ec 41 00 	movl   $0x41ec,0x4(%esp)
     bc5:	00 
     bc6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bcd:	e8 aa 2f 00 00       	call   3b7c <printf>
        exit();
     bd2:	e8 71 2e 00 00       	call   3a48 <exit>
     bd7:	90                   	nop

00000bd8 <preempt>:
}

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     bd8:	55                   	push   %ebp
     bd9:	89 e5                	mov    %esp,%ebp
     bdb:	57                   	push   %edi
     bdc:	56                   	push   %esi
     bdd:	53                   	push   %ebx
     bde:	83 ec 2c             	sub    $0x2c,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     be1:	c7 44 24 04 38 42 00 	movl   $0x4238,0x4(%esp)
     be8:	00 
     be9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     bf0:	e8 87 2f 00 00       	call   3b7c <printf>
  pid1 = fork();
     bf5:	e8 46 2e 00 00       	call   3a40 <fork>
     bfa:	89 c7                	mov    %eax,%edi
  if(pid1 == 0)
     bfc:	85 c0                	test   %eax,%eax
     bfe:	75 02                	jne    c02 <preempt+0x2a>
     c00:	eb fe                	jmp    c00 <preempt+0x28>
    for(;;)
      ;

  pid2 = fork();
     c02:	e8 39 2e 00 00       	call   3a40 <fork>
     c07:	89 c6                	mov    %eax,%esi
  if(pid2 == 0)
     c09:	85 c0                	test   %eax,%eax
     c0b:	75 02                	jne    c0f <preempt+0x37>
     c0d:	eb fe                	jmp    c0d <preempt+0x35>
    for(;;)
      ;

  pipe(pfds);
     c0f:	8d 45 e0             	lea    -0x20(%ebp),%eax
     c12:	89 04 24             	mov    %eax,(%esp)
     c15:	e8 3e 2e 00 00       	call   3a58 <pipe>
  pid3 = fork();
     c1a:	e8 21 2e 00 00       	call   3a40 <fork>
     c1f:	89 c3                	mov    %eax,%ebx
  if(pid3 == 0){
     c21:	85 c0                	test   %eax,%eax
     c23:	75 4a                	jne    c6f <preempt+0x97>
    close(pfds[0]);
     c25:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c28:	89 04 24             	mov    %eax,(%esp)
     c2b:	e8 40 2e 00 00       	call   3a70 <close>
    if(write(pfds[1], "x", 1) != 1)
     c30:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     c37:	00 
     c38:	c7 44 24 04 fd 47 00 	movl   $0x47fd,0x4(%esp)
     c3f:	00 
     c40:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c43:	89 04 24             	mov    %eax,(%esp)
     c46:	e8 1d 2e 00 00       	call   3a68 <write>
     c4b:	48                   	dec    %eax
     c4c:	74 14                	je     c62 <preempt+0x8a>
      printf(1, "preempt write error");
     c4e:	c7 44 24 04 42 42 00 	movl   $0x4242,0x4(%esp)
     c55:	00 
     c56:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     c5d:	e8 1a 2f 00 00       	call   3b7c <printf>
    close(pfds[1]);
     c62:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c65:	89 04 24             	mov    %eax,(%esp)
     c68:	e8 03 2e 00 00       	call   3a70 <close>
     c6d:	eb fe                	jmp    c6d <preempt+0x95>
    for(;;)
      ;
  }

  close(pfds[1]);
     c6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c72:	89 04 24             	mov    %eax,(%esp)
     c75:	e8 f6 2d 00 00       	call   3a70 <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c7a:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
     c81:	00 
     c82:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
     c89:	00 
     c8a:	8b 45 e0             	mov    -0x20(%ebp),%eax
     c8d:	89 04 24             	mov    %eax,(%esp)
     c90:	e8 cb 2d 00 00       	call   3a60 <read>
     c95:	48                   	dec    %eax
     c96:	74 1c                	je     cb4 <preempt+0xdc>
    printf(1, "preempt read error");
     c98:	c7 44 24 04 56 42 00 	movl   $0x4256,0x4(%esp)
     c9f:	00 
     ca0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     ca7:	e8 d0 2e 00 00       	call   3b7c <printf>
  printf(1, "wait... ");
  wait();
  wait();
  wait();
  printf(1, "preempt ok\n");
}
     cac:	83 c4 2c             	add    $0x2c,%esp
     caf:	5b                   	pop    %ebx
     cb0:	5e                   	pop    %esi
     cb1:	5f                   	pop    %edi
     cb2:	5d                   	pop    %ebp
     cb3:	c3                   	ret    
  close(pfds[1]);
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    printf(1, "preempt read error");
    return;
  }
  close(pfds[0]);
     cb4:	8b 45 e0             	mov    -0x20(%ebp),%eax
     cb7:	89 04 24             	mov    %eax,(%esp)
     cba:	e8 b1 2d 00 00       	call   3a70 <close>
  printf(1, "kill... ");
     cbf:	c7 44 24 04 69 42 00 	movl   $0x4269,0x4(%esp)
     cc6:	00 
     cc7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cce:	e8 a9 2e 00 00       	call   3b7c <printf>
  kill(pid1);
     cd3:	89 3c 24             	mov    %edi,(%esp)
     cd6:	e8 9d 2d 00 00       	call   3a78 <kill>
  kill(pid2);
     cdb:	89 34 24             	mov    %esi,(%esp)
     cde:	e8 95 2d 00 00       	call   3a78 <kill>
  kill(pid3);
     ce3:	89 1c 24             	mov    %ebx,(%esp)
     ce6:	e8 8d 2d 00 00       	call   3a78 <kill>
  printf(1, "wait... ");
     ceb:	c7 44 24 04 72 42 00 	movl   $0x4272,0x4(%esp)
     cf2:	00 
     cf3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     cfa:	e8 7d 2e 00 00       	call   3b7c <printf>
  wait();
     cff:	e8 4c 2d 00 00       	call   3a50 <wait>
  wait();
     d04:	e8 47 2d 00 00       	call   3a50 <wait>
  wait();
     d09:	e8 42 2d 00 00       	call   3a50 <wait>
  printf(1, "preempt ok\n");
     d0e:	c7 44 24 04 7b 42 00 	movl   $0x427b,0x4(%esp)
     d15:	00 
     d16:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d1d:	e8 5a 2e 00 00       	call   3b7c <printf>
     d22:	eb 88                	jmp    cac <preempt+0xd4>

00000d24 <exitwait>:
}

// try to find any races between exit and wait
void
exitwait(void)
{
     d24:	55                   	push   %ebp
     d25:	89 e5                	mov    %esp,%ebp
     d27:	56                   	push   %esi
     d28:	53                   	push   %ebx
     d29:	83 ec 10             	sub    $0x10,%esp
     d2c:	be 64 00 00 00       	mov    $0x64,%esi
     d31:	eb 0f                	jmp    d42 <exitwait+0x1e>
     d33:	90                   	nop
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
     d34:	74 69                	je     d9f <exitwait+0x7b>
      if(wait() != pid){
     d36:	e8 15 2d 00 00       	call   3a50 <wait>
     d3b:	39 d8                	cmp    %ebx,%eax
     d3d:	75 29                	jne    d68 <exitwait+0x44>
void
exitwait(void)
{
  int i, pid;

  for(i = 0; i < 100; i++){
     d3f:	4e                   	dec    %esi
     d40:	74 42                	je     d84 <exitwait+0x60>
    pid = fork();
     d42:	e8 f9 2c 00 00       	call   3a40 <fork>
     d47:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
     d49:	85 c0                	test   %eax,%eax
     d4b:	79 e7                	jns    d34 <exitwait+0x10>
      printf(1, "fork failed\n");
     d4d:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
     d54:	00 
     d55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d5c:	e8 1b 2e 00 00       	call   3b7c <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d61:	83 c4 10             	add    $0x10,%esp
     d64:	5b                   	pop    %ebx
     d65:	5e                   	pop    %esi
     d66:	5d                   	pop    %ebp
     d67:	c3                   	ret    
      printf(1, "fork failed\n");
      return;
    }
    if(pid){
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
     d68:	c7 44 24 04 87 42 00 	movl   $0x4287,0x4(%esp)
     d6f:	00 
     d70:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d77:	e8 00 2e 00 00       	call   3b7c <printf>
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
}
     d7c:	83 c4 10             	add    $0x10,%esp
     d7f:	5b                   	pop    %ebx
     d80:	5e                   	pop    %esi
     d81:	5d                   	pop    %ebp
     d82:	c3                   	ret    
     d83:	90                   	nop
      }
    } else {
      exit();
    }
  }
  printf(1, "exitwait ok\n");
     d84:	c7 44 24 04 97 42 00 	movl   $0x4297,0x4(%esp)
     d8b:	00 
     d8c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     d93:	e8 e4 2d 00 00       	call   3b7c <printf>
}
     d98:	83 c4 10             	add    $0x10,%esp
     d9b:	5b                   	pop    %ebx
     d9c:	5e                   	pop    %esi
     d9d:	5d                   	pop    %ebp
     d9e:	c3                   	ret    
      if(wait() != pid){
        printf(1, "wait wrong pid\n");
        return;
      }
    } else {
      exit();
     d9f:	e8 a4 2c 00 00       	call   3a48 <exit>

00000da4 <mem>:
  printf(1, "exitwait ok\n");
}

void
mem(void)
{
     da4:	55                   	push   %ebp
     da5:	89 e5                	mov    %esp,%ebp
     da7:	57                   	push   %edi
     da8:	56                   	push   %esi
     da9:	53                   	push   %ebx
     daa:	83 ec 1c             	sub    $0x1c,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     dad:	c7 44 24 04 a4 42 00 	movl   $0x42a4,0x4(%esp)
     db4:	00 
     db5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     dbc:	e8 bb 2d 00 00       	call   3b7c <printf>
  ppid = getpid();
     dc1:	e8 02 2d 00 00       	call   3ac8 <getpid>
     dc6:	89 c6                	mov    %eax,%esi
  if((pid = fork()) == 0){
     dc8:	e8 73 2c 00 00       	call   3a40 <fork>
     dcd:	85 c0                	test   %eax,%eax
     dcf:	75 67                	jne    e38 <mem+0x94>
     dd1:	31 db                	xor    %ebx,%ebx
     dd3:	eb 07                	jmp    ddc <mem+0x38>
     dd5:	8d 76 00             	lea    0x0(%esi),%esi
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
     dd8:	89 18                	mov    %ebx,(%eax)
     dda:	89 c3                	mov    %eax,%ebx

  printf(1, "mem test\n");
  ppid = getpid();
  if((pid = fork()) == 0){
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
     ddc:	c7 04 24 11 27 00 00 	movl   $0x2711,(%esp)
     de3:	e8 e0 2f 00 00       	call   3dc8 <malloc>
     de8:	85 c0                	test   %eax,%eax
     dea:	75 ec                	jne    dd8 <mem+0x34>
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     dec:	85 db                	test   %ebx,%ebx
     dee:	75 06                	jne    df6 <mem+0x52>
     df0:	eb 12                	jmp    e04 <mem+0x60>
     df2:	66 90                	xchg   %ax,%ax
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
     df4:	89 fb                	mov    %edi,%ebx
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
      m2 = *(char**)m1;
     df6:	8b 3b                	mov    (%ebx),%edi
      free(m1);
     df8:	89 1c 24             	mov    %ebx,(%esp)
     dfb:	e8 48 2f 00 00       	call   3d48 <free>
    m1 = 0;
    while((m2 = malloc(10001)) != 0){
      *(char**)m2 = m1;
      m1 = m2;
    }
    while(m1){
     e00:	85 ff                	test   %edi,%edi
     e02:	75 f0                	jne    df4 <mem+0x50>
      m2 = *(char**)m1;
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
     e04:	c7 04 24 00 50 00 00 	movl   $0x5000,(%esp)
     e0b:	e8 b8 2f 00 00       	call   3dc8 <malloc>
    if(m1 == 0){
     e10:	85 c0                	test   %eax,%eax
     e12:	74 30                	je     e44 <mem+0xa0>
      printf(1, "couldn't allocate mem?!!\n");
      kill(ppid);
      exit();
    }
    free(m1);
     e14:	89 04 24             	mov    %eax,(%esp)
     e17:	e8 2c 2f 00 00       	call   3d48 <free>
    printf(1, "mem ok\n");
     e1c:	c7 44 24 04 c8 42 00 	movl   $0x42c8,0x4(%esp)
     e23:	00 
     e24:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e2b:	e8 4c 2d 00 00       	call   3b7c <printf>
    exit();
     e30:	e8 13 2c 00 00       	call   3a48 <exit>
     e35:	8d 76 00             	lea    0x0(%esi),%esi
  } else {
    wait();
  }
}
     e38:	83 c4 1c             	add    $0x1c,%esp
     e3b:	5b                   	pop    %ebx
     e3c:	5e                   	pop    %esi
     e3d:	5f                   	pop    %edi
     e3e:	5d                   	pop    %ebp
    }
    free(m1);
    printf(1, "mem ok\n");
    exit();
  } else {
    wait();
     e3f:	e9 0c 2c 00 00       	jmp    3a50 <wait>
      free(m1);
      m1 = m2;
    }
    m1 = malloc(1024*20);
    if(m1 == 0){
      printf(1, "couldn't allocate mem?!!\n");
     e44:	c7 44 24 04 ae 42 00 	movl   $0x42ae,0x4(%esp)
     e4b:	00 
     e4c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e53:	e8 24 2d 00 00       	call   3b7c <printf>
      kill(ppid);
     e58:	89 34 24             	mov    %esi,(%esp)
     e5b:	e8 18 2c 00 00       	call   3a78 <kill>
      exit();
     e60:	e8 e3 2b 00 00       	call   3a48 <exit>
     e65:	8d 76 00             	lea    0x0(%esi),%esi

00000e68 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e68:	55                   	push   %ebp
     e69:	89 e5                	mov    %esp,%ebp
     e6b:	57                   	push   %edi
     e6c:	56                   	push   %esi
     e6d:	53                   	push   %ebx
     e6e:	83 ec 3c             	sub    $0x3c,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e71:	c7 44 24 04 d0 42 00 	movl   $0x42d0,0x4(%esp)
     e78:	00 
     e79:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     e80:	e8 f7 2c 00 00       	call   3b7c <printf>

  unlink("sharedfd");
     e85:	c7 04 24 df 42 00 00 	movl   $0x42df,(%esp)
     e8c:	e8 07 2c 00 00       	call   3a98 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e91:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
     e98:	00 
     e99:	c7 04 24 df 42 00 00 	movl   $0x42df,(%esp)
     ea0:	e8 e3 2b 00 00       	call   3a88 <open>
     ea5:	89 c7                	mov    %eax,%edi
  if(fd < 0){
     ea7:	85 c0                	test   %eax,%eax
     ea9:	0f 88 2c 01 00 00    	js     fdb <sharedfd+0x173>
    printf(1, "fstests: cannot open sharedfd for writing");
    return;
  }
  pid = fork();
     eaf:	e8 8c 2b 00 00       	call   3a40 <fork>
     eb4:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     eb7:	83 f8 01             	cmp    $0x1,%eax
     eba:	19 c0                	sbb    %eax,%eax
     ebc:	83 e0 f3             	and    $0xfffffff3,%eax
     ebf:	83 c0 70             	add    $0x70,%eax
     ec2:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     ec9:	00 
     eca:	89 44 24 04          	mov    %eax,0x4(%esp)
     ece:	8d 75 de             	lea    -0x22(%ebp),%esi
     ed1:	89 34 24             	mov    %esi,(%esp)
     ed4:	e8 2f 2a 00 00       	call   3908 <memset>
     ed9:	bb e8 03 00 00       	mov    $0x3e8,%ebx
     ede:	eb 03                	jmp    ee3 <sharedfd+0x7b>
  for(i = 0; i < 1000; i++){
     ee0:	4b                   	dec    %ebx
     ee1:	74 2d                	je     f10 <sharedfd+0xa8>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     ee3:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     eea:	00 
     eeb:	89 74 24 04          	mov    %esi,0x4(%esp)
     eef:	89 3c 24             	mov    %edi,(%esp)
     ef2:	e8 71 2b 00 00       	call   3a68 <write>
     ef7:	83 f8 0a             	cmp    $0xa,%eax
     efa:	74 e4                	je     ee0 <sharedfd+0x78>
      printf(1, "fstests: write sharedfd failed\n");
     efc:	c7 44 24 04 d0 4f 00 	movl   $0x4fd0,0x4(%esp)
     f03:	00 
     f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f0b:	e8 6c 2c 00 00       	call   3b7c <printf>
      break;
    }
  }
  if(pid == 0)
     f10:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f13:	85 c0                	test   %eax,%eax
     f15:	0f 84 14 01 00 00    	je     102f <sharedfd+0x1c7>
    exit();
  else
    wait();
     f1b:	e8 30 2b 00 00       	call   3a50 <wait>
  close(fd);
     f20:	89 3c 24             	mov    %edi,(%esp)
     f23:	e8 48 2b 00 00       	call   3a70 <close>
  fd = open("sharedfd", 0);
     f28:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     f2f:	00 
     f30:	c7 04 24 df 42 00 00 	movl   $0x42df,(%esp)
     f37:	e8 4c 2b 00 00       	call   3a88 <open>
     f3c:	89 45 d0             	mov    %eax,-0x30(%ebp)
  if(fd < 0){
     f3f:	85 c0                	test   %eax,%eax
     f41:	0f 88 b0 00 00 00    	js     ff7 <sharedfd+0x18f>
     f47:	31 ff                	xor    %edi,%edi
     f49:	8d 5d e8             	lea    -0x18(%ebp),%ebx
     f4c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
     f4f:	90                   	nop
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f50:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
     f57:	00 
     f58:	89 74 24 04          	mov    %esi,0x4(%esp)
     f5c:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f5f:	89 04 24             	mov    %eax,(%esp)
     f62:	e8 f9 2a 00 00       	call   3a60 <read>
     f67:	85 c0                	test   %eax,%eax
     f69:	7e 24                	jle    f8f <sharedfd+0x127>
     f6b:	89 f1                	mov    %esi,%ecx
     f6d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     f70:	eb 0c                	jmp    f7e <sharedfd+0x116>
     f72:	66 90                	xchg   %ax,%ax
    for(i = 0; i < sizeof(buf); i++){
      if(buf[i] == 'c')
        nc++;
      if(buf[i] == 'p')
     f74:	3c 70                	cmp    $0x70,%al
     f76:	75 01                	jne    f79 <sharedfd+0x111>
        np++;
     f78:	47                   	inc    %edi
     f79:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     f7a:	39 d9                	cmp    %ebx,%ecx
     f7c:	74 0c                	je     f8a <sharedfd+0x122>
      if(buf[i] == 'c')
     f7e:	8a 01                	mov    (%ecx),%al
     f80:	3c 63                	cmp    $0x63,%al
     f82:	75 f0                	jne    f74 <sharedfd+0x10c>
        nc++;
     f84:	42                   	inc    %edx
     f85:	41                   	inc    %ecx
    printf(1, "fstests: cannot open sharedfd for reading\n");
    return;
  }
  nc = np = 0;
  while((n = read(fd, buf, sizeof(buf))) > 0){
    for(i = 0; i < sizeof(buf); i++){
     f86:	39 d9                	cmp    %ebx,%ecx
     f88:	75 f4                	jne    f7e <sharedfd+0x116>
     f8a:	89 55 d4             	mov    %edx,-0x2c(%ebp)
     f8d:	eb c1                	jmp    f50 <sharedfd+0xe8>
     f8f:	89 7d cc             	mov    %edi,-0x34(%ebp)
     f92:	8b 7d d4             	mov    -0x2c(%ebp),%edi
        nc++;
      if(buf[i] == 'p')
        np++;
    }
  }
  close(fd);
     f95:	8b 45 d0             	mov    -0x30(%ebp),%eax
     f98:	89 04 24             	mov    %eax,(%esp)
     f9b:	e8 d0 2a 00 00       	call   3a70 <close>
  unlink("sharedfd");
     fa0:	c7 04 24 df 42 00 00 	movl   $0x42df,(%esp)
     fa7:	e8 ec 2a 00 00       	call   3a98 <unlink>
  if(nc == 10000 && np == 10000){
     fac:	81 ff 10 27 00 00    	cmp    $0x2710,%edi
     fb2:	8b 55 cc             	mov    -0x34(%ebp),%edx
     fb5:	75 5c                	jne    1013 <sharedfd+0x1ab>
     fb7:	81 fa 10 27 00 00    	cmp    $0x2710,%edx
     fbd:	75 54                	jne    1013 <sharedfd+0x1ab>
    printf(1, "sharedfd ok\n");
     fbf:	c7 44 24 04 e8 42 00 	movl   $0x42e8,0x4(%esp)
     fc6:	00 
     fc7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fce:	e8 a9 2b 00 00       	call   3b7c <printf>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fd3:	83 c4 3c             	add    $0x3c,%esp
     fd6:	5b                   	pop    %ebx
     fd7:	5e                   	pop    %esi
     fd8:	5f                   	pop    %edi
     fd9:	5d                   	pop    %ebp
     fda:	c3                   	ret    
  printf(1, "sharedfd test\n");

  unlink("sharedfd");
  fd = open("sharedfd", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for writing");
     fdb:	c7 44 24 04 a4 4f 00 	movl   $0x4fa4,0x4(%esp)
     fe2:	00 
     fe3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     fea:	e8 8d 2b 00 00       	call   3b7c <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
     fef:	83 c4 3c             	add    $0x3c,%esp
     ff2:	5b                   	pop    %ebx
     ff3:	5e                   	pop    %esi
     ff4:	5f                   	pop    %edi
     ff5:	5d                   	pop    %ebp
     ff6:	c3                   	ret    
  else
    wait();
  close(fd);
  fd = open("sharedfd", 0);
  if(fd < 0){
    printf(1, "fstests: cannot open sharedfd for reading\n");
     ff7:	c7 44 24 04 f0 4f 00 	movl   $0x4ff0,0x4(%esp)
     ffe:	00 
     fff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1006:	e8 71 2b 00 00       	call   3b7c <printf>
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    exit();
  }
}
    100b:	83 c4 3c             	add    $0x3c,%esp
    100e:	5b                   	pop    %ebx
    100f:	5e                   	pop    %esi
    1010:	5f                   	pop    %edi
    1011:	5d                   	pop    %ebp
    1012:	c3                   	ret    
  close(fd);
  unlink("sharedfd");
  if(nc == 10000 && np == 10000){
    printf(1, "sharedfd ok\n");
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    1013:	89 54 24 0c          	mov    %edx,0xc(%esp)
    1017:	89 7c 24 08          	mov    %edi,0x8(%esp)
    101b:	c7 44 24 04 f5 42 00 	movl   $0x42f5,0x4(%esp)
    1022:	00 
    1023:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    102a:	e8 4d 2b 00 00       	call   3b7c <printf>
    exit();
    102f:	e8 14 2a 00 00       	call   3a48 <exit>

00001034 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1034:	55                   	push   %ebp
    1035:	89 e5                	mov    %esp,%ebp
    1037:	57                   	push   %edi
    1038:	56                   	push   %esi
    1039:	53                   	push   %ebx
    103a:	83 ec 2c             	sub    $0x2c,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    103d:	be 3c 56 00 00       	mov    $0x563c,%esi
    1042:	b9 04 00 00 00       	mov    $0x4,%ecx
    1047:	8d 7d d8             	lea    -0x28(%ebp),%edi
    104a:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  char *fname;

  printf(1, "fourfiles test\n");
    104c:	c7 44 24 04 0a 43 00 	movl   $0x430a,0x4(%esp)
    1053:	00 
    1054:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    105b:	e8 1c 2b 00 00       	call   3b7c <printf>

  for(pi = 0; pi < 4; pi++){
    1060:	31 db                	xor    %ebx,%ebx
    fname = names[pi];
    1062:	8b 74 9d d8          	mov    -0x28(%ebp,%ebx,4),%esi
    unlink(fname);
    1066:	89 34 24             	mov    %esi,(%esp)
    1069:	e8 2a 2a 00 00       	call   3a98 <unlink>

    pid = fork();
    106e:	e8 cd 29 00 00       	call   3a40 <fork>
    if(pid < 0){
    1073:	85 c0                	test   %eax,%eax
    1075:	0f 88 6d 01 00 00    	js     11e8 <fourfiles+0x1b4>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    107b:	0f 84 cd 00 00 00    	je     114e <fourfiles+0x11a>
  char *names[] = { "f0", "f1", "f2", "f3" };
  char *fname;

  printf(1, "fourfiles test\n");

  for(pi = 0; pi < 4; pi++){
    1081:	43                   	inc    %ebx
    1082:	83 fb 04             	cmp    $0x4,%ebx
    1085:	75 db                	jne    1062 <fourfiles+0x2e>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1087:	e8 c4 29 00 00       	call   3a50 <wait>
    108c:	e8 bf 29 00 00       	call   3a50 <wait>
    1091:	e8 ba 29 00 00       	call   3a50 <wait>
    1096:	e8 b5 29 00 00       	call   3a50 <wait>
    109b:	bf 30 00 00 00       	mov    $0x30,%edi
  }

  for(i = 0; i < 2; i++){
    fname = names[i];
    10a0:	8b 84 bd 18 ff ff ff 	mov    -0xe8(%ebp,%edi,4),%eax
    10a7:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    fd = open(fname, 0);
    10aa:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    10b1:	00 
    10b2:	89 04 24             	mov    %eax,(%esp)
    10b5:	e8 ce 29 00 00       	call   3a88 <open>
    10ba:	89 c3                	mov    %eax,%ebx
    total = 0;
    10bc:	31 f6                	xor    %esi,%esi
    10be:	66 90                	xchg   %ax,%ax
    while((n = read(fd, buf, sizeof(buf))) > 0){
    10c0:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    10c7:	00 
    10c8:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    10cf:	00 
    10d0:	89 1c 24             	mov    %ebx,(%esp)
    10d3:	e8 88 29 00 00       	call   3a60 <read>
    10d8:	85 c0                	test   %eax,%eax
    10da:	7e 18                	jle    10f4 <fourfiles+0xc0>
    10dc:	31 d2                	xor    %edx,%edx
    10de:	66 90                	xchg   %ax,%ax
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
    10e0:	0f be 8a 00 87 00 00 	movsbl 0x8700(%edx),%ecx
    10e7:	39 f9                	cmp    %edi,%ecx
    10e9:	75 4a                	jne    1135 <fourfiles+0x101>
  for(i = 0; i < 2; i++){
    fname = names[i];
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
    10eb:	42                   	inc    %edx
    10ec:	39 c2                	cmp    %eax,%edx
    10ee:	75 f0                	jne    10e0 <fourfiles+0xac>
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
          exit();
        }
      }
      total += n;
    10f0:	01 d6                	add    %edx,%esi
    10f2:	eb cc                	jmp    10c0 <fourfiles+0x8c>
    }
    close(fd);
    10f4:	89 1c 24             	mov    %ebx,(%esp)
    10f7:	e8 74 29 00 00       	call   3a70 <close>
    if(total != 12*500){
    10fc:	81 fe 70 17 00 00    	cmp    $0x1770,%esi
    1102:	0f 85 c3 00 00 00    	jne    11cb <fourfiles+0x197>
      printf(1, "wrong length %d\n", total);
      exit();
    }
    unlink(fname);
    1108:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    110b:	89 04 24             	mov    %eax,(%esp)
    110e:	e8 85 29 00 00       	call   3a98 <unlink>
    1113:	47                   	inc    %edi

  for(pi = 0; pi < 4; pi++){
    wait();
  }

  for(i = 0; i < 2; i++){
    1114:	83 ff 32             	cmp    $0x32,%edi
    1117:	75 87                	jne    10a0 <fourfiles+0x6c>
      exit();
    }
    unlink(fname);
  }

  printf(1, "fourfiles ok\n");
    1119:	c7 44 24 04 48 43 00 	movl   $0x4348,0x4(%esp)
    1120:	00 
    1121:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1128:	e8 4f 2a 00 00       	call   3b7c <printf>
}
    112d:	83 c4 2c             	add    $0x2c,%esp
    1130:	5b                   	pop    %ebx
    1131:	5e                   	pop    %esi
    1132:	5f                   	pop    %edi
    1133:	5d                   	pop    %ebp
    1134:	c3                   	ret    
    fd = open(fname, 0);
    total = 0;
    while((n = read(fd, buf, sizeof(buf))) > 0){
      for(j = 0; j < n; j++){
        if(buf[j] != '0'+i){
          printf(1, "wrong char\n");
    1135:	c7 44 24 04 2b 43 00 	movl   $0x432b,0x4(%esp)
    113c:	00 
    113d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1144:	e8 33 2a 00 00       	call   3b7c <printf>
          exit();
    1149:	e8 fa 28 00 00       	call   3a48 <exit>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
    114e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1155:	00 
    1156:	89 34 24             	mov    %esi,(%esp)
    1159:	e8 2a 29 00 00       	call   3a88 <open>
    115e:	89 c6                	mov    %eax,%esi
      if(fd < 0){
    1160:	85 c0                	test   %eax,%eax
    1162:	0f 88 99 00 00 00    	js     1201 <fourfiles+0x1cd>
        printf(1, "create failed\n");
        exit();
      }

      memset(buf, '0'+pi, 512);
    1168:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    116f:	00 
    1170:	83 c3 30             	add    $0x30,%ebx
    1173:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    1177:	c7 04 24 00 87 00 00 	movl   $0x8700,(%esp)
    117e:	e8 85 27 00 00       	call   3908 <memset>
    1183:	bb 0c 00 00 00       	mov    $0xc,%ebx
    1188:	eb 05                	jmp    118f <fourfiles+0x15b>
    118a:	66 90                	xchg   %ax,%ax
      for(i = 0; i < 12; i++){
    118c:	4b                   	dec    %ebx
    118d:	74 ba                	je     1149 <fourfiles+0x115>
        if((n = write(fd, buf, 500)) != 500){
    118f:	c7 44 24 08 f4 01 00 	movl   $0x1f4,0x8(%esp)
    1196:	00 
    1197:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    119e:	00 
    119f:	89 34 24             	mov    %esi,(%esp)
    11a2:	e8 c1 28 00 00       	call   3a68 <write>
    11a7:	3d f4 01 00 00       	cmp    $0x1f4,%eax
    11ac:	74 de                	je     118c <fourfiles+0x158>
          printf(1, "write failed %d\n", n);
    11ae:	89 44 24 08          	mov    %eax,0x8(%esp)
    11b2:	c7 44 24 04 1a 43 00 	movl   $0x431a,0x4(%esp)
    11b9:	00 
    11ba:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11c1:	e8 b6 29 00 00       	call   3b7c <printf>
          exit();
    11c6:	e8 7d 28 00 00       	call   3a48 <exit>
      }
      total += n;
    }
    close(fd);
    if(total != 12*500){
      printf(1, "wrong length %d\n", total);
    11cb:	89 74 24 08          	mov    %esi,0x8(%esp)
    11cf:	c7 44 24 04 37 43 00 	movl   $0x4337,0x4(%esp)
    11d6:	00 
    11d7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11de:	e8 99 29 00 00       	call   3b7c <printf>
      exit();
    11e3:	e8 60 28 00 00       	call   3a48 <exit>
    fname = names[pi];
    unlink(fname);

    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    11e8:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    11ef:	00 
    11f0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    11f7:	e8 80 29 00 00       	call   3b7c <printf>
      exit();
    11fc:	e8 47 28 00 00       	call   3a48 <exit>
    }

    if(pid == 0){
      fd = open(fname, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "create failed\n");
    1201:	c7 44 24 04 ab 45 00 	movl   $0x45ab,0x4(%esp)
    1208:	00 
    1209:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1210:	e8 67 29 00 00       	call   3b7c <printf>
        exit();
    1215:	e8 2e 28 00 00       	call   3a48 <exit>
    121a:	66 90                	xchg   %ax,%ax

0000121c <createdelete>:
}

// four processes create and delete different files in same directory
void
createdelete(void)
{
    121c:	55                   	push   %ebp
    121d:	89 e5                	mov    %esp,%ebp
    121f:	57                   	push   %edi
    1220:	56                   	push   %esi
    1221:	53                   	push   %ebx
    1222:	83 ec 4c             	sub    $0x4c,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    1225:	c7 44 24 04 5c 43 00 	movl   $0x435c,0x4(%esp)
    122c:	00 
    122d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1234:	e8 43 29 00 00       	call   3b7c <printf>

  for(pi = 0; pi < 4; pi++){
    1239:	31 db                	xor    %ebx,%ebx
    pid = fork();
    123b:	e8 00 28 00 00       	call   3a40 <fork>
    if(pid < 0){
    1240:	85 c0                	test   %eax,%eax
    1242:	0f 88 95 01 00 00    	js     13dd <createdelete+0x1c1>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
    1248:	0f 84 e0 00 00 00    	je     132e <createdelete+0x112>
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    124e:	43                   	inc    %ebx
    124f:	83 fb 04             	cmp    $0x4,%ebx
    1252:	75 e7                	jne    123b <createdelete+0x1f>
      exit();
    }
  }

  for(pi = 0; pi < 4; pi++){
    wait();
    1254:	e8 f7 27 00 00       	call   3a50 <wait>
    1259:	e8 f2 27 00 00       	call   3a50 <wait>
    125e:	e8 ed 27 00 00       	call   3a50 <wait>
    1263:	e8 e8 27 00 00       	call   3a50 <wait>
  }

  name[0] = name[1] = name[2] = 0;
    1268:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
  for(i = 0; i < N; i++){
    126c:	31 f6                	xor    %esi,%esi
    126e:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1271:	8d 76 00             	lea    0x0(%esi),%esi
    1274:	8d 46 30             	lea    0x30(%esi),%eax
    1277:	88 45 c7             	mov    %al,-0x39(%ebp)
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
    127a:	b3 70                	mov    $0x70,%bl
    127c:	8d 46 ff             	lea    -0x1(%esi),%eax
    127f:	89 45 c0             	mov    %eax,-0x40(%ebp)
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
    1282:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    1285:	8a 45 c7             	mov    -0x39(%ebp),%al
    1288:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    128b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1292:	00 
    1293:	89 3c 24             	mov    %edi,(%esp)
    1296:	e8 ed 27 00 00       	call   3a88 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    129b:	85 f6                	test   %esi,%esi
    129d:	74 05                	je     12a4 <createdelete+0x88>
    129f:	83 fe 09             	cmp    $0x9,%esi
    12a2:	7e 6c                	jle    1310 <createdelete+0xf4>
    12a4:	85 c0                	test   %eax,%eax
    12a6:	0f 88 cc 00 00 00    	js     1378 <createdelete+0x15c>
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    12ac:	83 7d c0 08          	cmpl   $0x8,-0x40(%ebp)
    12b0:	0f 86 40 01 00 00    	jbe    13f6 <createdelete+0x1da>
        printf(1, "oops createdelete %s did exist\n", name);
        exit();
      }
      if(fd >= 0)
        close(fd);
    12b6:	89 04 24             	mov    %eax,(%esp)
    12b9:	e8 b2 27 00 00       	call   3a70 <close>
    12be:	43                   	inc    %ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    12bf:	80 fb 74             	cmp    $0x74,%bl
    12c2:	75 be                	jne    1282 <createdelete+0x66>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    12c4:	46                   	inc    %esi
    12c5:	83 fe 14             	cmp    $0x14,%esi
    12c8:	75 aa                	jne    1274 <createdelete+0x58>
    12ca:	b3 70                	mov    $0x70,%bl
    12cc:	8d 43 c0             	lea    -0x40(%ebx),%eax
    12cf:	88 45 c7             	mov    %al,-0x39(%ebp)
    12d2:	be 04 00 00 00       	mov    $0x4,%esi
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + i;
    12d7:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[1] = '0' + i;
    12da:	8a 45 c7             	mov    -0x39(%ebp),%al
    12dd:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    12e0:	89 3c 24             	mov    %edi,(%esp)
    12e3:	e8 b0 27 00 00       	call   3a98 <unlink>
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    12e8:	4e                   	dec    %esi
    12e9:	75 ec                	jne    12d7 <createdelete+0xbb>
    12eb:	43                   	inc    %ebx
      if(fd >= 0)
        close(fd);
    }
  }

  for(i = 0; i < N; i++){
    12ec:	80 fb 84             	cmp    $0x84,%bl
    12ef:	75 db                	jne    12cc <createdelete+0xb0>
      name[1] = '0' + i;
      unlink(name);
    }
  }

  printf(1, "createdelete ok\n");
    12f1:	c7 44 24 04 6f 43 00 	movl   $0x436f,0x4(%esp)
    12f8:	00 
    12f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1300:	e8 77 28 00 00       	call   3b7c <printf>
}
    1305:	83 c4 4c             	add    $0x4c,%esp
    1308:	5b                   	pop    %ebx
    1309:	5e                   	pop    %esi
    130a:	5f                   	pop    %edi
    130b:	5d                   	pop    %ebp
    130c:	c3                   	ret    
    130d:	8d 76 00             	lea    0x0(%esi),%esi
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1310:	85 c0                	test   %eax,%eax
    1312:	0f 89 de 00 00 00    	jns    13f6 <createdelete+0x1da>
    1318:	43                   	inc    %ebx
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    for(pi = 0; pi < 4; pi++){
    1319:	80 fb 74             	cmp    $0x74,%bl
    131c:	0f 85 60 ff ff ff    	jne    1282 <createdelete+0x66>
  for(pi = 0; pi < 4; pi++){
    wait();
  }

  name[0] = name[1] = name[2] = 0;
  for(i = 0; i < N; i++){
    1322:	46                   	inc    %esi
    1323:	83 fe 14             	cmp    $0x14,%esi
    1326:	0f 85 48 ff ff ff    	jne    1274 <createdelete+0x58>
    132c:	eb 9c                	jmp    12ca <createdelete+0xae>
      printf(1, "fork failed\n");
      exit();
    }

    if(pid == 0){
      name[0] = 'p' + pi;
    132e:	83 c3 70             	add    $0x70,%ebx
    1331:	88 5d c8             	mov    %bl,-0x38(%ebp)
      name[2] = '\0';
    1334:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    1338:	be 01 00 00 00       	mov    $0x1,%esi
    133d:	31 db                	xor    %ebx,%ebx
    133f:	8d 7d c8             	lea    -0x38(%ebp),%edi
    1342:	66 90                	xchg   %ax,%ax
    1344:	8d 43 30             	lea    0x30(%ebx),%eax
    1347:	88 45 c9             	mov    %al,-0x37(%ebp)
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
    134a:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1351:	00 
    1352:	89 3c 24             	mov    %edi,(%esp)
    1355:	e8 2e 27 00 00       	call   3a88 <open>
        if(fd < 0){
    135a:	85 c0                	test   %eax,%eax
    135c:	78 66                	js     13c4 <createdelete+0x1a8>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
    135e:	89 04 24             	mov    %eax,(%esp)
    1361:	e8 0a 27 00 00       	call   3a70 <close>
        if(i > 0 && (i % 2 ) == 0){
    1366:	85 db                	test   %ebx,%ebx
    1368:	74 0a                	je     1374 <createdelete+0x158>
    136a:	f6 c3 01             	test   $0x1,%bl
    136d:	74 26                	je     1395 <createdelete+0x179>
    }

    if(pid == 0){
      name[0] = 'p' + pi;
      name[2] = '\0';
      for(i = 0; i < N; i++){
    136f:	83 fe 14             	cmp    $0x14,%esi
    1372:	74 1c                	je     1390 <createdelete+0x174>
    1374:	43                   	inc    %ebx
    1375:	46                   	inc    %esi
    1376:	eb cc                	jmp    1344 <createdelete+0x128>
    for(pi = 0; pi < 4; pi++){
      name[0] = 'p' + pi;
      name[1] = '0' + i;
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
    1378:	89 7c 24 08          	mov    %edi,0x8(%esp)
    137c:	c7 44 24 04 1c 50 00 	movl   $0x501c,0x4(%esp)
    1383:	00 
    1384:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    138b:	e8 ec 27 00 00       	call   3b7c <printf>
        exit();
    1390:	e8 b3 26 00 00       	call   3a48 <exit>
          printf(1, "create failed\n");
          exit();
        }
        close(fd);
        if(i > 0 && (i % 2 ) == 0){
          name[1] = '0' + (i / 2);
    1395:	89 d8                	mov    %ebx,%eax
    1397:	d1 f8                	sar    %eax
    1399:	83 c0 30             	add    $0x30,%eax
    139c:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    139f:	89 3c 24             	mov    %edi,(%esp)
    13a2:	e8 f1 26 00 00       	call   3a98 <unlink>
    13a7:	85 c0                	test   %eax,%eax
    13a9:	79 c4                	jns    136f <createdelete+0x153>
            printf(1, "unlink failed\n");
    13ab:	c7 44 24 04 5d 3f 00 	movl   $0x3f5d,0x4(%esp)
    13b2:	00 
    13b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13ba:	e8 bd 27 00 00       	call   3b7c <printf>
            exit();
    13bf:	e8 84 26 00 00       	call   3a48 <exit>
      name[2] = '\0';
      for(i = 0; i < N; i++){
        name[1] = '0' + i;
        fd = open(name, O_CREATE | O_RDWR);
        if(fd < 0){
          printf(1, "create failed\n");
    13c4:	c7 44 24 04 ab 45 00 	movl   $0x45ab,0x4(%esp)
    13cb:	00 
    13cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13d3:	e8 a4 27 00 00       	call   3b7c <printf>
          exit();
    13d8:	e8 6b 26 00 00       	call   3a48 <exit>
  printf(1, "createdelete test\n");

  for(pi = 0; pi < 4; pi++){
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    13dd:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    13e4:	00 
    13e5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    13ec:	e8 8b 27 00 00       	call   3b7c <printf>
      exit();
    13f1:	e8 52 26 00 00       	call   3a48 <exit>
      fd = open(name, 0);
      if((i == 0 || i >= N/2) && fd < 0){
        printf(1, "oops createdelete %s didn't exist\n", name);
        exit();
      } else if((i >= 1 && i < N/2) && fd >= 0){
        printf(1, "oops createdelete %s did exist\n", name);
    13f6:	89 7c 24 08          	mov    %edi,0x8(%esp)
    13fa:	c7 44 24 04 40 50 00 	movl   $0x5040,0x4(%esp)
    1401:	00 
    1402:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1409:	e8 6e 27 00 00       	call   3b7c <printf>
        exit();
    140e:	e8 35 26 00 00       	call   3a48 <exit>
    1413:	90                   	nop

00001414 <unlinkread>:
}

// can I unlink a file and still read it?
void
unlinkread(void)
{
    1414:	55                   	push   %ebp
    1415:	89 e5                	mov    %esp,%ebp
    1417:	56                   	push   %esi
    1418:	53                   	push   %ebx
    1419:	83 ec 10             	sub    $0x10,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    141c:	c7 44 24 04 80 43 00 	movl   $0x4380,0x4(%esp)
    1423:	00 
    1424:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    142b:	e8 4c 27 00 00       	call   3b7c <printf>
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1430:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1437:	00 
    1438:	c7 04 24 91 43 00 00 	movl   $0x4391,(%esp)
    143f:	e8 44 26 00 00       	call   3a88 <open>
    1444:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1446:	85 c0                	test   %eax,%eax
    1448:	0f 88 fe 00 00 00    	js     154c <unlinkread+0x138>
    printf(1, "create unlinkread failed\n");
    exit();
  }
  write(fd, "hello", 5);
    144e:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    1455:	00 
    1456:	c7 44 24 04 b6 43 00 	movl   $0x43b6,0x4(%esp)
    145d:	00 
    145e:	89 04 24             	mov    %eax,(%esp)
    1461:	e8 02 26 00 00       	call   3a68 <write>
  close(fd);
    1466:	89 1c 24             	mov    %ebx,(%esp)
    1469:	e8 02 26 00 00       	call   3a70 <close>

  fd = open("unlinkread", O_RDWR);
    146e:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1475:	00 
    1476:	c7 04 24 91 43 00 00 	movl   $0x4391,(%esp)
    147d:	e8 06 26 00 00       	call   3a88 <open>
    1482:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1484:	85 c0                	test   %eax,%eax
    1486:	0f 88 3d 01 00 00    	js     15c9 <unlinkread+0x1b5>
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    148c:	c7 04 24 91 43 00 00 	movl   $0x4391,(%esp)
    1493:	e8 00 26 00 00       	call   3a98 <unlink>
    1498:	85 c0                	test   %eax,%eax
    149a:	0f 85 10 01 00 00    	jne    15b0 <unlinkread+0x19c>
    printf(1, "unlink unlinkread failed\n");
    exit();
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    14a0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    14a7:	00 
    14a8:	c7 04 24 91 43 00 00 	movl   $0x4391,(%esp)
    14af:	e8 d4 25 00 00       	call   3a88 <open>
    14b4:	89 c6                	mov    %eax,%esi
  write(fd1, "yyy", 3);
    14b6:	c7 44 24 08 03 00 00 	movl   $0x3,0x8(%esp)
    14bd:	00 
    14be:	c7 44 24 04 ee 43 00 	movl   $0x43ee,0x4(%esp)
    14c5:	00 
    14c6:	89 04 24             	mov    %eax,(%esp)
    14c9:	e8 9a 25 00 00       	call   3a68 <write>
  close(fd1);
    14ce:	89 34 24             	mov    %esi,(%esp)
    14d1:	e8 9a 25 00 00       	call   3a70 <close>

  if(read(fd, buf, sizeof(buf)) != 5){
    14d6:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    14dd:	00 
    14de:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    14e5:	00 
    14e6:	89 1c 24             	mov    %ebx,(%esp)
    14e9:	e8 72 25 00 00       	call   3a60 <read>
    14ee:	83 f8 05             	cmp    $0x5,%eax
    14f1:	0f 85 a0 00 00 00    	jne    1597 <unlinkread+0x183>
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    14f7:	80 3d 00 87 00 00 68 	cmpb   $0x68,0x8700
    14fe:	75 7e                	jne    157e <unlinkread+0x16a>
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    1500:	c7 44 24 08 0a 00 00 	movl   $0xa,0x8(%esp)
    1507:	00 
    1508:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    150f:	00 
    1510:	89 1c 24             	mov    %ebx,(%esp)
    1513:	e8 50 25 00 00       	call   3a68 <write>
    1518:	83 f8 0a             	cmp    $0xa,%eax
    151b:	75 48                	jne    1565 <unlinkread+0x151>
    printf(1, "unlinkread write failed\n");
    exit();
  }
  close(fd);
    151d:	89 1c 24             	mov    %ebx,(%esp)
    1520:	e8 4b 25 00 00       	call   3a70 <close>
  unlink("unlinkread");
    1525:	c7 04 24 91 43 00 00 	movl   $0x4391,(%esp)
    152c:	e8 67 25 00 00       	call   3a98 <unlink>
  printf(1, "unlinkread ok\n");
    1531:	c7 44 24 04 39 44 00 	movl   $0x4439,0x4(%esp)
    1538:	00 
    1539:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1540:	e8 37 26 00 00       	call   3b7c <printf>
}
    1545:	83 c4 10             	add    $0x10,%esp
    1548:	5b                   	pop    %ebx
    1549:	5e                   	pop    %esi
    154a:	5d                   	pop    %ebp
    154b:	c3                   	ret    
  int fd, fd1;

  printf(1, "unlinkread test\n");
  fd = open("unlinkread", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create unlinkread failed\n");
    154c:	c7 44 24 04 9c 43 00 	movl   $0x439c,0x4(%esp)
    1553:	00 
    1554:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    155b:	e8 1c 26 00 00       	call   3b7c <printf>
    exit();
    1560:	e8 e3 24 00 00       	call   3a48 <exit>
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    exit();
  }
  if(write(fd, buf, 10) != 10){
    printf(1, "unlinkread write failed\n");
    1565:	c7 44 24 04 20 44 00 	movl   $0x4420,0x4(%esp)
    156c:	00 
    156d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1574:	e8 03 26 00 00       	call   3b7c <printf>
    exit();
    1579:	e8 ca 24 00 00       	call   3a48 <exit>
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    exit();
  }
  if(buf[0] != 'h'){
    printf(1, "unlinkread wrong data\n");
    157e:	c7 44 24 04 09 44 00 	movl   $0x4409,0x4(%esp)
    1585:	00 
    1586:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    158d:	e8 ea 25 00 00       	call   3b7c <printf>
    exit();
    1592:	e8 b1 24 00 00       	call   3a48 <exit>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
  write(fd1, "yyy", 3);
  close(fd1);

  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "unlinkread read failed");
    1597:	c7 44 24 04 f2 43 00 	movl   $0x43f2,0x4(%esp)
    159e:	00 
    159f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15a6:	e8 d1 25 00 00       	call   3b7c <printf>
    exit();
    15ab:	e8 98 24 00 00       	call   3a48 <exit>
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    exit();
  }
  if(unlink("unlinkread") != 0){
    printf(1, "unlink unlinkread failed\n");
    15b0:	c7 44 24 04 d4 43 00 	movl   $0x43d4,0x4(%esp)
    15b7:	00 
    15b8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15bf:	e8 b8 25 00 00       	call   3b7c <printf>
    exit();
    15c4:	e8 7f 24 00 00       	call   3a48 <exit>
  write(fd, "hello", 5);
  close(fd);

  fd = open("unlinkread", O_RDWR);
  if(fd < 0){
    printf(1, "open unlinkread failed\n");
    15c9:	c7 44 24 04 bc 43 00 	movl   $0x43bc,0x4(%esp)
    15d0:	00 
    15d1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15d8:	e8 9f 25 00 00       	call   3b7c <printf>
    exit();
    15dd:	e8 66 24 00 00       	call   3a48 <exit>
    15e2:	66 90                	xchg   %ax,%ax

000015e4 <linktest>:
  printf(1, "unlinkread ok\n");
}

void
linktest(void)
{
    15e4:	55                   	push   %ebp
    15e5:	89 e5                	mov    %esp,%ebp
    15e7:	53                   	push   %ebx
    15e8:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "linktest\n");
    15eb:	c7 44 24 04 48 44 00 	movl   $0x4448,0x4(%esp)
    15f2:	00 
    15f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    15fa:	e8 7d 25 00 00       	call   3b7c <printf>

  unlink("lf1");
    15ff:	c7 04 24 52 44 00 00 	movl   $0x4452,(%esp)
    1606:	e8 8d 24 00 00       	call   3a98 <unlink>
  unlink("lf2");
    160b:	c7 04 24 56 44 00 00 	movl   $0x4456,(%esp)
    1612:	e8 81 24 00 00       	call   3a98 <unlink>

  fd = open("lf1", O_CREATE|O_RDWR);
    1617:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    161e:	00 
    161f:	c7 04 24 52 44 00 00 	movl   $0x4452,(%esp)
    1626:	e8 5d 24 00 00       	call   3a88 <open>
    162b:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    162d:	85 c0                	test   %eax,%eax
    162f:	0f 88 26 01 00 00    	js     175b <linktest+0x177>
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    1635:	c7 44 24 08 05 00 00 	movl   $0x5,0x8(%esp)
    163c:	00 
    163d:	c7 44 24 04 b6 43 00 	movl   $0x43b6,0x4(%esp)
    1644:	00 
    1645:	89 04 24             	mov    %eax,(%esp)
    1648:	e8 1b 24 00 00       	call   3a68 <write>
    164d:	83 f8 05             	cmp    $0x5,%eax
    1650:	0f 85 cd 01 00 00    	jne    1823 <linktest+0x23f>
    printf(1, "write lf1 failed\n");
    exit();
  }
  close(fd);
    1656:	89 1c 24             	mov    %ebx,(%esp)
    1659:	e8 12 24 00 00       	call   3a70 <close>

  if(link("lf1", "lf2") < 0){
    165e:	c7 44 24 04 56 44 00 	movl   $0x4456,0x4(%esp)
    1665:	00 
    1666:	c7 04 24 52 44 00 00 	movl   $0x4452,(%esp)
    166d:	e8 36 24 00 00       	call   3aa8 <link>
    1672:	85 c0                	test   %eax,%eax
    1674:	0f 88 90 01 00 00    	js     180a <linktest+0x226>
    printf(1, "link lf1 lf2 failed\n");
    exit();
  }
  unlink("lf1");
    167a:	c7 04 24 52 44 00 00 	movl   $0x4452,(%esp)
    1681:	e8 12 24 00 00       	call   3a98 <unlink>

  if(open("lf1", 0) >= 0){
    1686:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    168d:	00 
    168e:	c7 04 24 52 44 00 00 	movl   $0x4452,(%esp)
    1695:	e8 ee 23 00 00       	call   3a88 <open>
    169a:	85 c0                	test   %eax,%eax
    169c:	0f 89 4f 01 00 00    	jns    17f1 <linktest+0x20d>
    printf(1, "unlinked lf1 but it is still there!\n");
    exit();
  }

  fd = open("lf2", 0);
    16a2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    16a9:	00 
    16aa:	c7 04 24 56 44 00 00 	movl   $0x4456,(%esp)
    16b1:	e8 d2 23 00 00       	call   3a88 <open>
    16b6:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    16b8:	85 c0                	test   %eax,%eax
    16ba:	0f 88 18 01 00 00    	js     17d8 <linktest+0x1f4>
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    16c0:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    16c7:	00 
    16c8:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    16cf:	00 
    16d0:	89 04 24             	mov    %eax,(%esp)
    16d3:	e8 88 23 00 00       	call   3a60 <read>
    16d8:	83 f8 05             	cmp    $0x5,%eax
    16db:	0f 85 de 00 00 00    	jne    17bf <linktest+0x1db>
    printf(1, "read lf2 failed\n");
    exit();
  }
  close(fd);
    16e1:	89 1c 24             	mov    %ebx,(%esp)
    16e4:	e8 87 23 00 00       	call   3a70 <close>

  if(link("lf2", "lf2") >= 0){
    16e9:	c7 44 24 04 56 44 00 	movl   $0x4456,0x4(%esp)
    16f0:	00 
    16f1:	c7 04 24 56 44 00 00 	movl   $0x4456,(%esp)
    16f8:	e8 ab 23 00 00       	call   3aa8 <link>
    16fd:	85 c0                	test   %eax,%eax
    16ff:	0f 89 a1 00 00 00    	jns    17a6 <linktest+0x1c2>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    exit();
  }

  unlink("lf2");
    1705:	c7 04 24 56 44 00 00 	movl   $0x4456,(%esp)
    170c:	e8 87 23 00 00       	call   3a98 <unlink>
  if(link("lf2", "lf1") >= 0){
    1711:	c7 44 24 04 52 44 00 	movl   $0x4452,0x4(%esp)
    1718:	00 
    1719:	c7 04 24 56 44 00 00 	movl   $0x4456,(%esp)
    1720:	e8 83 23 00 00       	call   3aa8 <link>
    1725:	85 c0                	test   %eax,%eax
    1727:	79 64                	jns    178d <linktest+0x1a9>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    1729:	c7 44 24 04 52 44 00 	movl   $0x4452,0x4(%esp)
    1730:	00 
    1731:	c7 04 24 1a 47 00 00 	movl   $0x471a,(%esp)
    1738:	e8 6b 23 00 00       	call   3aa8 <link>
    173d:	85 c0                	test   %eax,%eax
    173f:	79 33                	jns    1774 <linktest+0x190>
    printf(1, "link . lf1 succeeded! oops\n");
    exit();
  }

  printf(1, "linktest ok\n");
    1741:	c7 44 24 04 f0 44 00 	movl   $0x44f0,0x4(%esp)
    1748:	00 
    1749:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1750:	e8 27 24 00 00       	call   3b7c <printf>
}
    1755:	83 c4 14             	add    $0x14,%esp
    1758:	5b                   	pop    %ebx
    1759:	5d                   	pop    %ebp
    175a:	c3                   	ret    
  unlink("lf1");
  unlink("lf2");

  fd = open("lf1", O_CREATE|O_RDWR);
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    175b:	c7 44 24 04 5a 44 00 	movl   $0x445a,0x4(%esp)
    1762:	00 
    1763:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    176a:	e8 0d 24 00 00       	call   3b7c <printf>
    exit();
    176f:	e8 d4 22 00 00       	call   3a48 <exit>
    printf(1, "link non-existant succeeded! oops\n");
    exit();
  }

  if(link(".", "lf1") >= 0){
    printf(1, "link . lf1 succeeded! oops\n");
    1774:	c7 44 24 04 d4 44 00 	movl   $0x44d4,0x4(%esp)
    177b:	00 
    177c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1783:	e8 f4 23 00 00       	call   3b7c <printf>
    exit();
    1788:	e8 bb 22 00 00       	call   3a48 <exit>
    exit();
  }

  unlink("lf2");
  if(link("lf2", "lf1") >= 0){
    printf(1, "link non-existant succeeded! oops\n");
    178d:	c7 44 24 04 88 50 00 	movl   $0x5088,0x4(%esp)
    1794:	00 
    1795:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    179c:	e8 db 23 00 00       	call   3b7c <printf>
    exit();
    17a1:	e8 a2 22 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);

  if(link("lf2", "lf2") >= 0){
    printf(1, "link lf2 lf2 succeeded! oops\n");
    17a6:	c7 44 24 04 b6 44 00 	movl   $0x44b6,0x4(%esp)
    17ad:	00 
    17ae:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17b5:	e8 c2 23 00 00       	call   3b7c <printf>
    exit();
    17ba:	e8 89 22 00 00       	call   3a48 <exit>
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    printf(1, "read lf2 failed\n");
    17bf:	c7 44 24 04 a5 44 00 	movl   $0x44a5,0x4(%esp)
    17c6:	00 
    17c7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17ce:	e8 a9 23 00 00       	call   3b7c <printf>
    exit();
    17d3:	e8 70 22 00 00       	call   3a48 <exit>
    exit();
  }

  fd = open("lf2", 0);
  if(fd < 0){
    printf(1, "open lf2 failed\n");
    17d8:	c7 44 24 04 94 44 00 	movl   $0x4494,0x4(%esp)
    17df:	00 
    17e0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    17e7:	e8 90 23 00 00       	call   3b7c <printf>
    exit();
    17ec:	e8 57 22 00 00       	call   3a48 <exit>
    exit();
  }
  unlink("lf1");

  if(open("lf1", 0) >= 0){
    printf(1, "unlinked lf1 but it is still there!\n");
    17f1:	c7 44 24 04 60 50 00 	movl   $0x5060,0x4(%esp)
    17f8:	00 
    17f9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1800:	e8 77 23 00 00       	call   3b7c <printf>
    exit();
    1805:	e8 3e 22 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);

  if(link("lf1", "lf2") < 0){
    printf(1, "link lf1 lf2 failed\n");
    180a:	c7 44 24 04 7f 44 00 	movl   $0x447f,0x4(%esp)
    1811:	00 
    1812:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1819:	e8 5e 23 00 00       	call   3b7c <printf>
    exit();
    181e:	e8 25 22 00 00       	call   3a48 <exit>
  if(fd < 0){
    printf(1, "create lf1 failed\n");
    exit();
  }
  if(write(fd, "hello", 5) != 5){
    printf(1, "write lf1 failed\n");
    1823:	c7 44 24 04 6d 44 00 	movl   $0x446d,0x4(%esp)
    182a:	00 
    182b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1832:	e8 45 23 00 00       	call   3b7c <printf>
    exit();
    1837:	e8 0c 22 00 00       	call   3a48 <exit>

0000183c <concreate>:
}

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    183c:	55                   	push   %ebp
    183d:	89 e5                	mov    %esp,%ebp
    183f:	57                   	push   %edi
    1840:	56                   	push   %esi
    1841:	53                   	push   %ebx
    1842:	83 ec 5c             	sub    $0x5c,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1845:	c7 44 24 04 fd 44 00 	movl   $0x44fd,0x4(%esp)
    184c:	00 
    184d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1854:	e8 23 23 00 00       	call   3b7c <printf>
  file[0] = 'C';
    1859:	c6 45 ad 43          	movb   $0x43,-0x53(%ebp)
  file[2] = '\0';
    185d:	c6 45 af 00          	movb   $0x0,-0x51(%ebp)
  for(i = 0; i < 40; i++){
    1861:	31 db                	xor    %ebx,%ebx
    1863:	8d 75 ad             	lea    -0x53(%ebp),%esi
    1866:	eb 3a                	jmp    18a2 <concreate+0x66>
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
    1868:	b9 03 00 00 00       	mov    $0x3,%ecx
    186d:	99                   	cltd   
    186e:	f7 f9                	idiv   %ecx
    1870:	4a                   	dec    %edx
    1871:	74 6d                	je     18e0 <concreate+0xa4>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    1873:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    187a:	00 
    187b:	89 34 24             	mov    %esi,(%esp)
    187e:	e8 05 22 00 00       	call   3a88 <open>
      if(fd < 0){
    1883:	85 c0                	test   %eax,%eax
    1885:	0f 88 16 02 00 00    	js     1aa1 <concreate+0x265>
        printf(1, "concreate create %s failed\n", file);
        exit();
      }
      close(fd);
    188b:	89 04 24             	mov    %eax,(%esp)
    188e:	e8 dd 21 00 00       	call   3a70 <close>
    }
    if(pid == 0)
    1893:	85 ff                	test   %edi,%edi
    1895:	74 41                	je     18d8 <concreate+0x9c>
      exit();
    else
      wait();
    1897:	e8 b4 21 00 00       	call   3a50 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    189c:	43                   	inc    %ebx
    189d:	83 fb 28             	cmp    $0x28,%ebx
    18a0:	74 5a                	je     18fc <concreate+0xc0>
    18a2:	8d 43 30             	lea    0x30(%ebx),%eax
    18a5:	88 45 ae             	mov    %al,-0x52(%ebp)
    file[1] = '0' + i;
    unlink(file);
    18a8:	89 34 24             	mov    %esi,(%esp)
    18ab:	e8 e8 21 00 00       	call   3a98 <unlink>
    pid = fork();
    18b0:	e8 8b 21 00 00       	call   3a40 <fork>
    18b5:	89 c7                	mov    %eax,%edi
    if(pid && (i % 3) == 1){
    18b7:	89 d8                	mov    %ebx,%eax
    18b9:	85 ff                	test   %edi,%edi
    18bb:	75 ab                	jne    1868 <concreate+0x2c>
      link("C0", file);
    } else if(pid == 0 && (i % 5) == 1){
    18bd:	b9 05 00 00 00       	mov    $0x5,%ecx
    18c2:	99                   	cltd   
    18c3:	f7 f9                	idiv   %ecx
    18c5:	4a                   	dec    %edx
    18c6:	75 ab                	jne    1873 <concreate+0x37>
      link("C0", file);
    18c8:	89 74 24 04          	mov    %esi,0x4(%esp)
    18cc:	c7 04 24 0d 45 00 00 	movl   $0x450d,(%esp)
    18d3:	e8 d0 21 00 00       	call   3aa8 <link>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
    18d8:	e8 6b 21 00 00       	call   3a48 <exit>
    18dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    unlink(file);
    pid = fork();
    if(pid && (i % 3) == 1){
      link("C0", file);
    18e0:	89 74 24 04          	mov    %esi,0x4(%esp)
    18e4:	c7 04 24 0d 45 00 00 	movl   $0x450d,(%esp)
    18eb:	e8 b8 21 00 00       	call   3aa8 <link>
      close(fd);
    }
    if(pid == 0)
      exit();
    else
      wait();
    18f0:	e8 5b 21 00 00       	call   3a50 <wait>
  } de;

  printf(1, "concreate test\n");
  file[0] = 'C';
  file[2] = '\0';
  for(i = 0; i < 40; i++){
    18f5:	43                   	inc    %ebx
    18f6:	83 fb 28             	cmp    $0x28,%ebx
    18f9:	75 a7                	jne    18a2 <concreate+0x66>
    18fb:	90                   	nop
      exit();
    else
      wait();
  }

  memset(fa, 0, sizeof(fa));
    18fc:	c7 44 24 08 28 00 00 	movl   $0x28,0x8(%esp)
    1903:	00 
    1904:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    190b:	00 
    190c:	8d 45 c0             	lea    -0x40(%ebp),%eax
    190f:	89 04 24             	mov    %eax,(%esp)
    1912:	e8 f1 1f 00 00       	call   3908 <memset>
  fd = open(".", 0);
    1917:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    191e:	00 
    191f:	c7 04 24 1a 47 00 00 	movl   $0x471a,(%esp)
    1926:	e8 5d 21 00 00       	call   3a88 <open>
    192b:	89 c3                	mov    %eax,%ebx
  n = 0;
    192d:	c7 45 a4 00 00 00 00 	movl   $0x0,-0x5c(%ebp)
    1934:	8d 7d b0             	lea    -0x50(%ebp),%edi
    1937:	90                   	nop
  while(read(fd, &de, sizeof(de)) > 0){
    1938:	c7 44 24 08 10 00 00 	movl   $0x10,0x8(%esp)
    193f:	00 
    1940:	89 7c 24 04          	mov    %edi,0x4(%esp)
    1944:	89 1c 24             	mov    %ebx,(%esp)
    1947:	e8 14 21 00 00       	call   3a60 <read>
    194c:	85 c0                	test   %eax,%eax
    194e:	7e 38                	jle    1988 <concreate+0x14c>
    if(de.inum == 0)
    1950:	66 83 7d b0 00       	cmpw   $0x0,-0x50(%ebp)
    1955:	74 e1                	je     1938 <concreate+0xfc>
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1957:	80 7d b2 43          	cmpb   $0x43,-0x4e(%ebp)
    195b:	75 db                	jne    1938 <concreate+0xfc>
    195d:	80 7d b4 00          	cmpb   $0x0,-0x4c(%ebp)
    1961:	75 d5                	jne    1938 <concreate+0xfc>
      i = de.name[1] - '0';
    1963:	0f be 45 b3          	movsbl -0x4d(%ebp),%eax
    1967:	83 e8 30             	sub    $0x30,%eax
      if(i < 0 || i >= sizeof(fa)){
    196a:	83 f8 27             	cmp    $0x27,%eax
    196d:	0f 87 4b 01 00 00    	ja     1abe <concreate+0x282>
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
    1973:	80 7c 05 c0 00       	cmpb   $0x0,-0x40(%ebp,%eax,1)
    1978:	0f 85 79 01 00 00    	jne    1af7 <concreate+0x2bb>
        printf(1, "concreate duplicate file %s\n", de.name);
        exit();
      }
      fa[i] = 1;
    197e:	c6 44 05 c0 01       	movb   $0x1,-0x40(%ebp,%eax,1)
      n++;
    1983:	ff 45 a4             	incl   -0x5c(%ebp)
    1986:	eb b0                	jmp    1938 <concreate+0xfc>
    }
  }
  close(fd);
    1988:	89 1c 24             	mov    %ebx,(%esp)
    198b:	e8 e0 20 00 00       	call   3a70 <close>

  if(n != 40){
    1990:	83 7d a4 28          	cmpl   $0x28,-0x5c(%ebp)
    1994:	0f 85 44 01 00 00    	jne    1ade <concreate+0x2a2>
    199a:	31 db                	xor    %ebx,%ebx
    199c:	eb 7d                	jmp    1a1b <concreate+0x1df>
    199e:	66 90                	xchg   %ax,%ax
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    19a0:	85 ff                	test   %edi,%edi
    19a2:	0f 85 a1 00 00 00    	jne    1a49 <concreate+0x20d>
       ((i % 3) == 1 && pid != 0)){
      close(open(file, 0));
    19a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19af:	00 
    19b0:	89 34 24             	mov    %esi,(%esp)
    19b3:	e8 d0 20 00 00       	call   3a88 <open>
    19b8:	89 04 24             	mov    %eax,(%esp)
    19bb:	e8 b0 20 00 00       	call   3a70 <close>
      close(open(file, 0));
    19c0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19c7:	00 
    19c8:	89 34 24             	mov    %esi,(%esp)
    19cb:	e8 b8 20 00 00       	call   3a88 <open>
    19d0:	89 04 24             	mov    %eax,(%esp)
    19d3:	e8 98 20 00 00       	call   3a70 <close>
      close(open(file, 0));
    19d8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19df:	00 
    19e0:	89 34 24             	mov    %esi,(%esp)
    19e3:	e8 a0 20 00 00       	call   3a88 <open>
    19e8:	89 04 24             	mov    %eax,(%esp)
    19eb:	e8 80 20 00 00       	call   3a70 <close>
      close(open(file, 0));
    19f0:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    19f7:	00 
    19f8:	89 34 24             	mov    %esi,(%esp)
    19fb:	e8 88 20 00 00       	call   3a88 <open>
    1a00:	89 04 24             	mov    %eax,(%esp)
    1a03:	e8 68 20 00 00       	call   3a70 <close>
      unlink(file);
      unlink(file);
      unlink(file);
      unlink(file);
    }
    if(pid == 0)
    1a08:	85 ff                	test   %edi,%edi
    1a0a:	0f 84 c8 fe ff ff    	je     18d8 <concreate+0x9c>
      exit();
    else
      wait();
    1a10:	e8 3b 20 00 00       	call   3a50 <wait>
  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    exit();
  }

  for(i = 0; i < 40; i++){
    1a15:	43                   	inc    %ebx
    1a16:	83 fb 28             	cmp    $0x28,%ebx
    1a19:	74 51                	je     1a6c <concreate+0x230>
    1a1b:	8d 43 30             	lea    0x30(%ebx),%eax
    1a1e:	88 45 ae             	mov    %al,-0x52(%ebp)
    file[1] = '0' + i;
    pid = fork();
    1a21:	e8 1a 20 00 00       	call   3a40 <fork>
    1a26:	89 c7                	mov    %eax,%edi
    if(pid < 0){
    1a28:	85 c0                	test   %eax,%eax
    1a2a:	78 5c                	js     1a88 <concreate+0x24c>
      printf(1, "fork failed\n");
      exit();
    }
    if(((i % 3) == 0 && pid == 0) ||
    1a2c:	89 d8                	mov    %ebx,%eax
    1a2e:	b9 03 00 00 00       	mov    $0x3,%ecx
    1a33:	99                   	cltd   
    1a34:	f7 f9                	idiv   %ecx
    1a36:	85 d2                	test   %edx,%edx
    1a38:	0f 84 62 ff ff ff    	je     19a0 <concreate+0x164>
    1a3e:	4a                   	dec    %edx
    1a3f:	75 08                	jne    1a49 <concreate+0x20d>
       ((i % 3) == 1 && pid != 0)){
    1a41:	85 ff                	test   %edi,%edi
    1a43:	0f 85 5f ff ff ff    	jne    19a8 <concreate+0x16c>
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
      close(open(file, 0));
    } else {
      unlink(file);
    1a49:	89 34 24             	mov    %esi,(%esp)
    1a4c:	e8 47 20 00 00       	call   3a98 <unlink>
      unlink(file);
    1a51:	89 34 24             	mov    %esi,(%esp)
    1a54:	e8 3f 20 00 00       	call   3a98 <unlink>
      unlink(file);
    1a59:	89 34 24             	mov    %esi,(%esp)
    1a5c:	e8 37 20 00 00       	call   3a98 <unlink>
      unlink(file);
    1a61:	89 34 24             	mov    %esi,(%esp)
    1a64:	e8 2f 20 00 00       	call   3a98 <unlink>
    1a69:	eb 9d                	jmp    1a08 <concreate+0x1cc>
    1a6b:	90                   	nop
      exit();
    else
      wait();
  }

  printf(1, "concreate ok\n");
    1a6c:	c7 44 24 04 62 45 00 	movl   $0x4562,0x4(%esp)
    1a73:	00 
    1a74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a7b:	e8 fc 20 00 00       	call   3b7c <printf>
}
    1a80:	83 c4 5c             	add    $0x5c,%esp
    1a83:	5b                   	pop    %ebx
    1a84:	5e                   	pop    %esi
    1a85:	5f                   	pop    %edi
    1a86:	5d                   	pop    %ebp
    1a87:	c3                   	ret    

  for(i = 0; i < 40; i++){
    file[1] = '0' + i;
    pid = fork();
    if(pid < 0){
      printf(1, "fork failed\n");
    1a88:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    1a8f:	00 
    1a90:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1a97:	e8 e0 20 00 00       	call   3b7c <printf>
      exit();
    1a9c:	e8 a7 1f 00 00       	call   3a48 <exit>
    } else if(pid == 0 && (i % 5) == 1){
      link("C0", file);
    } else {
      fd = open(file, O_CREATE | O_RDWR);
      if(fd < 0){
        printf(1, "concreate create %s failed\n", file);
    1aa1:	89 74 24 08          	mov    %esi,0x8(%esp)
    1aa5:	c7 44 24 04 10 45 00 	movl   $0x4510,0x4(%esp)
    1aac:	00 
    1aad:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ab4:	e8 c3 20 00 00       	call   3b7c <printf>
        exit();
    1ab9:	e8 8a 1f 00 00       	call   3a48 <exit>
    if(de.inum == 0)
      continue;
    if(de.name[0] == 'C' && de.name[2] == '\0'){
      i = de.name[1] - '0';
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
    1abe:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1ac1:	89 44 24 08          	mov    %eax,0x8(%esp)
    1ac5:	c7 44 24 04 2c 45 00 	movl   $0x452c,0x4(%esp)
    1acc:	00 
    1acd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1ad4:	e8 a3 20 00 00       	call   3b7c <printf>
    1ad9:	e9 fa fd ff ff       	jmp    18d8 <concreate+0x9c>
    }
  }
  close(fd);

  if(n != 40){
    printf(1, "concreate not enough files in directory listing\n");
    1ade:	c7 44 24 04 ac 50 00 	movl   $0x50ac,0x4(%esp)
    1ae5:	00 
    1ae6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1aed:	e8 8a 20 00 00       	call   3b7c <printf>
    exit();
    1af2:	e8 51 1f 00 00       	call   3a48 <exit>
      if(i < 0 || i >= sizeof(fa)){
        printf(1, "concreate weird file %s\n", de.name);
        exit();
      }
      if(fa[i]){
        printf(1, "concreate duplicate file %s\n", de.name);
    1af7:	8d 45 b2             	lea    -0x4e(%ebp),%eax
    1afa:	89 44 24 08          	mov    %eax,0x8(%esp)
    1afe:	c7 44 24 04 45 45 00 	movl   $0x4545,0x4(%esp)
    1b05:	00 
    1b06:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b0d:	e8 6a 20 00 00       	call   3b7c <printf>
        exit();
    1b12:	e8 31 1f 00 00       	call   3a48 <exit>
    1b17:	90                   	nop

00001b18 <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1b18:	55                   	push   %ebp
    1b19:	89 e5                	mov    %esp,%ebp
    1b1b:	57                   	push   %edi
    1b1c:	56                   	push   %esi
    1b1d:	53                   	push   %ebx
    1b1e:	83 ec 1c             	sub    $0x1c,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1b21:	c7 44 24 04 70 45 00 	movl   $0x4570,0x4(%esp)
    1b28:	00 
    1b29:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1b30:	e8 47 20 00 00       	call   3b7c <printf>

  unlink("x");
    1b35:	c7 04 24 fd 47 00 00 	movl   $0x47fd,(%esp)
    1b3c:	e8 57 1f 00 00       	call   3a98 <unlink>
  pid = fork();
    1b41:	e8 fa 1e 00 00       	call   3a40 <fork>
    1b46:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(pid < 0){
    1b49:	85 c0                	test   %eax,%eax
    1b4b:	0f 88 c0 00 00 00    	js     1c11 <linkunlink+0xf9>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
    1b51:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
    1b55:	19 ff                	sbb    %edi,%edi
    1b57:	83 e7 60             	and    $0x60,%edi
    1b5a:	47                   	inc    %edi
    1b5b:	bb 64 00 00 00       	mov    $0x64,%ebx
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
    1b60:	be 03 00 00 00       	mov    $0x3,%esi
    1b65:	eb 17                	jmp    1b7e <linkunlink+0x66>
    1b67:	90                   	nop
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
    1b68:	4a                   	dec    %edx
    1b69:	0f 84 89 00 00 00    	je     1bf8 <linkunlink+0xe0>
      link("cat", "x");
    } else {
      unlink("x");
    1b6f:	c7 04 24 fd 47 00 00 	movl   $0x47fd,(%esp)
    1b76:	e8 1d 1f 00 00       	call   3a98 <unlink>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1b7b:	4b                   	dec    %ebx
    1b7c:	74 51                	je     1bcf <linkunlink+0xb7>
    x = x * 1103515245 + 12345;
    1b7e:	89 f8                	mov    %edi,%eax
    1b80:	c1 e0 09             	shl    $0x9,%eax
    1b83:	29 f8                	sub    %edi,%eax
    1b85:	8d 14 87             	lea    (%edi,%eax,4),%edx
    1b88:	89 d0                	mov    %edx,%eax
    1b8a:	c1 e0 09             	shl    $0x9,%eax
    1b8d:	29 d0                	sub    %edx,%eax
    1b8f:	01 c0                	add    %eax,%eax
    1b91:	01 f8                	add    %edi,%eax
    1b93:	89 c2                	mov    %eax,%edx
    1b95:	c1 e2 05             	shl    $0x5,%edx
    1b98:	01 d0                	add    %edx,%eax
    1b9a:	c1 e0 02             	shl    $0x2,%eax
    1b9d:	29 f8                	sub    %edi,%eax
    1b9f:	8d bc 87 39 30 00 00 	lea    0x3039(%edi,%eax,4),%edi
    if((x % 3) == 0){
    1ba6:	89 f8                	mov    %edi,%eax
    1ba8:	31 d2                	xor    %edx,%edx
    1baa:	f7 f6                	div    %esi
    1bac:	85 d2                	test   %edx,%edx
    1bae:	75 b8                	jne    1b68 <linkunlink+0x50>
      close(open("x", O_RDWR | O_CREATE));
    1bb0:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1bb7:	00 
    1bb8:	c7 04 24 fd 47 00 00 	movl   $0x47fd,(%esp)
    1bbf:	e8 c4 1e 00 00       	call   3a88 <open>
    1bc4:	89 04 24             	mov    %eax,(%esp)
    1bc7:	e8 a4 1e 00 00       	call   3a70 <close>
    printf(1, "fork failed\n");
    exit();
  }

  unsigned int x = (pid ? 1 : 97);
  for(i = 0; i < 100; i++){
    1bcc:	4b                   	dec    %ebx
    1bcd:	75 af                	jne    1b7e <linkunlink+0x66>
    } else {
      unlink("x");
    }
  }

  if(pid)
    1bcf:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    1bd2:	85 d2                	test   %edx,%edx
    1bd4:	74 54                	je     1c2a <linkunlink+0x112>
    wait();
    1bd6:	e8 75 1e 00 00       	call   3a50 <wait>
  else
    exit();

  printf(1, "linkunlink ok\n");
    1bdb:	c7 44 24 04 85 45 00 	movl   $0x4585,0x4(%esp)
    1be2:	00 
    1be3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1bea:	e8 8d 1f 00 00       	call   3b7c <printf>
}
    1bef:	83 c4 1c             	add    $0x1c,%esp
    1bf2:	5b                   	pop    %ebx
    1bf3:	5e                   	pop    %esi
    1bf4:	5f                   	pop    %edi
    1bf5:	5d                   	pop    %ebp
    1bf6:	c3                   	ret    
    1bf7:	90                   	nop
  for(i = 0; i < 100; i++){
    x = x * 1103515245 + 12345;
    if((x % 3) == 0){
      close(open("x", O_RDWR | O_CREATE));
    } else if((x % 3) == 1){
      link("cat", "x");
    1bf8:	c7 44 24 04 fd 47 00 	movl   $0x47fd,0x4(%esp)
    1bff:	00 
    1c00:	c7 04 24 81 45 00 00 	movl   $0x4581,(%esp)
    1c07:	e8 9c 1e 00 00       	call   3aa8 <link>
    1c0c:	e9 6a ff ff ff       	jmp    1b7b <linkunlink+0x63>
  printf(1, "linkunlink test\n");

  unlink("x");
  pid = fork();
  if(pid < 0){
    printf(1, "fork failed\n");
    1c11:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    1c18:	00 
    1c19:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c20:	e8 57 1f 00 00       	call   3b7c <printf>
    exit();
    1c25:	e8 1e 1e 00 00       	call   3a48 <exit>
  }

  if(pid)
    wait();
  else
    exit();
    1c2a:	e8 19 1e 00 00       	call   3a48 <exit>
    1c2f:	90                   	nop

00001c30 <bigdir>:
}

// directory that uses indirect blocks
void
bigdir(void)
{
    1c30:	55                   	push   %ebp
    1c31:	89 e5                	mov    %esp,%ebp
    1c33:	56                   	push   %esi
    1c34:	53                   	push   %ebx
    1c35:	83 ec 20             	sub    $0x20,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1c38:	c7 44 24 04 94 45 00 	movl   $0x4594,0x4(%esp)
    1c3f:	00 
    1c40:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1c47:	e8 30 1f 00 00       	call   3b7c <printf>
  unlink("bd");
    1c4c:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    1c53:	e8 40 1e 00 00       	call   3a98 <unlink>

  fd = open("bd", O_CREATE);
    1c58:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1c5f:	00 
    1c60:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    1c67:	e8 1c 1e 00 00       	call   3a88 <open>
  if(fd < 0){
    1c6c:	85 c0                	test   %eax,%eax
    1c6e:	0f 88 dc 00 00 00    	js     1d50 <bigdir+0x120>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);
    1c74:	89 04 24             	mov    %eax,(%esp)
    1c77:	e8 f4 1d 00 00       	call   3a70 <close>

  for(i = 0; i < 500; i++){
    1c7c:	31 db                	xor    %ebx,%ebx
    1c7e:	8d 75 ee             	lea    -0x12(%ebp),%esi
    1c81:	8d 76 00             	lea    0x0(%esi),%esi
    name[0] = 'x';
    1c84:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1c88:	89 d8                	mov    %ebx,%eax
    1c8a:	c1 f8 06             	sar    $0x6,%eax
    1c8d:	83 c0 30             	add    $0x30,%eax
    1c90:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1c93:	89 d8                	mov    %ebx,%eax
    1c95:	83 e0 3f             	and    $0x3f,%eax
    1c98:	83 c0 30             	add    $0x30,%eax
    1c9b:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1c9e:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(link("bd", name) != 0){
    1ca2:	89 74 24 04          	mov    %esi,0x4(%esp)
    1ca6:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    1cad:	e8 f6 1d 00 00       	call   3aa8 <link>
    1cb2:	85 c0                	test   %eax,%eax
    1cb4:	75 68                	jne    1d1e <bigdir+0xee>
    printf(1, "bigdir create failed\n");
    exit();
  }
  close(fd);

  for(i = 0; i < 500; i++){
    1cb6:	43                   	inc    %ebx
    1cb7:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1cbd:	75 c5                	jne    1c84 <bigdir+0x54>
      printf(1, "bigdir link failed\n");
      exit();
    }
  }

  unlink("bd");
    1cbf:	c7 04 24 a1 45 00 00 	movl   $0x45a1,(%esp)
    1cc6:	e8 cd 1d 00 00       	call   3a98 <unlink>
  for(i = 0; i < 500; i++){
    1ccb:	66 31 db             	xor    %bx,%bx
    1cce:	66 90                	xchg   %ax,%ax
    name[0] = 'x';
    1cd0:	c6 45 ee 78          	movb   $0x78,-0x12(%ebp)
    name[1] = '0' + (i / 64);
    1cd4:	89 d8                	mov    %ebx,%eax
    1cd6:	c1 f8 06             	sar    $0x6,%eax
    1cd9:	83 c0 30             	add    $0x30,%eax
    1cdc:	88 45 ef             	mov    %al,-0x11(%ebp)
    name[2] = '0' + (i % 64);
    1cdf:	89 d8                	mov    %ebx,%eax
    1ce1:	83 e0 3f             	and    $0x3f,%eax
    1ce4:	83 c0 30             	add    $0x30,%eax
    1ce7:	88 45 f0             	mov    %al,-0x10(%ebp)
    name[3] = '\0';
    1cea:	c6 45 f1 00          	movb   $0x0,-0xf(%ebp)
    if(unlink(name) != 0){
    1cee:	89 34 24             	mov    %esi,(%esp)
    1cf1:	e8 a2 1d 00 00       	call   3a98 <unlink>
    1cf6:	85 c0                	test   %eax,%eax
    1cf8:	75 3d                	jne    1d37 <bigdir+0x107>
      exit();
    }
  }

  unlink("bd");
  for(i = 0; i < 500; i++){
    1cfa:	43                   	inc    %ebx
    1cfb:	81 fb f4 01 00 00    	cmp    $0x1f4,%ebx
    1d01:	75 cd                	jne    1cd0 <bigdir+0xa0>
      printf(1, "bigdir unlink failed");
      exit();
    }
  }

  printf(1, "bigdir ok\n");
    1d03:	c7 44 24 04 e3 45 00 	movl   $0x45e3,0x4(%esp)
    1d0a:	00 
    1d0b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d12:	e8 65 1e 00 00       	call   3b7c <printf>
}
    1d17:	83 c4 20             	add    $0x20,%esp
    1d1a:	5b                   	pop    %ebx
    1d1b:	5e                   	pop    %esi
    1d1c:	5d                   	pop    %ebp
    1d1d:	c3                   	ret    
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(link("bd", name) != 0){
      printf(1, "bigdir link failed\n");
    1d1e:	c7 44 24 04 ba 45 00 	movl   $0x45ba,0x4(%esp)
    1d25:	00 
    1d26:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d2d:	e8 4a 1e 00 00       	call   3b7c <printf>
      exit();
    1d32:	e8 11 1d 00 00       	call   3a48 <exit>
    name[0] = 'x';
    name[1] = '0' + (i / 64);
    name[2] = '0' + (i % 64);
    name[3] = '\0';
    if(unlink(name) != 0){
      printf(1, "bigdir unlink failed");
    1d37:	c7 44 24 04 ce 45 00 	movl   $0x45ce,0x4(%esp)
    1d3e:	00 
    1d3f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d46:	e8 31 1e 00 00       	call   3b7c <printf>
      exit();
    1d4b:	e8 f8 1c 00 00       	call   3a48 <exit>
  printf(1, "bigdir test\n");
  unlink("bd");

  fd = open("bd", O_CREATE);
  if(fd < 0){
    printf(1, "bigdir create failed\n");
    1d50:	c7 44 24 04 a4 45 00 	movl   $0x45a4,0x4(%esp)
    1d57:	00 
    1d58:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d5f:	e8 18 1e 00 00       	call   3b7c <printf>
    exit();
    1d64:	e8 df 1c 00 00       	call   3a48 <exit>
    1d69:	8d 76 00             	lea    0x0(%esi),%esi

00001d6c <subdir>:
  printf(1, "bigdir ok\n");
}

void
subdir(void)
{
    1d6c:	55                   	push   %ebp
    1d6d:	89 e5                	mov    %esp,%ebp
    1d6f:	53                   	push   %ebx
    1d70:	83 ec 14             	sub    $0x14,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1d73:	c7 44 24 04 ee 45 00 	movl   $0x45ee,0x4(%esp)
    1d7a:	00 
    1d7b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    1d82:	e8 f5 1d 00 00       	call   3b7c <printf>

  unlink("ff");
    1d87:	c7 04 24 77 46 00 00 	movl   $0x4677,(%esp)
    1d8e:	e8 05 1d 00 00       	call   3a98 <unlink>
  if(mkdir("dd") != 0){
    1d93:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    1d9a:	e8 11 1d 00 00       	call   3ab0 <mkdir>
    1d9f:	85 c0                	test   %eax,%eax
    1da1:	0f 85 07 06 00 00    	jne    23ae <subdir+0x642>
    printf(1, "subdir mkdir dd failed\n");
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1da7:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1dae:	00 
    1daf:	c7 04 24 4d 46 00 00 	movl   $0x464d,(%esp)
    1db6:	e8 cd 1c 00 00       	call   3a88 <open>
    1dbb:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1dbd:	85 c0                	test   %eax,%eax
    1dbf:	0f 88 d0 05 00 00    	js     2395 <subdir+0x629>
    printf(1, "create dd/ff failed\n");
    exit();
  }
  write(fd, "ff", 2);
    1dc5:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1dcc:	00 
    1dcd:	c7 44 24 04 77 46 00 	movl   $0x4677,0x4(%esp)
    1dd4:	00 
    1dd5:	89 04 24             	mov    %eax,(%esp)
    1dd8:	e8 8b 1c 00 00       	call   3a68 <write>
  close(fd);
    1ddd:	89 1c 24             	mov    %ebx,(%esp)
    1de0:	e8 8b 1c 00 00       	call   3a70 <close>

  if(unlink("dd") >= 0){
    1de5:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    1dec:	e8 a7 1c 00 00       	call   3a98 <unlink>
    1df1:	85 c0                	test   %eax,%eax
    1df3:	0f 89 83 05 00 00    	jns    237c <subdir+0x610>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    1df9:	c7 04 24 28 46 00 00 	movl   $0x4628,(%esp)
    1e00:	e8 ab 1c 00 00       	call   3ab0 <mkdir>
    1e05:	85 c0                	test   %eax,%eax
    1e07:	0f 85 56 05 00 00    	jne    2363 <subdir+0x5f7>
    printf(1, "subdir mkdir dd/dd failed\n");
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    1e0d:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1e14:	00 
    1e15:	c7 04 24 4a 46 00 00 	movl   $0x464a,(%esp)
    1e1c:	e8 67 1c 00 00       	call   3a88 <open>
    1e21:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e23:	85 c0                	test   %eax,%eax
    1e25:	0f 88 25 04 00 00    	js     2250 <subdir+0x4e4>
    printf(1, "create dd/dd/ff failed\n");
    exit();
  }
  write(fd, "FF", 2);
    1e2b:	c7 44 24 08 02 00 00 	movl   $0x2,0x8(%esp)
    1e32:	00 
    1e33:	c7 44 24 04 6b 46 00 	movl   $0x466b,0x4(%esp)
    1e3a:	00 
    1e3b:	89 04 24             	mov    %eax,(%esp)
    1e3e:	e8 25 1c 00 00       	call   3a68 <write>
  close(fd);
    1e43:	89 1c 24             	mov    %ebx,(%esp)
    1e46:	e8 25 1c 00 00       	call   3a70 <close>

  fd = open("dd/dd/../ff", 0);
    1e4b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1e52:	00 
    1e53:	c7 04 24 6e 46 00 00 	movl   $0x466e,(%esp)
    1e5a:	e8 29 1c 00 00       	call   3a88 <open>
    1e5f:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1e61:	85 c0                	test   %eax,%eax
    1e63:	0f 88 ce 03 00 00    	js     2237 <subdir+0x4cb>
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
    1e69:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1e70:	00 
    1e71:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    1e78:	00 
    1e79:	89 04 24             	mov    %eax,(%esp)
    1e7c:	e8 df 1b 00 00       	call   3a60 <read>
  if(cc != 2 || buf[0] != 'f'){
    1e81:	83 f8 02             	cmp    $0x2,%eax
    1e84:	0f 85 fe 02 00 00    	jne    2188 <subdir+0x41c>
    1e8a:	80 3d 00 87 00 00 66 	cmpb   $0x66,0x8700
    1e91:	0f 85 f1 02 00 00    	jne    2188 <subdir+0x41c>
    printf(1, "dd/dd/../ff wrong content\n");
    exit();
  }
  close(fd);
    1e97:	89 1c 24             	mov    %ebx,(%esp)
    1e9a:	e8 d1 1b 00 00       	call   3a70 <close>

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    1e9f:	c7 44 24 04 ae 46 00 	movl   $0x46ae,0x4(%esp)
    1ea6:	00 
    1ea7:	c7 04 24 4a 46 00 00 	movl   $0x464a,(%esp)
    1eae:	e8 f5 1b 00 00       	call   3aa8 <link>
    1eb3:	85 c0                	test   %eax,%eax
    1eb5:	0f 85 c7 03 00 00    	jne    2282 <subdir+0x516>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    1ebb:	c7 04 24 4a 46 00 00 	movl   $0x464a,(%esp)
    1ec2:	e8 d1 1b 00 00       	call   3a98 <unlink>
    1ec7:	85 c0                	test   %eax,%eax
    1ec9:	0f 85 eb 02 00 00    	jne    21ba <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1ecf:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1ed6:	00 
    1ed7:	c7 04 24 4a 46 00 00 	movl   $0x464a,(%esp)
    1ede:	e8 a5 1b 00 00       	call   3a88 <open>
    1ee3:	85 c0                	test   %eax,%eax
    1ee5:	0f 89 5f 04 00 00    	jns    234a <subdir+0x5de>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    1eeb:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    1ef2:	e8 c1 1b 00 00       	call   3ab8 <chdir>
    1ef7:	85 c0                	test   %eax,%eax
    1ef9:	0f 85 32 04 00 00    	jne    2331 <subdir+0x5c5>
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    1eff:	c7 04 24 e2 46 00 00 	movl   $0x46e2,(%esp)
    1f06:	e8 ad 1b 00 00       	call   3ab8 <chdir>
    1f0b:	85 c0                	test   %eax,%eax
    1f0d:	0f 85 8e 02 00 00    	jne    21a1 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("dd/../../../dd") != 0){
    1f13:	c7 04 24 08 47 00 00 	movl   $0x4708,(%esp)
    1f1a:	e8 99 1b 00 00       	call   3ab8 <chdir>
    1f1f:	85 c0                	test   %eax,%eax
    1f21:	0f 85 7a 02 00 00    	jne    21a1 <subdir+0x435>
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    1f27:	c7 04 24 17 47 00 00 	movl   $0x4717,(%esp)
    1f2e:	e8 85 1b 00 00       	call   3ab8 <chdir>
    1f33:	85 c0                	test   %eax,%eax
    1f35:	0f 85 2e 03 00 00    	jne    2269 <subdir+0x4fd>
    printf(1, "chdir ./.. failed\n");
    exit();
  }

  fd = open("dd/dd/ffff", 0);
    1f3b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f42:	00 
    1f43:	c7 04 24 ae 46 00 00 	movl   $0x46ae,(%esp)
    1f4a:	e8 39 1b 00 00       	call   3a88 <open>
    1f4f:	89 c3                	mov    %eax,%ebx
  if(fd < 0){
    1f51:	85 c0                	test   %eax,%eax
    1f53:	0f 88 81 05 00 00    	js     24da <subdir+0x76e>
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    1f59:	c7 44 24 08 00 20 00 	movl   $0x2000,0x8(%esp)
    1f60:	00 
    1f61:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    1f68:	00 
    1f69:	89 04 24             	mov    %eax,(%esp)
    1f6c:	e8 ef 1a 00 00       	call   3a60 <read>
    1f71:	83 f8 02             	cmp    $0x2,%eax
    1f74:	0f 85 47 05 00 00    	jne    24c1 <subdir+0x755>
    printf(1, "read dd/dd/ffff wrong len\n");
    exit();
  }
  close(fd);
    1f7a:	89 1c 24             	mov    %ebx,(%esp)
    1f7d:	e8 ee 1a 00 00       	call   3a70 <close>

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    1f82:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    1f89:	00 
    1f8a:	c7 04 24 4a 46 00 00 	movl   $0x464a,(%esp)
    1f91:	e8 f2 1a 00 00       	call   3a88 <open>
    1f96:	85 c0                	test   %eax,%eax
    1f98:	0f 89 4e 02 00 00    	jns    21ec <subdir+0x480>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    1f9e:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1fa5:	00 
    1fa6:	c7 04 24 62 47 00 00 	movl   $0x4762,(%esp)
    1fad:	e8 d6 1a 00 00       	call   3a88 <open>
    1fb2:	85 c0                	test   %eax,%eax
    1fb4:	0f 89 19 02 00 00    	jns    21d3 <subdir+0x467>
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    1fba:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    1fc1:	00 
    1fc2:	c7 04 24 87 47 00 00 	movl   $0x4787,(%esp)
    1fc9:	e8 ba 1a 00 00       	call   3a88 <open>
    1fce:	85 c0                	test   %eax,%eax
    1fd0:	0f 89 42 03 00 00    	jns    2318 <subdir+0x5ac>
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    1fd6:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    1fdd:	00 
    1fde:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    1fe5:	e8 9e 1a 00 00       	call   3a88 <open>
    1fea:	85 c0                	test   %eax,%eax
    1fec:	0f 89 0d 03 00 00    	jns    22ff <subdir+0x593>
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    1ff2:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    1ff9:	00 
    1ffa:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    2001:	e8 82 1a 00 00       	call   3a88 <open>
    2006:	85 c0                	test   %eax,%eax
    2008:	0f 89 d8 02 00 00    	jns    22e6 <subdir+0x57a>
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    200e:	c7 44 24 04 01 00 00 	movl   $0x1,0x4(%esp)
    2015:	00 
    2016:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    201d:	e8 66 1a 00 00       	call   3a88 <open>
    2022:	85 c0                	test   %eax,%eax
    2024:	0f 89 a3 02 00 00    	jns    22cd <subdir+0x561>
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    202a:	c7 44 24 04 f6 47 00 	movl   $0x47f6,0x4(%esp)
    2031:	00 
    2032:	c7 04 24 62 47 00 00 	movl   $0x4762,(%esp)
    2039:	e8 6a 1a 00 00       	call   3aa8 <link>
    203e:	85 c0                	test   %eax,%eax
    2040:	0f 84 6e 02 00 00    	je     22b4 <subdir+0x548>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2046:	c7 44 24 04 f6 47 00 	movl   $0x47f6,0x4(%esp)
    204d:	00 
    204e:	c7 04 24 87 47 00 00 	movl   $0x4787,(%esp)
    2055:	e8 4e 1a 00 00       	call   3aa8 <link>
    205a:	85 c0                	test   %eax,%eax
    205c:	0f 84 39 02 00 00    	je     229b <subdir+0x52f>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2062:	c7 44 24 04 ae 46 00 	movl   $0x46ae,0x4(%esp)
    2069:	00 
    206a:	c7 04 24 4d 46 00 00 	movl   $0x464d,(%esp)
    2071:	e8 32 1a 00 00       	call   3aa8 <link>
    2076:	85 c0                	test   %eax,%eax
    2078:	0f 84 a0 01 00 00    	je     221e <subdir+0x4b2>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    207e:	c7 04 24 62 47 00 00 	movl   $0x4762,(%esp)
    2085:	e8 26 1a 00 00       	call   3ab0 <mkdir>
    208a:	85 c0                	test   %eax,%eax
    208c:	0f 84 73 01 00 00    	je     2205 <subdir+0x499>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    2092:	c7 04 24 87 47 00 00 	movl   $0x4787,(%esp)
    2099:	e8 12 1a 00 00       	call   3ab0 <mkdir>
    209e:	85 c0                	test   %eax,%eax
    20a0:	0f 84 02 04 00 00    	je     24a8 <subdir+0x73c>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    20a6:	c7 04 24 ae 46 00 00 	movl   $0x46ae,(%esp)
    20ad:	e8 fe 19 00 00       	call   3ab0 <mkdir>
    20b2:	85 c0                	test   %eax,%eax
    20b4:	0f 84 d5 03 00 00    	je     248f <subdir+0x723>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    20ba:	c7 04 24 87 47 00 00 	movl   $0x4787,(%esp)
    20c1:	e8 d2 19 00 00       	call   3a98 <unlink>
    20c6:	85 c0                	test   %eax,%eax
    20c8:	0f 84 a8 03 00 00    	je     2476 <subdir+0x70a>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    20ce:	c7 04 24 62 47 00 00 	movl   $0x4762,(%esp)
    20d5:	e8 be 19 00 00       	call   3a98 <unlink>
    20da:	85 c0                	test   %eax,%eax
    20dc:	0f 84 7b 03 00 00    	je     245d <subdir+0x6f1>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    20e2:	c7 04 24 4d 46 00 00 	movl   $0x464d,(%esp)
    20e9:	e8 ca 19 00 00       	call   3ab8 <chdir>
    20ee:	85 c0                	test   %eax,%eax
    20f0:	0f 84 4e 03 00 00    	je     2444 <subdir+0x6d8>
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    20f6:	c7 04 24 f9 47 00 00 	movl   $0x47f9,(%esp)
    20fd:	e8 b6 19 00 00       	call   3ab8 <chdir>
    2102:	85 c0                	test   %eax,%eax
    2104:	0f 84 21 03 00 00    	je     242b <subdir+0x6bf>
    printf(1, "chdir dd/xx succeeded!\n");
    exit();
  }

  if(unlink("dd/dd/ffff") != 0){
    210a:	c7 04 24 ae 46 00 00 	movl   $0x46ae,(%esp)
    2111:	e8 82 19 00 00       	call   3a98 <unlink>
    2116:	85 c0                	test   %eax,%eax
    2118:	0f 85 9c 00 00 00    	jne    21ba <subdir+0x44e>
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    211e:	c7 04 24 4d 46 00 00 	movl   $0x464d,(%esp)
    2125:	e8 6e 19 00 00       	call   3a98 <unlink>
    212a:	85 c0                	test   %eax,%eax
    212c:	0f 85 e0 02 00 00    	jne    2412 <subdir+0x6a6>
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    2132:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    2139:	e8 5a 19 00 00       	call   3a98 <unlink>
    213e:	85 c0                	test   %eax,%eax
    2140:	0f 84 b3 02 00 00    	je     23f9 <subdir+0x68d>
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    2146:	c7 04 24 29 46 00 00 	movl   $0x4629,(%esp)
    214d:	e8 46 19 00 00       	call   3a98 <unlink>
    2152:	85 c0                	test   %eax,%eax
    2154:	0f 88 86 02 00 00    	js     23e0 <subdir+0x674>
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    215a:	c7 04 24 14 47 00 00 	movl   $0x4714,(%esp)
    2161:	e8 32 19 00 00       	call   3a98 <unlink>
    2166:	85 c0                	test   %eax,%eax
    2168:	0f 88 59 02 00 00    	js     23c7 <subdir+0x65b>
    printf(1, "unlink dd failed\n");
    exit();
  }

  printf(1, "subdir ok\n");
    216e:	c7 44 24 04 f6 48 00 	movl   $0x48f6,0x4(%esp)
    2175:	00 
    2176:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    217d:	e8 fa 19 00 00       	call   3b7c <printf>
}
    2182:	83 c4 14             	add    $0x14,%esp
    2185:	5b                   	pop    %ebx
    2186:	5d                   	pop    %ebp
    2187:	c3                   	ret    
    printf(1, "open dd/dd/../ff failed\n");
    exit();
  }
  cc = read(fd, buf, sizeof(buf));
  if(cc != 2 || buf[0] != 'f'){
    printf(1, "dd/dd/../ff wrong content\n");
    2188:	c7 44 24 04 93 46 00 	movl   $0x4693,0x4(%esp)
    218f:	00 
    2190:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2197:	e8 e0 19 00 00       	call   3b7c <printf>
    exit();
    219c:	e8 a7 18 00 00       	call   3a48 <exit>
  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    exit();
  }
  if(chdir("dd/../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    21a1:	c7 44 24 04 ee 46 00 	movl   $0x46ee,0x4(%esp)
    21a8:	00 
    21a9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21b0:	e8 c7 19 00 00       	call   3b7c <printf>
    exit();
    21b5:	e8 8e 18 00 00       	call   3a48 <exit>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    exit();
  }

  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    21ba:	c7 44 24 04 b9 46 00 	movl   $0x46b9,0x4(%esp)
    21c1:	00 
    21c2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21c9:	e8 ae 19 00 00       	call   3b7c <printf>
    exit();
    21ce:	e8 75 18 00 00       	call   3a48 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    exit();
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    21d3:	c7 44 24 04 6b 47 00 	movl   $0x476b,0x4(%esp)
    21da:	00 
    21db:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21e2:	e8 95 19 00 00       	call   3b7c <printf>
    exit();
    21e7:	e8 5c 18 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    21ec:	c7 44 24 04 50 51 00 	movl   $0x5150,0x4(%esp)
    21f3:	00 
    21f4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    21fb:	e8 7c 19 00 00       	call   3b7c <printf>
    exit();
    2200:	e8 43 18 00 00       	call   3a48 <exit>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    exit();
  }
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    2205:	c7 44 24 04 ff 47 00 	movl   $0x47ff,0x4(%esp)
    220c:	00 
    220d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2214:	e8 63 19 00 00       	call   3b7c <printf>
    exit();
    2219:	e8 2a 18 00 00       	call   3a48 <exit>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    221e:	c7 44 24 04 c0 51 00 	movl   $0x51c0,0x4(%esp)
    2225:	00 
    2226:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    222d:	e8 4a 19 00 00       	call   3b7c <printf>
    exit();
    2232:	e8 11 18 00 00       	call   3a48 <exit>
  write(fd, "FF", 2);
  close(fd);

  fd = open("dd/dd/../ff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/../ff failed\n");
    2237:	c7 44 24 04 7a 46 00 	movl   $0x467a,0x4(%esp)
    223e:	00 
    223f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2246:	e8 31 19 00 00       	call   3b7c <printf>
    exit();
    224b:	e8 f8 17 00 00       	call   3a48 <exit>
    exit();
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/dd/ff failed\n");
    2250:	c7 44 24 04 53 46 00 	movl   $0x4653,0x4(%esp)
    2257:	00 
    2258:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    225f:	e8 18 19 00 00       	call   3b7c <printf>
    exit();
    2264:	e8 df 17 00 00       	call   3a48 <exit>
  if(chdir("dd/../../../dd") != 0){
    printf(1, "chdir dd/../../dd failed\n");
    exit();
  }
  if(chdir("./..") != 0){
    printf(1, "chdir ./.. failed\n");
    2269:	c7 44 24 04 1c 47 00 	movl   $0x471c,0x4(%esp)
    2270:	00 
    2271:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2278:	e8 ff 18 00 00       	call   3b7c <printf>
    exit();
    227d:	e8 c6 17 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    2282:	c7 44 24 04 08 51 00 	movl   $0x5108,0x4(%esp)
    2289:	00 
    228a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2291:	e8 e6 18 00 00       	call   3b7c <printf>
    exit();
    2296:	e8 ad 17 00 00       	call   3a48 <exit>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    exit();
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    229b:	c7 44 24 04 9c 51 00 	movl   $0x519c,0x4(%esp)
    22a2:	00 
    22a3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22aa:	e8 cd 18 00 00       	call   3b7c <printf>
    exit();
    22af:	e8 94 17 00 00       	call   3a48 <exit>
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    exit();
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    22b4:	c7 44 24 04 78 51 00 	movl   $0x5178,0x4(%esp)
    22bb:	00 
    22bc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22c3:	e8 b4 18 00 00       	call   3b7c <printf>
    exit();
    22c8:	e8 7b 17 00 00       	call   3a48 <exit>
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    exit();
  }
  if(open("dd", O_WRONLY) >= 0){
    printf(1, "open dd wronly succeeded!\n");
    22cd:	c7 44 24 04 db 47 00 	movl   $0x47db,0x4(%esp)
    22d4:	00 
    22d5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22dc:	e8 9b 18 00 00       	call   3b7c <printf>
    exit();
    22e1:	e8 62 17 00 00       	call   3a48 <exit>
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    exit();
  }
  if(open("dd", O_RDWR) >= 0){
    printf(1, "open dd rdwr succeeded!\n");
    22e6:	c7 44 24 04 c2 47 00 	movl   $0x47c2,0x4(%esp)
    22ed:	00 
    22ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    22f5:	e8 82 18 00 00       	call   3b7c <printf>
    exit();
    22fa:	e8 49 17 00 00       	call   3a48 <exit>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    exit();
  }
  if(open("dd", O_CREATE) >= 0){
    printf(1, "create dd succeeded!\n");
    22ff:	c7 44 24 04 ac 47 00 	movl   $0x47ac,0x4(%esp)
    2306:	00 
    2307:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    230e:	e8 69 18 00 00       	call   3b7c <printf>
    exit();
    2313:	e8 30 17 00 00       	call   3a48 <exit>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/ff/ff succeeded!\n");
    exit();
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    printf(1, "create dd/xx/ff succeeded!\n");
    2318:	c7 44 24 04 90 47 00 	movl   $0x4790,0x4(%esp)
    231f:	00 
    2320:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2327:	e8 50 18 00 00       	call   3b7c <printf>
    exit();
    232c:	e8 17 17 00 00       	call   3a48 <exit>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    exit();
  }

  if(chdir("dd") != 0){
    printf(1, "chdir dd failed\n");
    2331:	c7 44 24 04 d1 46 00 	movl   $0x46d1,0x4(%esp)
    2338:	00 
    2339:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2340:	e8 37 18 00 00       	call   3b7c <printf>
    exit();
    2345:	e8 fe 16 00 00       	call   3a48 <exit>
  if(unlink("dd/dd/ff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    234a:	c7 44 24 04 2c 51 00 	movl   $0x512c,0x4(%esp)
    2351:	00 
    2352:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2359:	e8 1e 18 00 00       	call   3b7c <printf>
    exit();
    235e:	e8 e5 16 00 00       	call   3a48 <exit>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    exit();
  }

  if(mkdir("/dd/dd") != 0){
    printf(1, "subdir mkdir dd/dd failed\n");
    2363:	c7 44 24 04 2f 46 00 	movl   $0x462f,0x4(%esp)
    236a:	00 
    236b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2372:	e8 05 18 00 00       	call   3b7c <printf>
    exit();
    2377:	e8 cc 16 00 00       	call   3a48 <exit>
  }
  write(fd, "ff", 2);
  close(fd);

  if(unlink("dd") >= 0){
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    237c:	c7 44 24 04 e0 50 00 	movl   $0x50e0,0x4(%esp)
    2383:	00 
    2384:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    238b:	e8 ec 17 00 00       	call   3b7c <printf>
    exit();
    2390:	e8 b3 16 00 00       	call   3a48 <exit>
    exit();
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "create dd/ff failed\n");
    2395:	c7 44 24 04 13 46 00 	movl   $0x4613,0x4(%esp)
    239c:	00 
    239d:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23a4:	e8 d3 17 00 00       	call   3b7c <printf>
    exit();
    23a9:	e8 9a 16 00 00       	call   3a48 <exit>

  printf(1, "subdir test\n");

  unlink("ff");
  if(mkdir("dd") != 0){
    printf(1, "subdir mkdir dd failed\n");
    23ae:	c7 44 24 04 fb 45 00 	movl   $0x45fb,0x4(%esp)
    23b5:	00 
    23b6:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23bd:	e8 ba 17 00 00       	call   3b7c <printf>
    exit();
    23c2:	e8 81 16 00 00       	call   3a48 <exit>
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    exit();
  }
  if(unlink("dd") < 0){
    printf(1, "unlink dd failed\n");
    23c7:	c7 44 24 04 e4 48 00 	movl   $0x48e4,0x4(%esp)
    23ce:	00 
    23cf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23d6:	e8 a1 17 00 00       	call   3b7c <printf>
    exit();
    23db:	e8 68 16 00 00       	call   3a48 <exit>
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    exit();
  }
  if(unlink("dd/dd") < 0){
    printf(1, "unlink dd/dd failed\n");
    23e0:	c7 44 24 04 cf 48 00 	movl   $0x48cf,0x4(%esp)
    23e7:	00 
    23e8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    23ef:	e8 88 17 00 00       	call   3b7c <printf>
    exit();
    23f4:	e8 4f 16 00 00       	call   3a48 <exit>
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    exit();
  }
  if(unlink("dd") == 0){
    printf(1, "unlink non-empty dd succeeded!\n");
    23f9:	c7 44 24 04 e4 51 00 	movl   $0x51e4,0x4(%esp)
    2400:	00 
    2401:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2408:	e8 6f 17 00 00       	call   3b7c <printf>
    exit();
    240d:	e8 36 16 00 00       	call   3a48 <exit>
  if(unlink("dd/dd/ffff") != 0){
    printf(1, "unlink dd/dd/ff failed\n");
    exit();
  }
  if(unlink("dd/ff") != 0){
    printf(1, "unlink dd/ff failed\n");
    2412:	c7 44 24 04 ba 48 00 	movl   $0x48ba,0x4(%esp)
    2419:	00 
    241a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2421:	e8 56 17 00 00       	call   3b7c <printf>
    exit();
    2426:	e8 1d 16 00 00       	call   3a48 <exit>
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/xx") == 0){
    printf(1, "chdir dd/xx succeeded!\n");
    242b:	c7 44 24 04 a2 48 00 	movl   $0x48a2,0x4(%esp)
    2432:	00 
    2433:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    243a:	e8 3d 17 00 00       	call   3b7c <printf>
    exit();
    243f:	e8 04 16 00 00       	call   3a48 <exit>
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    exit();
  }
  if(chdir("dd/ff") == 0){
    printf(1, "chdir dd/ff succeeded!\n");
    2444:	c7 44 24 04 8a 48 00 	movl   $0x488a,0x4(%esp)
    244b:	00 
    244c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2453:	e8 24 17 00 00       	call   3b7c <printf>
    exit();
    2458:	e8 eb 15 00 00       	call   3a48 <exit>
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    exit();
  }
  if(unlink("dd/ff/ff") == 0){
    printf(1, "unlink dd/ff/ff succeeded!\n");
    245d:	c7 44 24 04 6e 48 00 	movl   $0x486e,0x4(%esp)
    2464:	00 
    2465:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    246c:	e8 0b 17 00 00       	call   3b7c <printf>
    exit();
    2471:	e8 d2 15 00 00       	call   3a48 <exit>
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    exit();
  }
  if(unlink("dd/xx/ff") == 0){
    printf(1, "unlink dd/xx/ff succeeded!\n");
    2476:	c7 44 24 04 52 48 00 	movl   $0x4852,0x4(%esp)
    247d:	00 
    247e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2485:	e8 f2 16 00 00       	call   3b7c <printf>
    exit();
    248a:	e8 b9 15 00 00       	call   3a48 <exit>
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/dd/ffff") == 0){
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    248f:	c7 44 24 04 35 48 00 	movl   $0x4835,0x4(%esp)
    2496:	00 
    2497:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    249e:	e8 d9 16 00 00       	call   3b7c <printf>
    exit();
    24a3:	e8 a0 15 00 00       	call   3a48 <exit>
  if(mkdir("dd/ff/ff") == 0){
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    exit();
  }
  if(mkdir("dd/xx/ff") == 0){
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    24a8:	c7 44 24 04 1a 48 00 	movl   $0x481a,0x4(%esp)
    24af:	00 
    24b0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24b7:	e8 c0 16 00 00       	call   3b7c <printf>
    exit();
    24bc:	e8 87 15 00 00       	call   3a48 <exit>
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    exit();
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    printf(1, "read dd/dd/ffff wrong len\n");
    24c1:	c7 44 24 04 47 47 00 	movl   $0x4747,0x4(%esp)
    24c8:	00 
    24c9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24d0:	e8 a7 16 00 00       	call   3b7c <printf>
    exit();
    24d5:	e8 6e 15 00 00       	call   3a48 <exit>
    exit();
  }

  fd = open("dd/dd/ffff", 0);
  if(fd < 0){
    printf(1, "open dd/dd/ffff failed\n");
    24da:	c7 44 24 04 2f 47 00 	movl   $0x472f,0x4(%esp)
    24e1:	00 
    24e2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    24e9:	e8 8e 16 00 00       	call   3b7c <printf>
    exit();
    24ee:	e8 55 15 00 00       	call   3a48 <exit>
    24f3:	90                   	nop

000024f4 <bigwrite>:
}

// test writes that are larger than the log.
void
bigwrite(void)
{
    24f4:	55                   	push   %ebp
    24f5:	89 e5                	mov    %esp,%ebp
    24f7:	56                   	push   %esi
    24f8:	53                   	push   %ebx
    24f9:	83 ec 10             	sub    $0x10,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    24fc:	c7 44 24 04 01 49 00 	movl   $0x4901,0x4(%esp)
    2503:	00 
    2504:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    250b:	e8 6c 16 00 00       	call   3b7c <printf>

  unlink("bigwrite");
    2510:	c7 04 24 10 49 00 00 	movl   $0x4910,(%esp)
    2517:	e8 7c 15 00 00       	call   3a98 <unlink>
  for(sz = 499; sz < 12*512; sz += 471){
    251c:	bb f3 01 00 00       	mov    $0x1f3,%ebx
    2521:	8d 76 00             	lea    0x0(%esi),%esi
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2524:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    252b:	00 
    252c:	c7 04 24 10 49 00 00 	movl   $0x4910,(%esp)
    2533:	e8 50 15 00 00       	call   3a88 <open>
    2538:	89 c6                	mov    %eax,%esi
    if(fd < 0){
    253a:	85 c0                	test   %eax,%eax
    253c:	0f 88 8e 00 00 00    	js     25d0 <bigwrite+0xdc>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    2542:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    2546:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    254d:	00 
    254e:	89 04 24             	mov    %eax,(%esp)
    2551:	e8 12 15 00 00       	call   3a68 <write>
      if(cc != sz){
    2556:	39 d8                	cmp    %ebx,%eax
    2558:	75 55                	jne    25af <bigwrite+0xbb>
      printf(1, "cannot create bigwrite\n");
      exit();
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
    255a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    255e:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    2565:	00 
    2566:	89 34 24             	mov    %esi,(%esp)
    2569:	e8 fa 14 00 00       	call   3a68 <write>
      if(cc != sz){
    256e:	39 c3                	cmp    %eax,%ebx
    2570:	75 3d                	jne    25af <bigwrite+0xbb>
        printf(1, "write(%d) ret %d\n", sz, cc);
        exit();
      }
    }
    close(fd);
    2572:	89 34 24             	mov    %esi,(%esp)
    2575:	e8 f6 14 00 00       	call   3a70 <close>
    unlink("bigwrite");
    257a:	c7 04 24 10 49 00 00 	movl   $0x4910,(%esp)
    2581:	e8 12 15 00 00       	call   3a98 <unlink>
  int fd, sz;

  printf(1, "bigwrite test\n");

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    2586:	81 c3 d7 01 00 00    	add    $0x1d7,%ebx
    258c:	81 fb 07 18 00 00    	cmp    $0x1807,%ebx
    2592:	75 90                	jne    2524 <bigwrite+0x30>
    }
    close(fd);
    unlink("bigwrite");
  }

  printf(1, "bigwrite ok\n");
    2594:	c7 44 24 04 43 49 00 	movl   $0x4943,0x4(%esp)
    259b:	00 
    259c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25a3:	e8 d4 15 00 00       	call   3b7c <printf>
}
    25a8:	83 c4 10             	add    $0x10,%esp
    25ab:	5b                   	pop    %ebx
    25ac:	5e                   	pop    %esi
    25ad:	5d                   	pop    %ebp
    25ae:	c3                   	ret    
    }
    int i;
    for(i = 0; i < 2; i++){
      int cc = write(fd, buf, sz);
      if(cc != sz){
        printf(1, "write(%d) ret %d\n", sz, cc);
    25af:	89 44 24 0c          	mov    %eax,0xc(%esp)
    25b3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    25b7:	c7 44 24 04 31 49 00 	movl   $0x4931,0x4(%esp)
    25be:	00 
    25bf:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25c6:	e8 b1 15 00 00       	call   3b7c <printf>
        exit();
    25cb:	e8 78 14 00 00       	call   3a48 <exit>

  unlink("bigwrite");
  for(sz = 499; sz < 12*512; sz += 471){
    fd = open("bigwrite", O_CREATE | O_RDWR);
    if(fd < 0){
      printf(1, "cannot create bigwrite\n");
    25d0:	c7 44 24 04 19 49 00 	movl   $0x4919,0x4(%esp)
    25d7:	00 
    25d8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    25df:	e8 98 15 00 00       	call   3b7c <printf>
      exit();
    25e4:	e8 5f 14 00 00       	call   3a48 <exit>
    25e9:	8d 76 00             	lea    0x0(%esi),%esi

000025ec <bigfile>:
  printf(1, "bigwrite ok\n");
}

void
bigfile(void)
{
    25ec:	55                   	push   %ebp
    25ed:	89 e5                	mov    %esp,%ebp
    25ef:	57                   	push   %edi
    25f0:	56                   	push   %esi
    25f1:	53                   	push   %ebx
    25f2:	83 ec 1c             	sub    $0x1c,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    25f5:	c7 44 24 04 50 49 00 	movl   $0x4950,0x4(%esp)
    25fc:	00 
    25fd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2604:	e8 73 15 00 00       	call   3b7c <printf>

  unlink("bigfile");
    2609:	c7 04 24 6c 49 00 00 	movl   $0x496c,(%esp)
    2610:	e8 83 14 00 00       	call   3a98 <unlink>
  fd = open("bigfile", O_CREATE | O_RDWR);
    2615:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    261c:	00 
    261d:	c7 04 24 6c 49 00 00 	movl   $0x496c,(%esp)
    2624:	e8 5f 14 00 00       	call   3a88 <open>
    2629:	89 c6                	mov    %eax,%esi
  if(fd < 0){
    262b:	85 c0                	test   %eax,%eax
    262d:	0f 88 78 01 00 00    	js     27ab <bigfile+0x1bf>
    2633:	31 db                	xor    %ebx,%ebx
    2635:	8d 76 00             	lea    0x0(%esi),%esi
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    2638:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    263f:	00 
    2640:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    2644:	c7 04 24 00 87 00 00 	movl   $0x8700,(%esp)
    264b:	e8 b8 12 00 00       	call   3908 <memset>
    if(write(fd, buf, 600) != 600){
    2650:	c7 44 24 08 58 02 00 	movl   $0x258,0x8(%esp)
    2657:	00 
    2658:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    265f:	00 
    2660:	89 34 24             	mov    %esi,(%esp)
    2663:	e8 00 14 00 00       	call   3a68 <write>
    2668:	3d 58 02 00 00       	cmp    $0x258,%eax
    266d:	0f 85 06 01 00 00    	jne    2779 <bigfile+0x18d>
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    exit();
  }
  for(i = 0; i < 20; i++){
    2673:	43                   	inc    %ebx
    2674:	83 fb 14             	cmp    $0x14,%ebx
    2677:	75 bf                	jne    2638 <bigfile+0x4c>
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
      exit();
    }
  }
  close(fd);
    2679:	89 34 24             	mov    %esi,(%esp)
    267c:	e8 ef 13 00 00       	call   3a70 <close>

  fd = open("bigfile", 0);
    2681:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2688:	00 
    2689:	c7 04 24 6c 49 00 00 	movl   $0x496c,(%esp)
    2690:	e8 f3 13 00 00       	call   3a88 <open>
    2695:	89 c7                	mov    %eax,%edi
  if(fd < 0){
    2697:	85 c0                	test   %eax,%eax
    2699:	0f 88 f3 00 00 00    	js     2792 <bigfile+0x1a6>
    269f:	31 f6                	xor    %esi,%esi
    26a1:	31 db                	xor    %ebx,%ebx
    26a3:	eb 2f                	jmp    26d4 <bigfile+0xe8>
    26a5:	8d 76 00             	lea    0x0(%esi),%esi
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
    26a8:	3d 2c 01 00 00       	cmp    $0x12c,%eax
    26ad:	0f 85 94 00 00 00    	jne    2747 <bigfile+0x15b>
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    26b3:	0f be 05 00 87 00 00 	movsbl 0x8700,%eax
    26ba:	89 da                	mov    %ebx,%edx
    26bc:	d1 fa                	sar    %edx
    26be:	39 d0                	cmp    %edx,%eax
    26c0:	75 6c                	jne    272e <bigfile+0x142>
    26c2:	0f be 15 2b 88 00 00 	movsbl 0x882b,%edx
    26c9:	39 d0                	cmp    %edx,%eax
    26cb:	75 61                	jne    272e <bigfile+0x142>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
    26cd:	81 c6 2c 01 00 00    	add    $0x12c,%esi
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    exit();
  }
  total = 0;
  for(i = 0; ; i++){
    26d3:	43                   	inc    %ebx
    cc = read(fd, buf, 300);
    26d4:	c7 44 24 08 2c 01 00 	movl   $0x12c,0x8(%esp)
    26db:	00 
    26dc:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    26e3:	00 
    26e4:	89 3c 24             	mov    %edi,(%esp)
    26e7:	e8 74 13 00 00       	call   3a60 <read>
    if(cc < 0){
    26ec:	85 c0                	test   %eax,%eax
    26ee:	78 70                	js     2760 <bigfile+0x174>
      printf(1, "read bigfile failed\n");
      exit();
    }
    if(cc == 0)
    26f0:	75 b6                	jne    26a8 <bigfile+0xbc>
      printf(1, "read bigfile wrong data\n");
      exit();
    }
    total += cc;
  }
  close(fd);
    26f2:	89 3c 24             	mov    %edi,(%esp)
    26f5:	e8 76 13 00 00       	call   3a70 <close>
  if(total != 20*600){
    26fa:	81 fe e0 2e 00 00    	cmp    $0x2ee0,%esi
    2700:	0f 85 be 00 00 00    	jne    27c4 <bigfile+0x1d8>
    printf(1, "read bigfile wrong total\n");
    exit();
  }
  unlink("bigfile");
    2706:	c7 04 24 6c 49 00 00 	movl   $0x496c,(%esp)
    270d:	e8 86 13 00 00       	call   3a98 <unlink>

  printf(1, "bigfile test ok\n");
    2712:	c7 44 24 04 fb 49 00 	movl   $0x49fb,0x4(%esp)
    2719:	00 
    271a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2721:	e8 56 14 00 00       	call   3b7c <printf>
}
    2726:	83 c4 1c             	add    $0x1c,%esp
    2729:	5b                   	pop    %ebx
    272a:	5e                   	pop    %esi
    272b:	5f                   	pop    %edi
    272c:	5d                   	pop    %ebp
    272d:	c3                   	ret    
    if(cc != 300){
      printf(1, "short read bigfile\n");
      exit();
    }
    if(buf[0] != i/2 || buf[299] != i/2){
      printf(1, "read bigfile wrong data\n");
    272e:	c7 44 24 04 c8 49 00 	movl   $0x49c8,0x4(%esp)
    2735:	00 
    2736:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    273d:	e8 3a 14 00 00       	call   3b7c <printf>
      exit();
    2742:	e8 01 13 00 00       	call   3a48 <exit>
      exit();
    }
    if(cc == 0)
      break;
    if(cc != 300){
      printf(1, "short read bigfile\n");
    2747:	c7 44 24 04 b4 49 00 	movl   $0x49b4,0x4(%esp)
    274e:	00 
    274f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2756:	e8 21 14 00 00       	call   3b7c <printf>
      exit();
    275b:	e8 e8 12 00 00       	call   3a48 <exit>
  }
  total = 0;
  for(i = 0; ; i++){
    cc = read(fd, buf, 300);
    if(cc < 0){
      printf(1, "read bigfile failed\n");
    2760:	c7 44 24 04 9f 49 00 	movl   $0x499f,0x4(%esp)
    2767:	00 
    2768:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    276f:	e8 08 14 00 00       	call   3b7c <printf>
      exit();
    2774:	e8 cf 12 00 00       	call   3a48 <exit>
    exit();
  }
  for(i = 0; i < 20; i++){
    memset(buf, i, 600);
    if(write(fd, buf, 600) != 600){
      printf(1, "write bigfile failed\n");
    2779:	c7 44 24 04 74 49 00 	movl   $0x4974,0x4(%esp)
    2780:	00 
    2781:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2788:	e8 ef 13 00 00       	call   3b7c <printf>
      exit();
    278d:	e8 b6 12 00 00       	call   3a48 <exit>
  }
  close(fd);

  fd = open("bigfile", 0);
  if(fd < 0){
    printf(1, "cannot open bigfile\n");
    2792:	c7 44 24 04 8a 49 00 	movl   $0x498a,0x4(%esp)
    2799:	00 
    279a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27a1:	e8 d6 13 00 00       	call   3b7c <printf>
    exit();
    27a6:	e8 9d 12 00 00       	call   3a48 <exit>
  printf(1, "bigfile test\n");

  unlink("bigfile");
  fd = open("bigfile", O_CREATE | O_RDWR);
  if(fd < 0){
    printf(1, "cannot create bigfile");
    27ab:	c7 44 24 04 5e 49 00 	movl   $0x495e,0x4(%esp)
    27b2:	00 
    27b3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27ba:	e8 bd 13 00 00       	call   3b7c <printf>
    exit();
    27bf:	e8 84 12 00 00       	call   3a48 <exit>
    }
    total += cc;
  }
  close(fd);
  if(total != 20*600){
    printf(1, "read bigfile wrong total\n");
    27c4:	c7 44 24 04 e1 49 00 	movl   $0x49e1,0x4(%esp)
    27cb:	00 
    27cc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27d3:	e8 a4 13 00 00       	call   3b7c <printf>
    exit();
    27d8:	e8 6b 12 00 00       	call   3a48 <exit>
    27dd:	8d 76 00             	lea    0x0(%esi),%esi

000027e0 <fourteen>:
  printf(1, "bigfile test ok\n");
}

void
fourteen(void)
{
    27e0:	55                   	push   %ebp
    27e1:	89 e5                	mov    %esp,%ebp
    27e3:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    27e6:	c7 44 24 04 0c 4a 00 	movl   $0x4a0c,0x4(%esp)
    27ed:	00 
    27ee:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    27f5:	e8 82 13 00 00       	call   3b7c <printf>

  if(mkdir("12345678901234") != 0){
    27fa:	c7 04 24 47 4a 00 00 	movl   $0x4a47,(%esp)
    2801:	e8 aa 12 00 00       	call   3ab0 <mkdir>
    2806:	85 c0                	test   %eax,%eax
    2808:	0f 85 92 00 00 00    	jne    28a0 <fourteen+0xc0>
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    280e:	c7 04 24 04 52 00 00 	movl   $0x5204,(%esp)
    2815:	e8 96 12 00 00       	call   3ab0 <mkdir>
    281a:	85 c0                	test   %eax,%eax
    281c:	0f 85 fb 00 00 00    	jne    291d <fourteen+0x13d>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2822:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2829:	00 
    282a:	c7 04 24 54 52 00 00 	movl   $0x5254,(%esp)
    2831:	e8 52 12 00 00       	call   3a88 <open>
  if(fd < 0){
    2836:	85 c0                	test   %eax,%eax
    2838:	0f 88 c6 00 00 00    	js     2904 <fourteen+0x124>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    exit();
  }
  close(fd);
    283e:	89 04 24             	mov    %eax,(%esp)
    2841:	e8 2a 12 00 00       	call   3a70 <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2846:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    284d:	00 
    284e:	c7 04 24 c4 52 00 00 	movl   $0x52c4,(%esp)
    2855:	e8 2e 12 00 00       	call   3a88 <open>
  if(fd < 0){
    285a:	85 c0                	test   %eax,%eax
    285c:	0f 88 89 00 00 00    	js     28eb <fourteen+0x10b>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    exit();
  }
  close(fd);
    2862:	89 04 24             	mov    %eax,(%esp)
    2865:	e8 06 12 00 00       	call   3a70 <close>

  if(mkdir("12345678901234/12345678901234") == 0){
    286a:	c7 04 24 38 4a 00 00 	movl   $0x4a38,(%esp)
    2871:	e8 3a 12 00 00       	call   3ab0 <mkdir>
    2876:	85 c0                	test   %eax,%eax
    2878:	74 58                	je     28d2 <fourteen+0xf2>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    287a:	c7 04 24 60 53 00 00 	movl   $0x5360,(%esp)
    2881:	e8 2a 12 00 00       	call   3ab0 <mkdir>
    2886:	85 c0                	test   %eax,%eax
    2888:	74 2f                	je     28b9 <fourteen+0xd9>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    exit();
  }

  printf(1, "fourteen ok\n");
    288a:	c7 44 24 04 56 4a 00 	movl   $0x4a56,0x4(%esp)
    2891:	00 
    2892:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2899:	e8 de 12 00 00       	call   3b7c <printf>
}
    289e:	c9                   	leave  
    289f:	c3                   	ret    

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");

  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    28a0:	c7 44 24 04 1b 4a 00 	movl   $0x4a1b,0x4(%esp)
    28a7:	00 
    28a8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28af:	e8 c8 12 00 00       	call   3b7c <printf>
    exit();
    28b4:	e8 8f 11 00 00       	call   3a48 <exit>
  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    exit();
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    28b9:	c7 44 24 04 80 53 00 	movl   $0x5380,0x4(%esp)
    28c0:	00 
    28c1:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28c8:	e8 af 12 00 00       	call   3b7c <printf>
    exit();
    28cd:	e8 76 11 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);

  if(mkdir("12345678901234/12345678901234") == 0){
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    28d2:	c7 44 24 04 30 53 00 	movl   $0x5330,0x4(%esp)
    28d9:	00 
    28da:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28e1:	e8 96 12 00 00       	call   3b7c <printf>
    exit();
    28e6:	e8 5d 11 00 00       	call   3a48 <exit>
    exit();
  }
  close(fd);
  fd = open("12345678901234/12345678901234/12345678901234", 0);
  if(fd < 0){
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    28eb:	c7 44 24 04 f4 52 00 	movl   $0x52f4,0x4(%esp)
    28f2:	00 
    28f3:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    28fa:	e8 7d 12 00 00       	call   3b7c <printf>
    exit();
    28ff:	e8 44 11 00 00       	call   3a48 <exit>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    exit();
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
  if(fd < 0){
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2904:	c7 44 24 04 84 52 00 	movl   $0x5284,0x4(%esp)
    290b:	00 
    290c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2913:	e8 64 12 00 00       	call   3b7c <printf>
    exit();
    2918:	e8 2b 11 00 00       	call   3a48 <exit>
  if(mkdir("12345678901234") != 0){
    printf(1, "mkdir 12345678901234 failed\n");
    exit();
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    291d:	c7 44 24 04 24 52 00 	movl   $0x5224,0x4(%esp)
    2924:	00 
    2925:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    292c:	e8 4b 12 00 00       	call   3b7c <printf>
    exit();
    2931:	e8 12 11 00 00       	call   3a48 <exit>
    2936:	66 90                	xchg   %ax,%ax

00002938 <rmdot>:
  printf(1, "fourteen ok\n");
}

void
rmdot(void)
{
    2938:	55                   	push   %ebp
    2939:	89 e5                	mov    %esp,%ebp
    293b:	83 ec 18             	sub    $0x18,%esp
  printf(1, "rmdot test\n");
    293e:	c7 44 24 04 63 4a 00 	movl   $0x4a63,0x4(%esp)
    2945:	00 
    2946:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    294d:	e8 2a 12 00 00       	call   3b7c <printf>
  if(mkdir("dots") != 0){
    2952:	c7 04 24 6f 4a 00 00 	movl   $0x4a6f,(%esp)
    2959:	e8 52 11 00 00       	call   3ab0 <mkdir>
    295e:	85 c0                	test   %eax,%eax
    2960:	0f 85 9a 00 00 00    	jne    2a00 <rmdot+0xc8>
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    2966:	c7 04 24 6f 4a 00 00 	movl   $0x4a6f,(%esp)
    296d:	e8 46 11 00 00       	call   3ab8 <chdir>
    2972:	85 c0                	test   %eax,%eax
    2974:	0f 85 35 01 00 00    	jne    2aaf <rmdot+0x177>
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    297a:	c7 04 24 1a 47 00 00 	movl   $0x471a,(%esp)
    2981:	e8 12 11 00 00       	call   3a98 <unlink>
    2986:	85 c0                	test   %eax,%eax
    2988:	0f 84 08 01 00 00    	je     2a96 <rmdot+0x15e>
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    298e:	c7 04 24 19 47 00 00 	movl   $0x4719,(%esp)
    2995:	e8 fe 10 00 00       	call   3a98 <unlink>
    299a:	85 c0                	test   %eax,%eax
    299c:	0f 84 db 00 00 00    	je     2a7d <rmdot+0x145>
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    29a2:	c7 04 24 ed 3e 00 00 	movl   $0x3eed,(%esp)
    29a9:	e8 0a 11 00 00       	call   3ab8 <chdir>
    29ae:	85 c0                	test   %eax,%eax
    29b0:	0f 85 ae 00 00 00    	jne    2a64 <rmdot+0x12c>
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    29b6:	c7 04 24 b7 4a 00 00 	movl   $0x4ab7,(%esp)
    29bd:	e8 d6 10 00 00       	call   3a98 <unlink>
    29c2:	85 c0                	test   %eax,%eax
    29c4:	0f 84 81 00 00 00    	je     2a4b <rmdot+0x113>
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    29ca:	c7 04 24 d5 4a 00 00 	movl   $0x4ad5,(%esp)
    29d1:	e8 c2 10 00 00       	call   3a98 <unlink>
    29d6:	85 c0                	test   %eax,%eax
    29d8:	74 58                	je     2a32 <rmdot+0xfa>
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    29da:	c7 04 24 6f 4a 00 00 	movl   $0x4a6f,(%esp)
    29e1:	e8 b2 10 00 00       	call   3a98 <unlink>
    29e6:	85 c0                	test   %eax,%eax
    29e8:	75 2f                	jne    2a19 <rmdot+0xe1>
    printf(1, "unlink dots failed!\n");
    exit();
  }
  printf(1, "rmdot ok\n");
    29ea:	c7 44 24 04 0a 4b 00 	movl   $0x4b0a,0x4(%esp)
    29f1:	00 
    29f2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    29f9:	e8 7e 11 00 00       	call   3b7c <printf>
}
    29fe:	c9                   	leave  
    29ff:	c3                   	ret    
void
rmdot(void)
{
  printf(1, "rmdot test\n");
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    2a00:	c7 44 24 04 74 4a 00 	movl   $0x4a74,0x4(%esp)
    2a07:	00 
    2a08:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a0f:	e8 68 11 00 00       	call   3b7c <printf>
    exit();
    2a14:	e8 2f 10 00 00       	call   3a48 <exit>
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    exit();
  }
  if(unlink("dots") != 0){
    printf(1, "unlink dots failed!\n");
    2a19:	c7 44 24 04 f5 4a 00 	movl   $0x4af5,0x4(%esp)
    2a20:	00 
    2a21:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a28:	e8 4f 11 00 00       	call   3b7c <printf>
    exit();
    2a2d:	e8 16 10 00 00       	call   3a48 <exit>
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    exit();
  }
  if(unlink("dots/..") == 0){
    printf(1, "unlink dots/.. worked!\n");
    2a32:	c7 44 24 04 dd 4a 00 	movl   $0x4add,0x4(%esp)
    2a39:	00 
    2a3a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a41:	e8 36 11 00 00       	call   3b7c <printf>
    exit();
    2a46:	e8 fd 0f 00 00       	call   3a48 <exit>
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    exit();
  }
  if(unlink("dots/.") == 0){
    printf(1, "unlink dots/. worked!\n");
    2a4b:	c7 44 24 04 be 4a 00 	movl   $0x4abe,0x4(%esp)
    2a52:	00 
    2a53:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a5a:	e8 1d 11 00 00       	call   3b7c <printf>
    exit();
    2a5f:	e8 e4 0f 00 00       	call   3a48 <exit>
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    exit();
  }
  if(chdir("/") != 0){
    printf(1, "chdir / failed\n");
    2a64:	c7 44 24 04 ef 3e 00 	movl   $0x3eef,0x4(%esp)
    2a6b:	00 
    2a6c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a73:	e8 04 11 00 00       	call   3b7c <printf>
    exit();
    2a78:	e8 cb 0f 00 00       	call   3a48 <exit>
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    exit();
  }
  if(unlink("..") == 0){
    printf(1, "rm .. worked!\n");
    2a7d:	c7 44 24 04 a8 4a 00 	movl   $0x4aa8,0x4(%esp)
    2a84:	00 
    2a85:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2a8c:	e8 eb 10 00 00       	call   3b7c <printf>
    exit();
    2a91:	e8 b2 0f 00 00       	call   3a48 <exit>
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    exit();
  }
  if(unlink(".") == 0){
    printf(1, "rm . worked!\n");
    2a96:	c7 44 24 04 9a 4a 00 	movl   $0x4a9a,0x4(%esp)
    2a9d:	00 
    2a9e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2aa5:	e8 d2 10 00 00       	call   3b7c <printf>
    exit();
    2aaa:	e8 99 0f 00 00       	call   3a48 <exit>
  if(mkdir("dots") != 0){
    printf(1, "mkdir dots failed\n");
    exit();
  }
  if(chdir("dots") != 0){
    printf(1, "chdir dots failed\n");
    2aaf:	c7 44 24 04 87 4a 00 	movl   $0x4a87,0x4(%esp)
    2ab6:	00 
    2ab7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2abe:	e8 b9 10 00 00       	call   3b7c <printf>
    exit();
    2ac3:	e8 80 0f 00 00       	call   3a48 <exit>

00002ac8 <dirfile>:
  printf(1, "rmdot ok\n");
}

void
dirfile(void)
{
    2ac8:	55                   	push   %ebp
    2ac9:	89 e5                	mov    %esp,%ebp
    2acb:	53                   	push   %ebx
    2acc:	83 ec 14             	sub    $0x14,%esp
  int fd;

  printf(1, "dir vs file\n");
    2acf:	c7 44 24 04 14 4b 00 	movl   $0x4b14,0x4(%esp)
    2ad6:	00 
    2ad7:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ade:	e8 99 10 00 00       	call   3b7c <printf>

  fd = open("dirfile", O_CREATE);
    2ae3:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2aea:	00 
    2aeb:	c7 04 24 21 4b 00 00 	movl   $0x4b21,(%esp)
    2af2:	e8 91 0f 00 00       	call   3a88 <open>
  if(fd < 0){
    2af7:	85 c0                	test   %eax,%eax
    2af9:	0f 88 4e 01 00 00    	js     2c4d <dirfile+0x185>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
    2aff:	89 04 24             	mov    %eax,(%esp)
    2b02:	e8 69 0f 00 00       	call   3a70 <close>
  if(chdir("dirfile") == 0){
    2b07:	c7 04 24 21 4b 00 00 	movl   $0x4b21,(%esp)
    2b0e:	e8 a5 0f 00 00       	call   3ab8 <chdir>
    2b13:	85 c0                	test   %eax,%eax
    2b15:	0f 84 19 01 00 00    	je     2c34 <dirfile+0x16c>
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
    2b1b:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2b22:	00 
    2b23:	c7 04 24 5a 4b 00 00 	movl   $0x4b5a,(%esp)
    2b2a:	e8 59 0f 00 00       	call   3a88 <open>
  if(fd >= 0){
    2b2f:	85 c0                	test   %eax,%eax
    2b31:	0f 89 e4 00 00 00    	jns    2c1b <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", O_CREATE);
    2b37:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2b3e:	00 
    2b3f:	c7 04 24 5a 4b 00 00 	movl   $0x4b5a,(%esp)
    2b46:	e8 3d 0f 00 00       	call   3a88 <open>
  if(fd >= 0){
    2b4b:	85 c0                	test   %eax,%eax
    2b4d:	0f 89 c8 00 00 00    	jns    2c1b <dirfile+0x153>
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    2b53:	c7 04 24 5a 4b 00 00 	movl   $0x4b5a,(%esp)
    2b5a:	e8 51 0f 00 00       	call   3ab0 <mkdir>
    2b5f:	85 c0                	test   %eax,%eax
    2b61:	0f 84 7c 01 00 00    	je     2ce3 <dirfile+0x21b>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    2b67:	c7 04 24 5a 4b 00 00 	movl   $0x4b5a,(%esp)
    2b6e:	e8 25 0f 00 00       	call   3a98 <unlink>
    2b73:	85 c0                	test   %eax,%eax
    2b75:	0f 84 4f 01 00 00    	je     2cca <dirfile+0x202>
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    2b7b:	c7 44 24 04 5a 4b 00 	movl   $0x4b5a,0x4(%esp)
    2b82:	00 
    2b83:	c7 04 24 be 4b 00 00 	movl   $0x4bbe,(%esp)
    2b8a:	e8 19 0f 00 00       	call   3aa8 <link>
    2b8f:	85 c0                	test   %eax,%eax
    2b91:	0f 84 1a 01 00 00    	je     2cb1 <dirfile+0x1e9>
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    2b97:	c7 04 24 21 4b 00 00 	movl   $0x4b21,(%esp)
    2b9e:	e8 f5 0e 00 00       	call   3a98 <unlink>
    2ba3:	85 c0                	test   %eax,%eax
    2ba5:	0f 85 ed 00 00 00    	jne    2c98 <dirfile+0x1d0>
    printf(1, "unlink dirfile failed!\n");
    exit();
  }

  fd = open(".", O_RDWR);
    2bab:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
    2bb2:	00 
    2bb3:	c7 04 24 1a 47 00 00 	movl   $0x471a,(%esp)
    2bba:	e8 c9 0e 00 00       	call   3a88 <open>
  if(fd >= 0){
    2bbf:	85 c0                	test   %eax,%eax
    2bc1:	0f 89 b8 00 00 00    	jns    2c7f <dirfile+0x1b7>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
    2bc7:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    2bce:	00 
    2bcf:	c7 04 24 1a 47 00 00 	movl   $0x471a,(%esp)
    2bd6:	e8 ad 0e 00 00       	call   3a88 <open>
    2bdb:	89 c3                	mov    %eax,%ebx
  if(write(fd, "x", 1) > 0){
    2bdd:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    2be4:	00 
    2be5:	c7 44 24 04 fd 47 00 	movl   $0x47fd,0x4(%esp)
    2bec:	00 
    2bed:	89 04 24             	mov    %eax,(%esp)
    2bf0:	e8 73 0e 00 00       	call   3a68 <write>
    2bf5:	85 c0                	test   %eax,%eax
    2bf7:	7f 6d                	jg     2c66 <dirfile+0x19e>
    printf(1, "write . succeeded!\n");
    exit();
  }
  close(fd);
    2bf9:	89 1c 24             	mov    %ebx,(%esp)
    2bfc:	e8 6f 0e 00 00       	call   3a70 <close>

  printf(1, "dir vs file OK\n");
    2c01:	c7 44 24 04 f1 4b 00 	movl   $0x4bf1,0x4(%esp)
    2c08:	00 
    2c09:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c10:	e8 67 0f 00 00       	call   3b7c <printf>
}
    2c15:	83 c4 14             	add    $0x14,%esp
    2c18:	5b                   	pop    %ebx
    2c19:	5d                   	pop    %ebp
    2c1a:	c3                   	ret    
    printf(1, "chdir dirfile succeeded!\n");
    exit();
  }
  fd = open("dirfile/xx", 0);
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    2c1b:	c7 44 24 04 65 4b 00 	movl   $0x4b65,0x4(%esp)
    2c22:	00 
    2c23:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c2a:	e8 4d 0f 00 00       	call   3b7c <printf>
    exit();
    2c2f:	e8 14 0e 00 00       	call   3a48 <exit>
    printf(1, "create dirfile failed\n");
    exit();
  }
  close(fd);
  if(chdir("dirfile") == 0){
    printf(1, "chdir dirfile succeeded!\n");
    2c34:	c7 44 24 04 40 4b 00 	movl   $0x4b40,0x4(%esp)
    2c3b:	00 
    2c3c:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c43:	e8 34 0f 00 00       	call   3b7c <printf>
    exit();
    2c48:	e8 fb 0d 00 00       	call   3a48 <exit>

  printf(1, "dir vs file\n");

  fd = open("dirfile", O_CREATE);
  if(fd < 0){
    printf(1, "create dirfile failed\n");
    2c4d:	c7 44 24 04 29 4b 00 	movl   $0x4b29,0x4(%esp)
    2c54:	00 
    2c55:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c5c:	e8 1b 0f 00 00       	call   3b7c <printf>
    exit();
    2c61:	e8 e2 0d 00 00       	call   3a48 <exit>
    printf(1, "open . for writing succeeded!\n");
    exit();
  }
  fd = open(".", 0);
  if(write(fd, "x", 1) > 0){
    printf(1, "write . succeeded!\n");
    2c66:	c7 44 24 04 dd 4b 00 	movl   $0x4bdd,0x4(%esp)
    2c6d:	00 
    2c6e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c75:	e8 02 0f 00 00       	call   3b7c <printf>
    exit();
    2c7a:	e8 c9 0d 00 00       	call   3a48 <exit>
    exit();
  }

  fd = open(".", O_RDWR);
  if(fd >= 0){
    printf(1, "open . for writing succeeded!\n");
    2c7f:	c7 44 24 04 d4 53 00 	movl   $0x53d4,0x4(%esp)
    2c86:	00 
    2c87:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2c8e:	e8 e9 0e 00 00       	call   3b7c <printf>
    exit();
    2c93:	e8 b0 0d 00 00       	call   3a48 <exit>
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile") != 0){
    printf(1, "unlink dirfile failed!\n");
    2c98:	c7 44 24 04 c5 4b 00 	movl   $0x4bc5,0x4(%esp)
    2c9f:	00 
    2ca0:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ca7:	e8 d0 0e 00 00       	call   3b7c <printf>
    exit();
    2cac:	e8 97 0d 00 00       	call   3a48 <exit>
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    exit();
  }
  if(link("README", "dirfile/xx") == 0){
    printf(1, "link to dirfile/xx succeeded!\n");
    2cb1:	c7 44 24 04 b4 53 00 	movl   $0x53b4,0x4(%esp)
    2cb8:	00 
    2cb9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cc0:	e8 b7 0e 00 00       	call   3b7c <printf>
    exit();
    2cc5:	e8 7e 0d 00 00       	call   3a48 <exit>
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    exit();
  }
  if(unlink("dirfile/xx") == 0){
    printf(1, "unlink dirfile/xx succeeded!\n");
    2cca:	c7 44 24 04 a0 4b 00 	movl   $0x4ba0,0x4(%esp)
    2cd1:	00 
    2cd2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cd9:	e8 9e 0e 00 00       	call   3b7c <printf>
    exit();
    2cde:	e8 65 0d 00 00       	call   3a48 <exit>
  if(fd >= 0){
    printf(1, "create dirfile/xx succeeded!\n");
    exit();
  }
  if(mkdir("dirfile/xx") == 0){
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2ce3:	c7 44 24 04 83 4b 00 	movl   $0x4b83,0x4(%esp)
    2cea:	00 
    2ceb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2cf2:	e8 85 0e 00 00       	call   3b7c <printf>
    exit();
    2cf7:	e8 4c 0d 00 00       	call   3a48 <exit>

00002cfc <iref>:
}

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2cfc:	55                   	push   %ebp
    2cfd:	89 e5                	mov    %esp,%ebp
    2cff:	53                   	push   %ebx
    2d00:	83 ec 14             	sub    $0x14,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2d03:	c7 44 24 04 01 4c 00 	movl   $0x4c01,0x4(%esp)
    2d0a:	00 
    2d0b:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2d12:	e8 65 0e 00 00       	call   3b7c <printf>
    2d17:	bb 33 00 00 00       	mov    $0x33,%ebx

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
    2d1c:	c7 04 24 12 4c 00 00 	movl   $0x4c12,(%esp)
    2d23:	e8 88 0d 00 00       	call   3ab0 <mkdir>
    2d28:	85 c0                	test   %eax,%eax
    2d2a:	0f 85 ad 00 00 00    	jne    2ddd <iref+0xe1>
      printf(1, "mkdir irefd failed\n");
      exit();
    }
    if(chdir("irefd") != 0){
    2d30:	c7 04 24 12 4c 00 00 	movl   $0x4c12,(%esp)
    2d37:	e8 7c 0d 00 00       	call   3ab8 <chdir>
    2d3c:	85 c0                	test   %eax,%eax
    2d3e:	0f 85 b2 00 00 00    	jne    2df6 <iref+0xfa>
      printf(1, "chdir irefd failed\n");
      exit();
    }

    mkdir("");
    2d44:	c7 04 24 c7 42 00 00 	movl   $0x42c7,(%esp)
    2d4b:	e8 60 0d 00 00       	call   3ab0 <mkdir>
    link("README", "");
    2d50:	c7 44 24 04 c7 42 00 	movl   $0x42c7,0x4(%esp)
    2d57:	00 
    2d58:	c7 04 24 be 4b 00 00 	movl   $0x4bbe,(%esp)
    2d5f:	e8 44 0d 00 00       	call   3aa8 <link>
    fd = open("", O_CREATE);
    2d64:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2d6b:	00 
    2d6c:	c7 04 24 c7 42 00 00 	movl   $0x42c7,(%esp)
    2d73:	e8 10 0d 00 00       	call   3a88 <open>
    if(fd >= 0)
    2d78:	85 c0                	test   %eax,%eax
    2d7a:	78 08                	js     2d84 <iref+0x88>
      close(fd);
    2d7c:	89 04 24             	mov    %eax,(%esp)
    2d7f:	e8 ec 0c 00 00       	call   3a70 <close>
    fd = open("xx", O_CREATE);
    2d84:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    2d8b:	00 
    2d8c:	c7 04 24 fc 47 00 00 	movl   $0x47fc,(%esp)
    2d93:	e8 f0 0c 00 00       	call   3a88 <open>
    if(fd >= 0)
    2d98:	85 c0                	test   %eax,%eax
    2d9a:	78 08                	js     2da4 <iref+0xa8>
      close(fd);
    2d9c:	89 04 24             	mov    %eax,(%esp)
    2d9f:	e8 cc 0c 00 00       	call   3a70 <close>
    unlink("xx");
    2da4:	c7 04 24 fc 47 00 00 	movl   $0x47fc,(%esp)
    2dab:	e8 e8 0c 00 00       	call   3a98 <unlink>
  int i, fd;

  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2db0:	4b                   	dec    %ebx
    2db1:	0f 85 65 ff ff ff    	jne    2d1c <iref+0x20>
    if(fd >= 0)
      close(fd);
    unlink("xx");
  }

  chdir("/");
    2db7:	c7 04 24 ed 3e 00 00 	movl   $0x3eed,(%esp)
    2dbe:	e8 f5 0c 00 00       	call   3ab8 <chdir>
  printf(1, "empty file name OK\n");
    2dc3:	c7 44 24 04 40 4c 00 	movl   $0x4c40,0x4(%esp)
    2dca:	00 
    2dcb:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dd2:	e8 a5 0d 00 00       	call   3b7c <printf>
}
    2dd7:	83 c4 14             	add    $0x14,%esp
    2dda:	5b                   	pop    %ebx
    2ddb:	5d                   	pop    %ebp
    2ddc:	c3                   	ret    
  printf(1, "empty file name\n");

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    if(mkdir("irefd") != 0){
      printf(1, "mkdir irefd failed\n");
    2ddd:	c7 44 24 04 18 4c 00 	movl   $0x4c18,0x4(%esp)
    2de4:	00 
    2de5:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2dec:	e8 8b 0d 00 00       	call   3b7c <printf>
      exit();
    2df1:	e8 52 0c 00 00       	call   3a48 <exit>
    }
    if(chdir("irefd") != 0){
      printf(1, "chdir irefd failed\n");
    2df6:	c7 44 24 04 2c 4c 00 	movl   $0x4c2c,0x4(%esp)
    2dfd:	00 
    2dfe:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e05:	e8 72 0d 00 00       	call   3b7c <printf>
      exit();
    2e0a:	e8 39 0c 00 00       	call   3a48 <exit>
    2e0f:	90                   	nop

00002e10 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    2e10:	55                   	push   %ebp
    2e11:	89 e5                	mov    %esp,%ebp
    2e13:	53                   	push   %ebx
    2e14:	83 ec 14             	sub    $0x14,%esp
  int n, pid;

  printf(1, "fork test\n");
    2e17:	c7 44 24 04 54 4c 00 	movl   $0x4c54,0x4(%esp)
    2e1e:	00 
    2e1f:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e26:	e8 51 0d 00 00       	call   3b7c <printf>

  for(n=0; n<1000; n++){
    2e2b:	31 db                	xor    %ebx,%ebx
    2e2d:	eb 0c                	jmp    2e3b <forktest+0x2b>
    2e2f:	90                   	nop
    pid = fork();
    if(pid < 0)
      break;
    if(pid == 0)
    2e30:	74 73                	je     2ea5 <forktest+0x95>
{
  int n, pid;

  printf(1, "fork test\n");

  for(n=0; n<1000; n++){
    2e32:	43                   	inc    %ebx
    2e33:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
    2e39:	74 3d                	je     2e78 <forktest+0x68>
    pid = fork();
    2e3b:	e8 00 0c 00 00       	call   3a40 <fork>
    if(pid < 0)
    2e40:	85 c0                	test   %eax,%eax
    2e42:	79 ec                	jns    2e30 <forktest+0x20>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2e44:	85 db                	test   %ebx,%ebx
    2e46:	74 0c                	je     2e54 <forktest+0x44>
    if(wait() < 0){
    2e48:	e8 03 0c 00 00       	call   3a50 <wait>
    2e4d:	85 c0                	test   %eax,%eax
    2e4f:	78 40                	js     2e91 <forktest+0x81>
  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    exit();
  }

  for(; n > 0; n--){
    2e51:	4b                   	dec    %ebx
    2e52:	75 f4                	jne    2e48 <forktest+0x38>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
    2e54:	e8 f7 0b 00 00       	call   3a50 <wait>
    2e59:	40                   	inc    %eax
    2e5a:	75 4e                	jne    2eaa <forktest+0x9a>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
    2e5c:	c7 44 24 04 86 4c 00 	movl   $0x4c86,0x4(%esp)
    2e63:	00 
    2e64:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e6b:	e8 0c 0d 00 00       	call   3b7c <printf>
}
    2e70:	83 c4 14             	add    $0x14,%esp
    2e73:	5b                   	pop    %ebx
    2e74:	5d                   	pop    %ebp
    2e75:	c3                   	ret    
    2e76:	66 90                	xchg   %ax,%ax
    if(pid == 0)
      exit();
  }

  if(n == 1000){
    printf(1, "fork claimed to work 1000 times!\n");
    2e78:	c7 44 24 04 f4 53 00 	movl   $0x53f4,0x4(%esp)
    2e7f:	00 
    2e80:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2e87:	e8 f0 0c 00 00       	call   3b7c <printf>
    exit();
    2e8c:	e8 b7 0b 00 00       	call   3a48 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
      printf(1, "wait stopped early\n");
    2e91:	c7 44 24 04 5f 4c 00 	movl   $0x4c5f,0x4(%esp)
    2e98:	00 
    2e99:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2ea0:	e8 d7 0c 00 00       	call   3b7c <printf>
      exit();
    2ea5:	e8 9e 0b 00 00       	call   3a48 <exit>
    }
  }

  if(wait() != -1){
    printf(1, "wait got too many\n");
    2eaa:	c7 44 24 04 73 4c 00 	movl   $0x4c73,0x4(%esp)
    2eb1:	00 
    2eb2:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2eb9:	e8 be 0c 00 00       	call   3b7c <printf>
    exit();
    2ebe:	e8 85 0b 00 00       	call   3a48 <exit>
    2ec3:	90                   	nop

00002ec4 <sbrktest>:
  printf(1, "fork test OK\n");
}

void
sbrktest(void)
{
    2ec4:	55                   	push   %ebp
    2ec5:	89 e5                	mov    %esp,%ebp
    2ec7:	57                   	push   %edi
    2ec8:	56                   	push   %esi
    2ec9:	53                   	push   %ebx
    2eca:	83 ec 6c             	sub    $0x6c,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    2ecd:	c7 44 24 04 94 4c 00 	movl   $0x4c94,0x4(%esp)
    2ed4:	00 
    2ed5:	a1 20 5f 00 00       	mov    0x5f20,%eax
    2eda:	89 04 24             	mov    %eax,(%esp)
    2edd:	e8 9a 0c 00 00       	call   3b7c <printf>
  oldbrk = sbrk(0);
    2ee2:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ee9:	e8 e2 0b 00 00       	call   3ad0 <sbrk>
    2eee:	89 45 a4             	mov    %eax,-0x5c(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    2ef1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ef8:	e8 d3 0b 00 00       	call   3ad0 <sbrk>
    2efd:	89 c3                	mov    %eax,%ebx
  int i;
  for(i = 0; i < 5000; i++){
    2eff:	31 f6                	xor    %esi,%esi
    2f01:	8d 76 00             	lea    0x0(%esi),%esi
    b = sbrk(1);
    2f04:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f0b:	e8 c0 0b 00 00       	call   3ad0 <sbrk>
    2f10:	89 c7                	mov    %eax,%edi
    if(b != a){
    2f12:	39 d8                	cmp    %ebx,%eax
    2f14:	0f 85 6c 02 00 00    	jne    3186 <sbrktest+0x2c2>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
      exit();
    }
    *b = 1;
    2f1a:	c6 03 01             	movb   $0x1,(%ebx)
    a = b + 1;
    2f1d:	43                   	inc    %ebx
  oldbrk = sbrk(0);

  // can one sbrk() less than a page?
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    2f1e:	46                   	inc    %esi
    2f1f:	81 fe 88 13 00 00    	cmp    $0x1388,%esi
    2f25:	75 dd                	jne    2f04 <sbrktest+0x40>
      exit();
    }
    *b = 1;
    a = b + 1;
  }
  pid = fork();
    2f27:	e8 14 0b 00 00       	call   3a40 <fork>
    2f2c:	89 c3                	mov    %eax,%ebx
  if(pid < 0){
    2f2e:	85 c0                	test   %eax,%eax
    2f30:	0f 88 be 03 00 00    	js     32f4 <sbrktest+0x430>
    printf(stdout, "sbrk test fork failed\n");
    exit();
  }
  c = sbrk(1);
    2f36:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f3d:	e8 8e 0b 00 00       	call   3ad0 <sbrk>
  c = sbrk(1);
    2f42:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    2f49:	e8 82 0b 00 00       	call   3ad0 <sbrk>
  if(c != a + 1){
    2f4e:	8d 57 02             	lea    0x2(%edi),%edx
    2f51:	39 d0                	cmp    %edx,%eax
    2f53:	0f 85 81 03 00 00    	jne    32da <sbrktest+0x416>
    printf(stdout, "sbrk test failed post-fork\n");
    exit();
  }
  if(pid == 0)
    2f59:	85 db                	test   %ebx,%ebx
    2f5b:	0f 84 74 03 00 00    	je     32d5 <sbrktest+0x411>
    exit();
  wait();
    2f61:	e8 ea 0a 00 00       	call   3a50 <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    2f66:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f6d:	e8 5e 0b 00 00       	call   3ad0 <sbrk>
    2f72:	89 c3                	mov    %eax,%ebx
  amt = (BIG) - (uint)a;
    2f74:	ba 00 00 40 06       	mov    $0x6400000,%edx
    2f79:	29 c2                	sub    %eax,%edx
  p = sbrk(amt);
    2f7b:	89 14 24             	mov    %edx,(%esp)
    2f7e:	e8 4d 0b 00 00       	call   3ad0 <sbrk>
  if (p != a) {
    2f83:	39 d8                	cmp    %ebx,%eax
    2f85:	0f 85 35 03 00 00    	jne    32c0 <sbrktest+0x3fc>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    exit();
  }
  lastaddr = (char*) (BIG-1);
  *lastaddr = 99;
    2f8b:	c6 05 ff ff 3f 06 63 	movb   $0x63,0x63fffff

  // can one de-allocate?
  a = sbrk(0);
    2f92:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2f99:	e8 32 0b 00 00       	call   3ad0 <sbrk>
    2f9e:	89 c3                	mov    %eax,%ebx
  c = sbrk(-4096);
    2fa0:	c7 04 24 00 f0 ff ff 	movl   $0xfffff000,(%esp)
    2fa7:	e8 24 0b 00 00       	call   3ad0 <sbrk>
  if(c == (char*)0xffffffff){
    2fac:	40                   	inc    %eax
    2fad:	0f 84 f3 02 00 00    	je     32a6 <sbrktest+0x3e2>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
    2fb3:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fba:	e8 11 0b 00 00       	call   3ad0 <sbrk>
  if(c != a - 4096){
    2fbf:	8d 93 00 f0 ff ff    	lea    -0x1000(%ebx),%edx
    2fc5:	39 d0                	cmp    %edx,%eax
    2fc7:	0f 85 b7 02 00 00    	jne    3284 <sbrktest+0x3c0>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    exit();
  }

  // can one re-allocate that page?
  a = sbrk(0);
    2fcd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2fd4:	e8 f7 0a 00 00       	call   3ad0 <sbrk>
    2fd9:	89 c6                	mov    %eax,%esi
  c = sbrk(4096);
    2fdb:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    2fe2:	e8 e9 0a 00 00       	call   3ad0 <sbrk>
    2fe7:	89 c3                	mov    %eax,%ebx
  if(c != a || sbrk(0) != a + 4096){
    2fe9:	39 f0                	cmp    %esi,%eax
    2feb:	0f 85 71 02 00 00    	jne    3262 <sbrktest+0x39e>
    2ff1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    2ff8:	e8 d3 0a 00 00       	call   3ad0 <sbrk>
    2ffd:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
    3003:	39 d0                	cmp    %edx,%eax
    3005:	0f 85 57 02 00 00    	jne    3262 <sbrktest+0x39e>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    300b:	80 3d ff ff 3f 06 63 	cmpb   $0x63,0x63fffff
    3012:	0f 84 30 02 00 00    	je     3248 <sbrktest+0x384>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    exit();
  }

  a = sbrk(0);
    3018:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    301f:	e8 ac 0a 00 00       	call   3ad0 <sbrk>
    3024:	89 c3                	mov    %eax,%ebx
  c = sbrk(-(sbrk(0) - oldbrk));
    3026:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    302d:	e8 9e 0a 00 00       	call   3ad0 <sbrk>
    3032:	8b 4d a4             	mov    -0x5c(%ebp),%ecx
    3035:	29 c1                	sub    %eax,%ecx
    3037:	89 0c 24             	mov    %ecx,(%esp)
    303a:	e8 91 0a 00 00       	call   3ad0 <sbrk>
  if(c != a){
    303f:	39 d8                	cmp    %ebx,%eax
    3041:	0f 85 df 01 00 00    	jne    3226 <sbrktest+0x362>
    3047:	bb 00 00 00 80       	mov    $0x80000000,%ebx
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    304c:	e8 77 0a 00 00       	call   3ac8 <getpid>
    3051:	89 c6                	mov    %eax,%esi
    pid = fork();
    3053:	e8 e8 09 00 00       	call   3a40 <fork>
    if(pid < 0){
    3058:	85 c0                	test   %eax,%eax
    305a:	0f 88 ac 01 00 00    	js     320c <sbrktest+0x348>
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
    3060:	0f 84 79 01 00 00    	je     31df <sbrktest+0x31b>
      printf(stdout, "oops could read %x = %x\n", a, *a);
      kill(ppid);
      exit();
    }
    wait();
    3066:	e8 e5 09 00 00       	call   3a50 <wait>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    exit();
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    306b:	81 c3 50 c3 00 00    	add    $0xc350,%ebx
    3071:	81 fb 80 84 1e 80    	cmp    $0x801e8480,%ebx
    3077:	75 d3                	jne    304c <sbrktest+0x188>
    wait();
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    3079:	8d 45 b8             	lea    -0x48(%ebp),%eax
    307c:	89 04 24             	mov    %eax,(%esp)
    307f:	e8 d4 09 00 00       	call   3a58 <pipe>
    3084:	85 c0                	test   %eax,%eax
    3086:	0f 85 3a 01 00 00    	jne    31c6 <sbrktest+0x302>
    308c:	8d 5d e8             	lea    -0x18(%ebp),%ebx
    308f:	8d 75 c0             	lea    -0x40(%ebp),%esi
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
    3092:	8d 7d b7             	lea    -0x49(%ebp),%edi
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
    3095:	e8 a6 09 00 00       	call   3a40 <fork>
    309a:	89 06                	mov    %eax,(%esi)
    309c:	85 c0                	test   %eax,%eax
    309e:	0f 84 9b 00 00 00    	je     313f <sbrktest+0x27b>
      sbrk(BIG - (uint)sbrk(0));
      write(fds[1], "x", 1);
      // sit around until killed
      for(;;) sleep(1000);
    }
    if(pids[i] != -1)
    30a4:	40                   	inc    %eax
    30a5:	74 17                	je     30be <sbrktest+0x1fa>
      read(fds[0], &scratch, 1);
    30a7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    30ae:	00 
    30af:	89 7c 24 04          	mov    %edi,0x4(%esp)
    30b3:	8b 45 b8             	mov    -0x48(%ebp),%eax
    30b6:	89 04 24             	mov    %eax,(%esp)
    30b9:	e8 a2 09 00 00       	call   3a60 <read>
    30be:	83 c6 04             	add    $0x4,%esi
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    30c1:	39 de                	cmp    %ebx,%esi
    30c3:	75 d0                	jne    3095 <sbrktest+0x1d1>
    if(pids[i] != -1)
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    30c5:	c7 04 24 00 10 00 00 	movl   $0x1000,(%esp)
    30cc:	e8 ff 09 00 00       	call   3ad0 <sbrk>
    30d1:	89 c7                	mov    %eax,%edi
    30d3:	8d 75 c0             	lea    -0x40(%ebp),%esi
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if(pids[i] == -1)
    30d6:	8b 06                	mov    (%esi),%eax
    30d8:	83 f8 ff             	cmp    $0xffffffff,%eax
    30db:	74 0d                	je     30ea <sbrktest+0x226>
      continue;
    kill(pids[i]);
    30dd:	89 04 24             	mov    %eax,(%esp)
    30e0:	e8 93 09 00 00       	call   3a78 <kill>
    wait();
    30e5:	e8 66 09 00 00       	call   3a50 <wait>
    30ea:	83 c6 04             	add    $0x4,%esi
      read(fds[0], &scratch, 1);
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    30ed:	39 f3                	cmp    %esi,%ebx
    30ef:	75 e5                	jne    30d6 <sbrktest+0x212>
    if(pids[i] == -1)
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    30f1:	47                   	inc    %edi
    30f2:	0f 84 b4 00 00 00    	je     31ac <sbrktest+0x2e8>
    printf(stdout, "failed sbrk leaked memory\n");
    exit();
  }

  if(sbrk(0) > oldbrk)
    30f8:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    30ff:	e8 cc 09 00 00       	call   3ad0 <sbrk>
    3104:	39 45 a4             	cmp    %eax,-0x5c(%ebp)
    3107:	73 19                	jae    3122 <sbrktest+0x25e>
    sbrk(-(sbrk(0) - oldbrk));
    3109:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3110:	e8 bb 09 00 00       	call   3ad0 <sbrk>
    3115:	8b 7d a4             	mov    -0x5c(%ebp),%edi
    3118:	29 c7                	sub    %eax,%edi
    311a:	89 3c 24             	mov    %edi,(%esp)
    311d:	e8 ae 09 00 00       	call   3ad0 <sbrk>

  printf(stdout, "sbrk test OK\n");
    3122:	c7 44 24 04 3c 4d 00 	movl   $0x4d3c,0x4(%esp)
    3129:	00 
    312a:	a1 20 5f 00 00       	mov    0x5f20,%eax
    312f:	89 04 24             	mov    %eax,(%esp)
    3132:	e8 45 0a 00 00       	call   3b7c <printf>
}
    3137:	83 c4 6c             	add    $0x6c,%esp
    313a:	5b                   	pop    %ebx
    313b:	5e                   	pop    %esi
    313c:	5f                   	pop    %edi
    313d:	5d                   	pop    %ebp
    313e:	c3                   	ret    
    exit();
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    if((pids[i] = fork()) == 0){
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    313f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3146:	e8 85 09 00 00       	call   3ad0 <sbrk>
    314b:	ba 00 00 40 06       	mov    $0x6400000,%edx
    3150:	29 c2                	sub    %eax,%edx
    3152:	89 14 24             	mov    %edx,(%esp)
    3155:	e8 76 09 00 00       	call   3ad0 <sbrk>
      write(fds[1], "x", 1);
    315a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3161:	00 
    3162:	c7 44 24 04 fd 47 00 	movl   $0x47fd,0x4(%esp)
    3169:	00 
    316a:	8b 45 bc             	mov    -0x44(%ebp),%eax
    316d:	89 04 24             	mov    %eax,(%esp)
    3170:	e8 f3 08 00 00       	call   3a68 <write>
    3175:	8d 76 00             	lea    0x0(%esi),%esi
      // sit around until killed
      for(;;) sleep(1000);
    3178:	c7 04 24 e8 03 00 00 	movl   $0x3e8,(%esp)
    317f:	e8 54 09 00 00       	call   3ad8 <sleep>
    3184:	eb f2                	jmp    3178 <sbrktest+0x2b4>
  a = sbrk(0);
  int i;
  for(i = 0; i < 5000; i++){
    b = sbrk(1);
    if(b != a){
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    3186:	89 44 24 10          	mov    %eax,0x10(%esp)
    318a:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    318e:	89 74 24 08          	mov    %esi,0x8(%esp)
    3192:	c7 44 24 04 9f 4c 00 	movl   $0x4c9f,0x4(%esp)
    3199:	00 
    319a:	a1 20 5f 00 00       	mov    0x5f20,%eax
    319f:	89 04 24             	mov    %eax,(%esp)
    31a2:	e8 d5 09 00 00       	call   3b7c <printf>
      exit();
    31a7:	e8 9c 08 00 00       	call   3a48 <exit>
      continue;
    kill(pids[i]);
    wait();
  }
  if(c == (char*)0xffffffff){
    printf(stdout, "failed sbrk leaked memory\n");
    31ac:	c7 44 24 04 21 4d 00 	movl   $0x4d21,0x4(%esp)
    31b3:	00 
    31b4:	a1 20 5f 00 00       	mov    0x5f20,%eax
    31b9:	89 04 24             	mov    %eax,(%esp)
    31bc:	e8 bb 09 00 00       	call   3b7c <printf>
    exit();
    31c1:	e8 82 08 00 00       	call   3a48 <exit>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    printf(1, "pipe() failed\n");
    31c6:	c7 44 24 04 dd 41 00 	movl   $0x41dd,0x4(%esp)
    31cd:	00 
    31ce:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    31d5:	e8 a2 09 00 00       	call   3b7c <printf>
    exit();
    31da:	e8 69 08 00 00       	call   3a48 <exit>
    if(pid < 0){
      printf(stdout, "fork failed\n");
      exit();
    }
    if(pid == 0){
      printf(stdout, "oops could read %x = %x\n", a, *a);
    31df:	0f be 03             	movsbl (%ebx),%eax
    31e2:	89 44 24 0c          	mov    %eax,0xc(%esp)
    31e6:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    31ea:	c7 44 24 04 08 4d 00 	movl   $0x4d08,0x4(%esp)
    31f1:	00 
    31f2:	a1 20 5f 00 00       	mov    0x5f20,%eax
    31f7:	89 04 24             	mov    %eax,(%esp)
    31fa:	e8 7d 09 00 00       	call   3b7c <printf>
      kill(ppid);
    31ff:	89 34 24             	mov    %esi,(%esp)
    3202:	e8 71 08 00 00       	call   3a78 <kill>
      exit();
    3207:	e8 3c 08 00 00       	call   3a48 <exit>
  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    ppid = getpid();
    pid = fork();
    if(pid < 0){
      printf(stdout, "fork failed\n");
    320c:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    3213:	00 
    3214:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3219:	89 04 24             	mov    %eax,(%esp)
    321c:	e8 5b 09 00 00       	call   3b7c <printf>
      exit();
    3221:	e8 22 08 00 00       	call   3a48 <exit>
  }

  a = sbrk(0);
  c = sbrk(-(sbrk(0) - oldbrk));
  if(c != a){
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    3226:	89 44 24 0c          	mov    %eax,0xc(%esp)
    322a:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    322e:	c7 44 24 04 e8 54 00 	movl   $0x54e8,0x4(%esp)
    3235:	00 
    3236:	a1 20 5f 00 00       	mov    0x5f20,%eax
    323b:	89 04 24             	mov    %eax,(%esp)
    323e:	e8 39 09 00 00       	call   3b7c <printf>
    exit();
    3243:	e8 00 08 00 00       	call   3a48 <exit>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    exit();
  }
  if(*lastaddr == 99){
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3248:	c7 44 24 04 b8 54 00 	movl   $0x54b8,0x4(%esp)
    324f:	00 
    3250:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3255:	89 04 24             	mov    %eax,(%esp)
    3258:	e8 1f 09 00 00       	call   3b7c <printf>
    exit();
    325d:	e8 e6 07 00 00       	call   3a48 <exit>

  // can one re-allocate that page?
  a = sbrk(0);
  c = sbrk(4096);
  if(c != a || sbrk(0) != a + 4096){
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3262:	89 5c 24 0c          	mov    %ebx,0xc(%esp)
    3266:	89 74 24 08          	mov    %esi,0x8(%esp)
    326a:	c7 44 24 04 90 54 00 	movl   $0x5490,0x4(%esp)
    3271:	00 
    3272:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3277:	89 04 24             	mov    %eax,(%esp)
    327a:	e8 fd 08 00 00       	call   3b7c <printf>
    exit();
    327f:	e8 c4 07 00 00       	call   3a48 <exit>
    printf(stdout, "sbrk could not deallocate\n");
    exit();
  }
  c = sbrk(0);
  if(c != a - 4096){
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    3284:	89 44 24 0c          	mov    %eax,0xc(%esp)
    3288:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    328c:	c7 44 24 04 58 54 00 	movl   $0x5458,0x4(%esp)
    3293:	00 
    3294:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3299:	89 04 24             	mov    %eax,(%esp)
    329c:	e8 db 08 00 00       	call   3b7c <printf>
    exit();
    32a1:	e8 a2 07 00 00       	call   3a48 <exit>

  // can one de-allocate?
  a = sbrk(0);
  c = sbrk(-4096);
  if(c == (char*)0xffffffff){
    printf(stdout, "sbrk could not deallocate\n");
    32a6:	c7 44 24 04 ed 4c 00 	movl   $0x4ced,0x4(%esp)
    32ad:	00 
    32ae:	a1 20 5f 00 00       	mov    0x5f20,%eax
    32b3:	89 04 24             	mov    %eax,(%esp)
    32b6:	e8 c1 08 00 00       	call   3b7c <printf>
    exit();
    32bb:	e8 88 07 00 00       	call   3a48 <exit>
#define BIG (100*1024*1024)
  a = sbrk(0);
  amt = (BIG) - (uint)a;
  p = sbrk(amt);
  if (p != a) {
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    32c0:	c7 44 24 04 18 54 00 	movl   $0x5418,0x4(%esp)
    32c7:	00 
    32c8:	a1 20 5f 00 00       	mov    0x5f20,%eax
    32cd:	89 04 24             	mov    %eax,(%esp)
    32d0:	e8 a7 08 00 00       	call   3b7c <printf>
    exit();
    32d5:	e8 6e 07 00 00       	call   3a48 <exit>
    exit();
  }
  c = sbrk(1);
  c = sbrk(1);
  if(c != a + 1){
    printf(stdout, "sbrk test failed post-fork\n");
    32da:	c7 44 24 04 d1 4c 00 	movl   $0x4cd1,0x4(%esp)
    32e1:	00 
    32e2:	a1 20 5f 00 00       	mov    0x5f20,%eax
    32e7:	89 04 24             	mov    %eax,(%esp)
    32ea:	e8 8d 08 00 00       	call   3b7c <printf>
    exit();
    32ef:	e8 54 07 00 00       	call   3a48 <exit>
    *b = 1;
    a = b + 1;
  }
  pid = fork();
  if(pid < 0){
    printf(stdout, "sbrk test fork failed\n");
    32f4:	c7 44 24 04 ba 4c 00 	movl   $0x4cba,0x4(%esp)
    32fb:	00 
    32fc:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3301:	89 04 24             	mov    %eax,(%esp)
    3304:	e8 73 08 00 00       	call   3b7c <printf>
    exit();
    3309:	e8 3a 07 00 00       	call   3a48 <exit>
    330e:	66 90                	xchg   %ax,%ax

00003310 <validateint>:
  printf(stdout, "sbrk test OK\n");
}

void
validateint(int *p)
{
    3310:	55                   	push   %ebp
    3311:	89 e5                	mov    %esp,%ebp
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3313:	5d                   	pop    %ebp
    3314:	c3                   	ret    
    3315:	8d 76 00             	lea    0x0(%esi),%esi

00003318 <validatetest>:

void
validatetest(void)
{
    3318:	55                   	push   %ebp
    3319:	89 e5                	mov    %esp,%ebp
    331b:	56                   	push   %esi
    331c:	53                   	push   %ebx
    331d:	83 ec 10             	sub    $0x10,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    3320:	c7 44 24 04 4a 4d 00 	movl   $0x4d4a,0x4(%esp)
    3327:	00 
    3328:	a1 20 5f 00 00       	mov    0x5f20,%eax
    332d:	89 04 24             	mov    %eax,(%esp)
    3330:	e8 47 08 00 00       	call   3b7c <printf>
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    3335:	31 db                	xor    %ebx,%ebx
    3337:	90                   	nop
    if((pid = fork()) == 0){
    3338:	e8 03 07 00 00       	call   3a40 <fork>
    333d:	89 c6                	mov    %eax,%esi
    333f:	85 c0                	test   %eax,%eax
    3341:	74 77                	je     33ba <validatetest+0xa2>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
      exit();
    }
    sleep(0);
    3343:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    334a:	e8 89 07 00 00       	call   3ad8 <sleep>
    sleep(0);
    334f:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3356:	e8 7d 07 00 00       	call   3ad8 <sleep>
    kill(pid);
    335b:	89 34 24             	mov    %esi,(%esp)
    335e:	e8 15 07 00 00       	call   3a78 <kill>
    wait();
    3363:	e8 e8 06 00 00       	call   3a50 <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3368:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    336c:	c7 04 24 59 4d 00 00 	movl   $0x4d59,(%esp)
    3373:	e8 30 07 00 00       	call   3aa8 <link>
    3378:	40                   	inc    %eax
    3379:	75 2a                	jne    33a5 <validatetest+0x8d>
  uint p;

  printf(stdout, "validate test\n");
  hi = 1100*1024;

  for(p = 0; p <= (uint)hi; p += 4096){
    337b:	81 c3 00 10 00 00    	add    $0x1000,%ebx
    3381:	81 fb 00 40 11 00    	cmp    $0x114000,%ebx
    3387:	75 af                	jne    3338 <validatetest+0x20>
      printf(stdout, "link should not succeed\n");
      exit();
    }
  }

  printf(stdout, "validate ok\n");
    3389:	c7 44 24 04 7d 4d 00 	movl   $0x4d7d,0x4(%esp)
    3390:	00 
    3391:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3396:	89 04 24             	mov    %eax,(%esp)
    3399:	e8 de 07 00 00       	call   3b7c <printf>
}
    339e:	83 c4 10             	add    $0x10,%esp
    33a1:	5b                   	pop    %ebx
    33a2:	5e                   	pop    %esi
    33a3:	5d                   	pop    %ebp
    33a4:	c3                   	ret    
    kill(pid);
    wait();

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
      printf(stdout, "link should not succeed\n");
    33a5:	c7 44 24 04 64 4d 00 	movl   $0x4d64,0x4(%esp)
    33ac:	00 
    33ad:	a1 20 5f 00 00       	mov    0x5f20,%eax
    33b2:	89 04 24             	mov    %eax,(%esp)
    33b5:	e8 c2 07 00 00       	call   3b7c <printf>
      exit();
    33ba:	e8 89 06 00 00       	call   3a48 <exit>
    33bf:	90                   	nop

000033c0 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    33c0:	55                   	push   %ebp
    33c1:	89 e5                	mov    %esp,%ebp
    33c3:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    33c6:	c7 44 24 04 8a 4d 00 	movl   $0x4d8a,0x4(%esp)
    33cd:	00 
    33ce:	a1 20 5f 00 00       	mov    0x5f20,%eax
    33d3:	89 04 24             	mov    %eax,(%esp)
    33d6:	e8 a1 07 00 00       	call   3b7c <printf>
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
    33db:	80 3d e0 5f 00 00 00 	cmpb   $0x0,0x5fe0
    33e2:	75 30                	jne    3414 <bsstest+0x54>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    33e4:	b8 01 00 00 00       	mov    $0x1,%eax
    33e9:	8d 76 00             	lea    0x0(%esi),%esi
    if(uninit[i] != '\0'){
    33ec:	80 b8 e0 5f 00 00 00 	cmpb   $0x0,0x5fe0(%eax)
    33f3:	75 1f                	jne    3414 <bsstest+0x54>
bsstest(void)
{
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    33f5:	40                   	inc    %eax
    33f6:	3d 10 27 00 00       	cmp    $0x2710,%eax
    33fb:	75 ef                	jne    33ec <bsstest+0x2c>
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
      exit();
    }
  }
  printf(stdout, "bss test ok\n");
    33fd:	c7 44 24 04 a5 4d 00 	movl   $0x4da5,0x4(%esp)
    3404:	00 
    3405:	a1 20 5f 00 00       	mov    0x5f20,%eax
    340a:	89 04 24             	mov    %eax,(%esp)
    340d:	e8 6a 07 00 00       	call   3b7c <printf>
}
    3412:	c9                   	leave  
    3413:	c3                   	ret    
  int i;

  printf(stdout, "bss test\n");
  for(i = 0; i < sizeof(uninit); i++){
    if(uninit[i] != '\0'){
      printf(stdout, "bss test failed\n");
    3414:	c7 44 24 04 94 4d 00 	movl   $0x4d94,0x4(%esp)
    341b:	00 
    341c:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3421:	89 04 24             	mov    %eax,(%esp)
    3424:	e8 53 07 00 00       	call   3b7c <printf>
      exit();
    3429:	e8 1a 06 00 00       	call   3a48 <exit>
    342e:	66 90                	xchg   %ax,%ax

00003430 <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    3430:	55                   	push   %ebp
    3431:	89 e5                	mov    %esp,%ebp
    3433:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3436:	c7 04 24 b2 4d 00 00 	movl   $0x4db2,(%esp)
    343d:	e8 56 06 00 00       	call   3a98 <unlink>
  pid = fork();
    3442:	e8 f9 05 00 00       	call   3a40 <fork>
  if(pid == 0){
    3447:	85 c0                	test   %eax,%eax
    3449:	74 3d                	je     3488 <bigargtest+0x58>
    exec("echo", args);
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    344b:	0f 88 cb 00 00 00    	js     351c <bigargtest+0xec>
    printf(stdout, "bigargtest: fork failed\n");
    exit();
  }
  wait();
    3451:	e8 fa 05 00 00       	call   3a50 <wait>
  fd = open("bigarg-ok", 0);
    3456:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    345d:	00 
    345e:	c7 04 24 b2 4d 00 00 	movl   $0x4db2,(%esp)
    3465:	e8 1e 06 00 00       	call   3a88 <open>
  if(fd < 0){
    346a:	85 c0                	test   %eax,%eax
    346c:	0f 88 90 00 00 00    	js     3502 <bigargtest+0xd2>
    printf(stdout, "bigarg test failed!\n");
    exit();
  }
  close(fd);
    3472:	89 04 24             	mov    %eax,(%esp)
    3475:	e8 f6 05 00 00       	call   3a70 <close>
  unlink("bigarg-ok");
    347a:	c7 04 24 b2 4d 00 00 	movl   $0x4db2,(%esp)
    3481:	e8 12 06 00 00       	call   3a98 <unlink>
}
    3486:	c9                   	leave  
    3487:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    3488:	c7 04 85 40 5f 00 00 	movl   $0x550c,0x5f40(,%eax,4)
    348f:	0c 55 00 00 
  unlink("bigarg-ok");
  pid = fork();
  if(pid == 0){
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3493:	40                   	inc    %eax
    3494:	83 f8 1f             	cmp    $0x1f,%eax
    3497:	75 ef                	jne    3488 <bigargtest+0x58>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    args[MAXARG-1] = 0;
    3499:	c7 05 bc 5f 00 00 00 	movl   $0x0,0x5fbc
    34a0:	00 00 00 
    printf(stdout, "bigarg test\n");
    34a3:	c7 44 24 04 bc 4d 00 	movl   $0x4dbc,0x4(%esp)
    34aa:	00 
    34ab:	a1 20 5f 00 00       	mov    0x5f20,%eax
    34b0:	89 04 24             	mov    %eax,(%esp)
    34b3:	e8 c4 06 00 00       	call   3b7c <printf>
    exec("echo", args);
    34b8:	c7 44 24 04 40 5f 00 	movl   $0x5f40,0x4(%esp)
    34bf:	00 
    34c0:	c7 04 24 89 3f 00 00 	movl   $0x3f89,(%esp)
    34c7:	e8 b4 05 00 00       	call   3a80 <exec>
    printf(stdout, "bigarg test ok\n");
    34cc:	c7 44 24 04 c9 4d 00 	movl   $0x4dc9,0x4(%esp)
    34d3:	00 
    34d4:	a1 20 5f 00 00       	mov    0x5f20,%eax
    34d9:	89 04 24             	mov    %eax,(%esp)
    34dc:	e8 9b 06 00 00       	call   3b7c <printf>
    fd = open("bigarg-ok", O_CREATE);
    34e1:	c7 44 24 04 00 02 00 	movl   $0x200,0x4(%esp)
    34e8:	00 
    34e9:	c7 04 24 b2 4d 00 00 	movl   $0x4db2,(%esp)
    34f0:	e8 93 05 00 00       	call   3a88 <open>
    close(fd);
    34f5:	89 04 24             	mov    %eax,(%esp)
    34f8:	e8 73 05 00 00       	call   3a70 <close>
    exit();
    34fd:	e8 46 05 00 00       	call   3a48 <exit>
    exit();
  }
  wait();
  fd = open("bigarg-ok", 0);
  if(fd < 0){
    printf(stdout, "bigarg test failed!\n");
    3502:	c7 44 24 04 f2 4d 00 	movl   $0x4df2,0x4(%esp)
    3509:	00 
    350a:	a1 20 5f 00 00       	mov    0x5f20,%eax
    350f:	89 04 24             	mov    %eax,(%esp)
    3512:	e8 65 06 00 00       	call   3b7c <printf>
    exit();
    3517:	e8 2c 05 00 00       	call   3a48 <exit>
    printf(stdout, "bigarg test ok\n");
    fd = open("bigarg-ok", O_CREATE);
    close(fd);
    exit();
  } else if(pid < 0){
    printf(stdout, "bigargtest: fork failed\n");
    351c:	c7 44 24 04 d9 4d 00 	movl   $0x4dd9,0x4(%esp)
    3523:	00 
    3524:	a1 20 5f 00 00       	mov    0x5f20,%eax
    3529:	89 04 24             	mov    %eax,(%esp)
    352c:	e8 4b 06 00 00       	call   3b7c <printf>
    exit();
    3531:	e8 12 05 00 00       	call   3a48 <exit>
    3536:	66 90                	xchg   %ax,%ax

00003538 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3538:	55                   	push   %ebp
    3539:	89 e5                	mov    %esp,%ebp
    353b:	57                   	push   %edi
    353c:	56                   	push   %esi
    353d:	53                   	push   %ebx
    353e:	83 ec 5c             	sub    $0x5c,%esp
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");
    3541:	c7 44 24 04 07 4e 00 	movl   $0x4e07,0x4(%esp)
    3548:	00 
    3549:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3550:	e8 27 06 00 00       	call   3b7c <printf>

  for(nfiles = 0; ; nfiles++){
    3555:	31 f6                	xor    %esi,%esi
    3557:	90                   	nop
    char name[64];
    name[0] = 'f';
    3558:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    355c:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3561:	f7 ee                	imul   %esi
    3563:	89 d0                	mov    %edx,%eax
    3565:	c1 f8 06             	sar    $0x6,%eax
    3568:	89 f1                	mov    %esi,%ecx
    356a:	c1 f9 1f             	sar    $0x1f,%ecx
    356d:	29 c8                	sub    %ecx,%eax
    356f:	8d 50 30             	lea    0x30(%eax),%edx
    3572:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3575:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3578:	8d 04 80             	lea    (%eax,%eax,4),%eax
    357b:	8d 04 80             	lea    (%eax,%eax,4),%eax
    357e:	c1 e0 03             	shl    $0x3,%eax
    3581:	89 f3                	mov    %esi,%ebx
    3583:	29 c3                	sub    %eax,%ebx
    3585:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    358a:	f7 eb                	imul   %ebx
    358c:	89 d0                	mov    %edx,%eax
    358e:	c1 f8 05             	sar    $0x5,%eax
    3591:	c1 fb 1f             	sar    $0x1f,%ebx
    3594:	29 d8                	sub    %ebx,%eax
    3596:	83 c0 30             	add    $0x30,%eax
    3599:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    359c:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    35a1:	f7 ee                	imul   %esi
    35a3:	89 d0                	mov    %edx,%eax
    35a5:	c1 f8 05             	sar    $0x5,%eax
    35a8:	29 c8                	sub    %ecx,%eax
    35aa:	8d 04 80             	lea    (%eax,%eax,4),%eax
    35ad:	8d 04 80             	lea    (%eax,%eax,4),%eax
    35b0:	c1 e0 02             	shl    $0x2,%eax
    35b3:	89 f7                	mov    %esi,%edi
    35b5:	29 c7                	sub    %eax,%edi
    35b7:	bb 67 66 66 66       	mov    $0x66666667,%ebx
    35bc:	89 f8                	mov    %edi,%eax
    35be:	f7 eb                	imul   %ebx
    35c0:	89 d0                	mov    %edx,%eax
    35c2:	c1 f8 02             	sar    $0x2,%eax
    35c5:	c1 ff 1f             	sar    $0x1f,%edi
    35c8:	29 f8                	sub    %edi,%eax
    35ca:	83 c0 30             	add    $0x30,%eax
    35cd:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    35d0:	89 d8                	mov    %ebx,%eax
    35d2:	f7 ee                	imul   %esi
    35d4:	89 d0                	mov    %edx,%eax
    35d6:	c1 f8 02             	sar    $0x2,%eax
    35d9:	29 c8                	sub    %ecx,%eax
    35db:	8d 04 80             	lea    (%eax,%eax,4),%eax
    35de:	01 c0                	add    %eax,%eax
    35e0:	89 f1                	mov    %esi,%ecx
    35e2:	29 c1                	sub    %eax,%ecx
    35e4:	89 c8                	mov    %ecx,%eax
    35e6:	83 c0 30             	add    $0x30,%eax
    35e9:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    35ec:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    printf(1, "writing %s\n", name);
    35f0:	8d 45 a8             	lea    -0x58(%ebp),%eax
    35f3:	89 44 24 08          	mov    %eax,0x8(%esp)
    35f7:	c7 44 24 04 14 4e 00 	movl   $0x4e14,0x4(%esp)
    35fe:	00 
    35ff:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3606:	e8 71 05 00 00       	call   3b7c <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    360b:	c7 44 24 04 02 02 00 	movl   $0x202,0x4(%esp)
    3612:	00 
    3613:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3616:	89 04 24             	mov    %eax,(%esp)
    3619:	e8 6a 04 00 00       	call   3a88 <open>
    361e:	89 c7                	mov    %eax,%edi
    if(fd < 0){
    3620:	85 c0                	test   %eax,%eax
    3622:	78 4f                	js     3673 <fsfull+0x13b>
    3624:	31 db                	xor    %ebx,%ebx
    3626:	eb 02                	jmp    362a <fsfull+0xf2>
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
      if(cc < 512)
        break;
      total += cc;
    3628:	01 c3                	add    %eax,%ebx
      printf(1, "open %s failed\n", name);
      break;
    }
    int total = 0;
    while(1){
      int cc = write(fd, buf, 512);
    362a:	c7 44 24 08 00 02 00 	movl   $0x200,0x8(%esp)
    3631:	00 
    3632:	c7 44 24 04 00 87 00 	movl   $0x8700,0x4(%esp)
    3639:	00 
    363a:	89 3c 24             	mov    %edi,(%esp)
    363d:	e8 26 04 00 00       	call   3a68 <write>
      if(cc < 512)
    3642:	3d ff 01 00 00       	cmp    $0x1ff,%eax
    3647:	7f df                	jg     3628 <fsfull+0xf0>
        break;
      total += cc;
      fsblocks++;
    }
    printf(1, "wrote %d bytes\n", total);
    3649:	89 5c 24 08          	mov    %ebx,0x8(%esp)
    364d:	c7 44 24 04 30 4e 00 	movl   $0x4e30,0x4(%esp)
    3654:	00 
    3655:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    365c:	e8 1b 05 00 00       	call   3b7c <printf>
    close(fd);
    3661:	89 3c 24             	mov    %edi,(%esp)
    3664:	e8 07 04 00 00       	call   3a70 <close>
    if(total == 0)
    3669:	85 db                	test   %ebx,%ebx
    366b:	74 23                	je     3690 <fsfull+0x158>
  int nfiles;
  int fsblocks = 0;

  printf(1, "fsfull test\n");

  for(nfiles = 0; ; nfiles++){
    366d:	46                   	inc    %esi
    }
    printf(1, "wrote %d bytes\n", total);
    close(fd);
    if(total == 0)
      break;
  }
    366e:	e9 e5 fe ff ff       	jmp    3558 <fsfull+0x20>
    name[4] = '0' + (nfiles % 10);
    name[5] = '\0';
    printf(1, "writing %s\n", name);
    int fd = open(name, O_CREATE|O_RDWR);
    if(fd < 0){
      printf(1, "open %s failed\n", name);
    3673:	8d 45 a8             	lea    -0x58(%ebp),%eax
    3676:	89 44 24 08          	mov    %eax,0x8(%esp)
    367a:	c7 44 24 04 20 4e 00 	movl   $0x4e20,0x4(%esp)
    3681:	00 
    3682:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3689:	e8 ee 04 00 00       	call   3b7c <printf>
    368e:	66 90                	xchg   %ax,%ax
      break;
  }

  while(nfiles >= 0){
    char name[64];
    name[0] = 'f';
    3690:	c6 45 a8 66          	movb   $0x66,-0x58(%ebp)
    name[1] = '0' + nfiles / 1000;
    3694:	b8 d3 4d 62 10       	mov    $0x10624dd3,%eax
    3699:	f7 ee                	imul   %esi
    369b:	89 d0                	mov    %edx,%eax
    369d:	c1 f8 06             	sar    $0x6,%eax
    36a0:	89 f1                	mov    %esi,%ecx
    36a2:	c1 f9 1f             	sar    $0x1f,%ecx
    36a5:	29 c8                	sub    %ecx,%eax
    36a7:	8d 50 30             	lea    0x30(%eax),%edx
    36aa:	88 55 a9             	mov    %dl,-0x57(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    36ad:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b3:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36b6:	c1 e0 03             	shl    $0x3,%eax
    36b9:	89 f3                	mov    %esi,%ebx
    36bb:	29 c3                	sub    %eax,%ebx
    36bd:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    36c2:	f7 eb                	imul   %ebx
    36c4:	89 d0                	mov    %edx,%eax
    36c6:	c1 f8 05             	sar    $0x5,%eax
    36c9:	c1 fb 1f             	sar    $0x1f,%ebx
    36cc:	29 d8                	sub    %ebx,%eax
    36ce:	83 c0 30             	add    $0x30,%eax
    36d1:	88 45 aa             	mov    %al,-0x56(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    36d4:	b8 1f 85 eb 51       	mov    $0x51eb851f,%eax
    36d9:	f7 ee                	imul   %esi
    36db:	89 d0                	mov    %edx,%eax
    36dd:	c1 f8 05             	sar    $0x5,%eax
    36e0:	29 c8                	sub    %ecx,%eax
    36e2:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36e5:	8d 04 80             	lea    (%eax,%eax,4),%eax
    36e8:	c1 e0 02             	shl    $0x2,%eax
    36eb:	89 f7                	mov    %esi,%edi
    36ed:	29 c7                	sub    %eax,%edi
    36ef:	bb 67 66 66 66       	mov    $0x66666667,%ebx
    36f4:	89 f8                	mov    %edi,%eax
    36f6:	f7 eb                	imul   %ebx
    36f8:	89 d0                	mov    %edx,%eax
    36fa:	c1 f8 02             	sar    $0x2,%eax
    36fd:	c1 ff 1f             	sar    $0x1f,%edi
    3700:	29 f8                	sub    %edi,%eax
    3702:	83 c0 30             	add    $0x30,%eax
    3705:	88 45 ab             	mov    %al,-0x55(%ebp)
    name[4] = '0' + (nfiles % 10);
    3708:	89 d8                	mov    %ebx,%eax
    370a:	f7 ee                	imul   %esi
    370c:	89 d0                	mov    %edx,%eax
    370e:	c1 f8 02             	sar    $0x2,%eax
    3711:	29 c8                	sub    %ecx,%eax
    3713:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3716:	01 c0                	add    %eax,%eax
    3718:	89 f1                	mov    %esi,%ecx
    371a:	29 c1                	sub    %eax,%ecx
    371c:	89 c8                	mov    %ecx,%eax
    371e:	83 c0 30             	add    $0x30,%eax
    3721:	88 45 ac             	mov    %al,-0x54(%ebp)
    name[5] = '\0';
    3724:	c6 45 ad 00          	movb   $0x0,-0x53(%ebp)
    unlink(name);
    3728:	8d 45 a8             	lea    -0x58(%ebp),%eax
    372b:	89 04 24             	mov    %eax,(%esp)
    372e:	e8 65 03 00 00       	call   3a98 <unlink>
    nfiles--;
    3733:	4e                   	dec    %esi
    close(fd);
    if(total == 0)
      break;
  }

  while(nfiles >= 0){
    3734:	83 fe ff             	cmp    $0xffffffff,%esi
    3737:	0f 85 53 ff ff ff    	jne    3690 <fsfull+0x158>
    name[5] = '\0';
    unlink(name);
    nfiles--;
  }

  printf(1, "fsfull test finished\n");
    373d:	c7 44 24 04 40 4e 00 	movl   $0x4e40,0x4(%esp)
    3744:	00 
    3745:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    374c:	e8 2b 04 00 00       	call   3b7c <printf>
}
    3751:	83 c4 5c             	add    $0x5c,%esp
    3754:	5b                   	pop    %ebx
    3755:	5e                   	pop    %esi
    3756:	5f                   	pop    %edi
    3757:	5d                   	pop    %ebp
    3758:	c3                   	ret    
    3759:	8d 76 00             	lea    0x0(%esi),%esi

0000375c <uio>:

void
uio()
{
    375c:	55                   	push   %ebp
    375d:	89 e5                	mov    %esp,%ebp
    375f:	83 ec 18             	sub    $0x18,%esp

  ushort port = 0;
  uchar val = 0;
  int pid;

  printf(1, "uio test\n");
    3762:	c7 44 24 04 56 4e 00 	movl   $0x4e56,0x4(%esp)
    3769:	00 
    376a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3771:	e8 06 04 00 00       	call   3b7c <printf>
  pid = fork();
    3776:	e8 c5 02 00 00       	call   3a40 <fork>
  if(pid == 0){
    377b:	85 c0                	test   %eax,%eax
    377d:	74 1d                	je     379c <uio+0x40>
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    printf(1, "uio: uio succeeded; test FAILED\n");
    exit();
  } else if(pid < 0){
    377f:	78 3f                	js     37c0 <uio+0x64>
    printf (1, "fork failed\n");
    exit();
  }
  wait();
    3781:	e8 ca 02 00 00       	call   3a50 <wait>
  printf(1, "uio test done\n");
    3786:	c7 44 24 04 60 4e 00 	movl   $0x4e60,0x4(%esp)
    378d:	00 
    378e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3795:	e8 e2 03 00 00       	call   3b7c <printf>
}
    379a:	c9                   	leave  
    379b:	c3                   	ret    
  pid = fork();
  if(pid == 0){
    port = RTC_ADDR;
    val = 0x09;  /* year */
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    379c:	ba 70 00 00 00       	mov    $0x70,%edx
    37a1:	b0 09                	mov    $0x9,%al
    37a3:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    37a4:	b2 71                	mov    $0x71,%dl
    37a6:	ec                   	in     (%dx),%al
    printf(1, "uio: uio succeeded; test FAILED\n");
    37a7:	c7 44 24 04 ec 55 00 	movl   $0x55ec,0x4(%esp)
    37ae:	00 
    37af:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    37b6:	e8 c1 03 00 00       	call   3b7c <printf>
    exit();
    37bb:	e8 88 02 00 00       	call   3a48 <exit>
  } else if(pid < 0){
    printf (1, "fork failed\n");
    37c0:	c7 44 24 04 e5 4d 00 	movl   $0x4de5,0x4(%esp)
    37c7:	00 
    37c8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    37cf:	e8 a8 03 00 00       	call   3b7c <printf>
    exit();
    37d4:	e8 6f 02 00 00       	call   3a48 <exit>
    37d9:	8d 76 00             	lea    0x0(%esi),%esi

000037dc <argptest>:
  wait();
  printf(1, "uio test done\n");
}

void argptest()
{
    37dc:	55                   	push   %ebp
    37dd:	89 e5                	mov    %esp,%ebp
    37df:	53                   	push   %ebx
    37e0:	83 ec 14             	sub    $0x14,%esp
  int fd;
  fd = open("init", O_RDONLY);
    37e3:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    37ea:	00 
    37eb:	c7 04 24 6f 4e 00 00 	movl   $0x4e6f,(%esp)
    37f2:	e8 91 02 00 00       	call   3a88 <open>
    37f7:	89 c3                	mov    %eax,%ebx
  if (fd < 0) {
    37f9:	85 c0                	test   %eax,%eax
    37fb:	78 43                	js     3840 <argptest+0x64>
    printf(2, "open failed\n");
    exit();
  }
  read(fd, sbrk(0) - 1, -1);
    37fd:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3804:	e8 c7 02 00 00       	call   3ad0 <sbrk>
    3809:	c7 44 24 08 ff ff ff 	movl   $0xffffffff,0x8(%esp)
    3810:	ff 
    3811:	48                   	dec    %eax
    3812:	89 44 24 04          	mov    %eax,0x4(%esp)
    3816:	89 1c 24             	mov    %ebx,(%esp)
    3819:	e8 42 02 00 00       	call   3a60 <read>
  close(fd);
    381e:	89 1c 24             	mov    %ebx,(%esp)
    3821:	e8 4a 02 00 00       	call   3a70 <close>
  printf(1, "arg test passed\n");
    3826:	c7 44 24 04 81 4e 00 	movl   $0x4e81,0x4(%esp)
    382d:	00 
    382e:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3835:	e8 42 03 00 00       	call   3b7c <printf>
}
    383a:	83 c4 14             	add    $0x14,%esp
    383d:	5b                   	pop    %ebx
    383e:	5d                   	pop    %ebp
    383f:	c3                   	ret    
void argptest()
{
  int fd;
  fd = open("init", O_RDONLY);
  if (fd < 0) {
    printf(2, "open failed\n");
    3840:	c7 44 24 04 74 4e 00 	movl   $0x4e74,0x4(%esp)
    3847:	00 
    3848:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
    384f:	e8 28 03 00 00       	call   3b7c <printf>
    exit();
    3854:	e8 ef 01 00 00       	call   3a48 <exit>
    3859:	8d 76 00             	lea    0x0(%esi),%esi

0000385c <rand>:
}

unsigned long randstate = 1;
unsigned int
rand()
{
    385c:	55                   	push   %ebp
    385d:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    385f:	a1 1c 5f 00 00       	mov    0x5f1c,%eax
    3864:	8d 14 00             	lea    (%eax,%eax,1),%edx
    3867:	01 c2                	add    %eax,%edx
    3869:	8d 14 90             	lea    (%eax,%edx,4),%edx
    386c:	c1 e2 08             	shl    $0x8,%edx
    386f:	01 c2                	add    %eax,%edx
    3871:	8d 14 92             	lea    (%edx,%edx,4),%edx
    3874:	8d 04 90             	lea    (%eax,%edx,4),%eax
    3877:	8d 04 80             	lea    (%eax,%eax,4),%eax
    387a:	8d 84 80 5f f3 6e 3c 	lea    0x3c6ef35f(%eax,%eax,4),%eax
    3881:	a3 1c 5f 00 00       	mov    %eax,0x5f1c
  return randstate;
}
    3886:	5d                   	pop    %ebp
    3887:	c3                   	ret    

00003888 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
    3888:	55                   	push   %ebp
    3889:	89 e5                	mov    %esp,%ebp
    388b:	53                   	push   %ebx
    388c:	8b 45 08             	mov    0x8(%ebp),%eax
    388f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    3892:	89 c2                	mov    %eax,%edx
    3894:	42                   	inc    %edx
    3895:	41                   	inc    %ecx
    3896:	8a 59 ff             	mov    -0x1(%ecx),%bl
    3899:	88 5a ff             	mov    %bl,-0x1(%edx)
    389c:	84 db                	test   %bl,%bl
    389e:	75 f4                	jne    3894 <strcpy+0xc>
    ;
  return os;
}
    38a0:	5b                   	pop    %ebx
    38a1:	5d                   	pop    %ebp
    38a2:	c3                   	ret    
    38a3:	90                   	nop

000038a4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    38a4:	55                   	push   %ebp
    38a5:	89 e5                	mov    %esp,%ebp
    38a7:	53                   	push   %ebx
    38a8:	8b 55 08             	mov    0x8(%ebp),%edx
    38ab:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
    38ae:	0f b6 02             	movzbl (%edx),%eax
    38b1:	84 c0                	test   %al,%al
    38b3:	74 27                	je     38dc <strcmp+0x38>
    38b5:	8a 19                	mov    (%ecx),%bl
    38b7:	38 d8                	cmp    %bl,%al
    38b9:	74 0b                	je     38c6 <strcmp+0x22>
    38bb:	eb 26                	jmp    38e3 <strcmp+0x3f>
    38bd:	8d 76 00             	lea    0x0(%esi),%esi
    38c0:	38 c8                	cmp    %cl,%al
    38c2:	75 13                	jne    38d7 <strcmp+0x33>
    p++, q++;
    38c4:	89 d9                	mov    %ebx,%ecx
    38c6:	42                   	inc    %edx
    38c7:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    38ca:	0f b6 02             	movzbl (%edx),%eax
    38cd:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
    38d1:	84 c0                	test   %al,%al
    38d3:	75 eb                	jne    38c0 <strcmp+0x1c>
    38d5:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
    38d7:	29 c8                	sub    %ecx,%eax
}
    38d9:	5b                   	pop    %ebx
    38da:	5d                   	pop    %ebp
    38db:	c3                   	ret    
    38dc:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
    38df:	31 c0                	xor    %eax,%eax
    38e1:	eb f4                	jmp    38d7 <strcmp+0x33>
    38e3:	0f b6 cb             	movzbl %bl,%ecx
    38e6:	eb ef                	jmp    38d7 <strcmp+0x33>

000038e8 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
    38e8:	55                   	push   %ebp
    38e9:	89 e5                	mov    %esp,%ebp
    38eb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
    38ee:	80 39 00             	cmpb   $0x0,(%ecx)
    38f1:	74 10                	je     3903 <strlen+0x1b>
    38f3:	31 d2                	xor    %edx,%edx
    38f5:	8d 76 00             	lea    0x0(%esi),%esi
    38f8:	42                   	inc    %edx
    38f9:	89 d0                	mov    %edx,%eax
    38fb:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
    38ff:	75 f7                	jne    38f8 <strlen+0x10>
    ;
  return n;
}
    3901:	5d                   	pop    %ebp
    3902:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
    3903:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
    3905:	5d                   	pop    %ebp
    3906:	c3                   	ret    
    3907:	90                   	nop

00003908 <memset>:

void*
memset(void *dst, int c, uint n)
{
    3908:	55                   	push   %ebp
    3909:	89 e5                	mov    %esp,%ebp
    390b:	57                   	push   %edi
    390c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
    390f:	89 d7                	mov    %edx,%edi
    3911:	8b 4d 10             	mov    0x10(%ebp),%ecx
    3914:	8b 45 0c             	mov    0xc(%ebp),%eax
    3917:	fc                   	cld    
    3918:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
    391a:	89 d0                	mov    %edx,%eax
    391c:	5f                   	pop    %edi
    391d:	5d                   	pop    %ebp
    391e:	c3                   	ret    
    391f:	90                   	nop

00003920 <strchr>:

char*
strchr(const char *s, char c)
{
    3920:	55                   	push   %ebp
    3921:	89 e5                	mov    %esp,%ebp
    3923:	53                   	push   %ebx
    3924:	8b 45 08             	mov    0x8(%ebp),%eax
    3927:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
    392a:	8a 10                	mov    (%eax),%dl
    392c:	84 d2                	test   %dl,%dl
    392e:	74 13                	je     3943 <strchr+0x23>
    3930:	88 d9                	mov    %bl,%cl
    if(*s == c)
    3932:	38 da                	cmp    %bl,%dl
    3934:	75 06                	jne    393c <strchr+0x1c>
    3936:	eb 0d                	jmp    3945 <strchr+0x25>
    3938:	38 ca                	cmp    %cl,%dl
    393a:	74 09                	je     3945 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
    393c:	40                   	inc    %eax
    393d:	8a 10                	mov    (%eax),%dl
    393f:	84 d2                	test   %dl,%dl
    3941:	75 f5                	jne    3938 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
    3943:	31 c0                	xor    %eax,%eax
}
    3945:	5b                   	pop    %ebx
    3946:	5d                   	pop    %ebp
    3947:	c3                   	ret    

00003948 <gets>:

char*
gets(char *buf, int max)
{
    3948:	55                   	push   %ebp
    3949:	89 e5                	mov    %esp,%ebp
    394b:	57                   	push   %edi
    394c:	56                   	push   %esi
    394d:	53                   	push   %ebx
    394e:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3951:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
    3953:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3956:	eb 30                	jmp    3988 <gets+0x40>
    cc = read(0, &c, 1);
    3958:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    395f:	00 
    3960:	89 7c 24 04          	mov    %edi,0x4(%esp)
    3964:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    396b:	e8 f0 00 00 00       	call   3a60 <read>
    if(cc < 1)
    3970:	85 c0                	test   %eax,%eax
    3972:	7e 1c                	jle    3990 <gets+0x48>
      break;
    buf[i++] = c;
    3974:	8a 45 e7             	mov    -0x19(%ebp),%al
    3977:	8b 55 08             	mov    0x8(%ebp),%edx
    397a:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    397e:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    3980:	3c 0a                	cmp    $0xa,%al
    3982:	74 0c                	je     3990 <gets+0x48>
    3984:	3c 0d                	cmp    $0xd,%al
    3986:	74 08                	je     3990 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3988:	8d 5e 01             	lea    0x1(%esi),%ebx
    398b:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
    398e:	7c c8                	jl     3958 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
    3990:	8b 45 08             	mov    0x8(%ebp),%eax
    3993:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
    3997:	83 c4 2c             	add    $0x2c,%esp
    399a:	5b                   	pop    %ebx
    399b:	5e                   	pop    %esi
    399c:	5f                   	pop    %edi
    399d:	5d                   	pop    %ebp
    399e:	c3                   	ret    
    399f:	90                   	nop

000039a0 <stat>:

int
stat(char *n, struct stat *st)
{
    39a0:	55                   	push   %ebp
    39a1:	89 e5                	mov    %esp,%ebp
    39a3:	56                   	push   %esi
    39a4:	53                   	push   %ebx
    39a5:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    39a8:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
    39af:	00 
    39b0:	8b 45 08             	mov    0x8(%ebp),%eax
    39b3:	89 04 24             	mov    %eax,(%esp)
    39b6:	e8 cd 00 00 00       	call   3a88 <open>
    39bb:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
    39bd:	85 c0                	test   %eax,%eax
    39bf:	78 23                	js     39e4 <stat+0x44>
    return -1;
  r = fstat(fd, st);
    39c1:	8b 45 0c             	mov    0xc(%ebp),%eax
    39c4:	89 44 24 04          	mov    %eax,0x4(%esp)
    39c8:	89 1c 24             	mov    %ebx,(%esp)
    39cb:	e8 d0 00 00 00       	call   3aa0 <fstat>
    39d0:	89 c6                	mov    %eax,%esi
  close(fd);
    39d2:	89 1c 24             	mov    %ebx,(%esp)
    39d5:	e8 96 00 00 00       	call   3a70 <close>
  return r;
    39da:	89 f0                	mov    %esi,%eax
}
    39dc:	83 c4 10             	add    $0x10,%esp
    39df:	5b                   	pop    %ebx
    39e0:	5e                   	pop    %esi
    39e1:	5d                   	pop    %ebp
    39e2:	c3                   	ret    
    39e3:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
    39e4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    39e9:	eb f1                	jmp    39dc <stat+0x3c>
    39eb:	90                   	nop

000039ec <atoi>:
  return r;
}

int
atoi(const char *s)
{
    39ec:	55                   	push   %ebp
    39ed:	89 e5                	mov    %esp,%ebp
    39ef:	53                   	push   %ebx
    39f0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    39f3:	0f be 11             	movsbl (%ecx),%edx
    39f6:	8d 42 d0             	lea    -0x30(%edx),%eax
    39f9:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
    39fb:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
    3a00:	77 15                	ja     3a17 <atoi+0x2b>
    3a02:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
    3a04:	41                   	inc    %ecx
    3a05:	8d 04 80             	lea    (%eax,%eax,4),%eax
    3a08:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    3a0c:	0f be 11             	movsbl (%ecx),%edx
    3a0f:	8d 5a d0             	lea    -0x30(%edx),%ebx
    3a12:	80 fb 09             	cmp    $0x9,%bl
    3a15:	76 ed                	jbe    3a04 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
    3a17:	5b                   	pop    %ebx
    3a18:	5d                   	pop    %ebp
    3a19:	c3                   	ret    
    3a1a:	66 90                	xchg   %ax,%ax

00003a1c <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
    3a1c:	55                   	push   %ebp
    3a1d:	89 e5                	mov    %esp,%ebp
    3a1f:	56                   	push   %esi
    3a20:	53                   	push   %ebx
    3a21:	8b 45 08             	mov    0x8(%ebp),%eax
    3a24:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3a27:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3a2a:	31 d2                	xor    %edx,%edx
    3a2c:	85 f6                	test   %esi,%esi
    3a2e:	7e 0b                	jle    3a3b <memmove+0x1f>
    *dst++ = *src++;
    3a30:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
    3a33:	88 0c 10             	mov    %cl,(%eax,%edx,1)
    3a36:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
    3a37:	39 f2                	cmp    %esi,%edx
    3a39:	75 f5                	jne    3a30 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
    3a3b:	5b                   	pop    %ebx
    3a3c:	5e                   	pop    %esi
    3a3d:	5d                   	pop    %ebp
    3a3e:	c3                   	ret    
    3a3f:	90                   	nop

00003a40 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    3a40:	b8 01 00 00 00       	mov    $0x1,%eax
    3a45:	cd 40                	int    $0x40
    3a47:	c3                   	ret    

00003a48 <exit>:
SYSCALL(exit)
    3a48:	b8 02 00 00 00       	mov    $0x2,%eax
    3a4d:	cd 40                	int    $0x40
    3a4f:	c3                   	ret    

00003a50 <wait>:
SYSCALL(wait)
    3a50:	b8 03 00 00 00       	mov    $0x3,%eax
    3a55:	cd 40                	int    $0x40
    3a57:	c3                   	ret    

00003a58 <pipe>:
SYSCALL(pipe)
    3a58:	b8 04 00 00 00       	mov    $0x4,%eax
    3a5d:	cd 40                	int    $0x40
    3a5f:	c3                   	ret    

00003a60 <read>:
SYSCALL(read)
    3a60:	b8 05 00 00 00       	mov    $0x5,%eax
    3a65:	cd 40                	int    $0x40
    3a67:	c3                   	ret    

00003a68 <write>:
SYSCALL(write)
    3a68:	b8 10 00 00 00       	mov    $0x10,%eax
    3a6d:	cd 40                	int    $0x40
    3a6f:	c3                   	ret    

00003a70 <close>:
SYSCALL(close)
    3a70:	b8 15 00 00 00       	mov    $0x15,%eax
    3a75:	cd 40                	int    $0x40
    3a77:	c3                   	ret    

00003a78 <kill>:
SYSCALL(kill)
    3a78:	b8 06 00 00 00       	mov    $0x6,%eax
    3a7d:	cd 40                	int    $0x40
    3a7f:	c3                   	ret    

00003a80 <exec>:
SYSCALL(exec)
    3a80:	b8 07 00 00 00       	mov    $0x7,%eax
    3a85:	cd 40                	int    $0x40
    3a87:	c3                   	ret    

00003a88 <open>:
SYSCALL(open)
    3a88:	b8 0f 00 00 00       	mov    $0xf,%eax
    3a8d:	cd 40                	int    $0x40
    3a8f:	c3                   	ret    

00003a90 <mknod>:
SYSCALL(mknod)
    3a90:	b8 11 00 00 00       	mov    $0x11,%eax
    3a95:	cd 40                	int    $0x40
    3a97:	c3                   	ret    

00003a98 <unlink>:
SYSCALL(unlink)
    3a98:	b8 12 00 00 00       	mov    $0x12,%eax
    3a9d:	cd 40                	int    $0x40
    3a9f:	c3                   	ret    

00003aa0 <fstat>:
SYSCALL(fstat)
    3aa0:	b8 08 00 00 00       	mov    $0x8,%eax
    3aa5:	cd 40                	int    $0x40
    3aa7:	c3                   	ret    

00003aa8 <link>:
SYSCALL(link)
    3aa8:	b8 13 00 00 00       	mov    $0x13,%eax
    3aad:	cd 40                	int    $0x40
    3aaf:	c3                   	ret    

00003ab0 <mkdir>:
SYSCALL(mkdir)
    3ab0:	b8 14 00 00 00       	mov    $0x14,%eax
    3ab5:	cd 40                	int    $0x40
    3ab7:	c3                   	ret    

00003ab8 <chdir>:
SYSCALL(chdir)
    3ab8:	b8 09 00 00 00       	mov    $0x9,%eax
    3abd:	cd 40                	int    $0x40
    3abf:	c3                   	ret    

00003ac0 <dup>:
SYSCALL(dup)
    3ac0:	b8 0a 00 00 00       	mov    $0xa,%eax
    3ac5:	cd 40                	int    $0x40
    3ac7:	c3                   	ret    

00003ac8 <getpid>:
SYSCALL(getpid)
    3ac8:	b8 0b 00 00 00       	mov    $0xb,%eax
    3acd:	cd 40                	int    $0x40
    3acf:	c3                   	ret    

00003ad0 <sbrk>:
SYSCALL(sbrk)
    3ad0:	b8 0c 00 00 00       	mov    $0xc,%eax
    3ad5:	cd 40                	int    $0x40
    3ad7:	c3                   	ret    

00003ad8 <sleep>:
SYSCALL(sleep)
    3ad8:	b8 0d 00 00 00       	mov    $0xd,%eax
    3add:	cd 40                	int    $0x40
    3adf:	c3                   	ret    

00003ae0 <uptime>:
SYSCALL(uptime)
    3ae0:	b8 0e 00 00 00       	mov    $0xe,%eax
    3ae5:	cd 40                	int    $0x40
    3ae7:	c3                   	ret    

00003ae8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    3ae8:	55                   	push   %ebp
    3ae9:	89 e5                	mov    %esp,%ebp
    3aeb:	57                   	push   %edi
    3aec:	56                   	push   %esi
    3aed:	53                   	push   %ebx
    3aee:	83 ec 4c             	sub    $0x4c,%esp
    3af1:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3af3:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    3af5:	8b 5d 08             	mov    0x8(%ebp),%ebx
    3af8:	85 db                	test   %ebx,%ebx
    3afa:	74 04                	je     3b00 <printint+0x18>
    3afc:	85 d2                	test   %edx,%edx
    3afe:	78 70                	js     3b70 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    3b00:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
    3b07:	31 ff                	xor    %edi,%edi
    3b09:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    3b0c:	89 75 c0             	mov    %esi,-0x40(%ebp)
    3b0f:	89 ce                	mov    %ecx,%esi
    3b11:	eb 03                	jmp    3b16 <printint+0x2e>
    3b13:	90                   	nop
  do{
    buf[i++] = digits[x % base];
    3b14:	89 cf                	mov    %ecx,%edi
    3b16:	8d 4f 01             	lea    0x1(%edi),%ecx
    3b19:	31 d2                	xor    %edx,%edx
    3b1b:	f7 f6                	div    %esi
    3b1d:	8a 92 53 56 00 00    	mov    0x5653(%edx),%dl
    3b23:	88 55 c7             	mov    %dl,-0x39(%ebp)
    3b26:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
    3b29:	85 c0                	test   %eax,%eax
    3b2b:	75 e7                	jne    3b14 <printint+0x2c>
    3b2d:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
    3b30:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
    3b32:	8b 55 bc             	mov    -0x44(%ebp),%edx
    3b35:	85 d2                	test   %edx,%edx
    3b37:	74 08                	je     3b41 <printint+0x59>
    buf[i++] = '-';
    3b39:	8d 4f 02             	lea    0x2(%edi),%ecx
    3b3c:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
    3b41:	8d 79 ff             	lea    -0x1(%ecx),%edi
    3b44:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
    3b48:	88 45 c7             	mov    %al,-0x39(%ebp)
    3b4b:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3b4e:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3b55:	00 
    3b56:	89 5c 24 04          	mov    %ebx,0x4(%esp)
    3b5a:	89 34 24             	mov    %esi,(%esp)
    3b5d:	e8 06 ff ff ff       	call   3a68 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
    3b62:	4f                   	dec    %edi
    3b63:	83 ff ff             	cmp    $0xffffffff,%edi
    3b66:	75 dc                	jne    3b44 <printint+0x5c>
    putc(fd, buf[i]);
}
    3b68:	83 c4 4c             	add    $0x4c,%esp
    3b6b:	5b                   	pop    %ebx
    3b6c:	5e                   	pop    %esi
    3b6d:	5f                   	pop    %edi
    3b6e:	5d                   	pop    %ebp
    3b6f:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
    3b70:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    3b72:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
    3b79:	eb 8c                	jmp    3b07 <printint+0x1f>
    3b7b:	90                   	nop

00003b7c <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
    3b7c:	55                   	push   %ebp
    3b7d:	89 e5                	mov    %esp,%ebp
    3b7f:	57                   	push   %edi
    3b80:	56                   	push   %esi
    3b81:	53                   	push   %ebx
    3b82:	83 ec 3c             	sub    $0x3c,%esp
    3b85:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3b88:	8b 5d 0c             	mov    0xc(%ebp),%ebx
    3b8b:	0f b6 13             	movzbl (%ebx),%edx
    3b8e:	84 d2                	test   %dl,%dl
    3b90:	0f 84 be 00 00 00    	je     3c54 <printf+0xd8>
    3b96:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
    3b97:	8d 45 10             	lea    0x10(%ebp),%eax
    3b9a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    3b9d:	31 ff                	xor    %edi,%edi
    3b9f:	eb 33                	jmp    3bd4 <printf+0x58>
    3ba1:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    3ba4:	83 fa 25             	cmp    $0x25,%edx
    3ba7:	0f 84 af 00 00 00    	je     3c5c <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
    3bad:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3bb0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3bb7:	00 
    3bb8:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    3bbb:	89 44 24 04          	mov    %eax,0x4(%esp)
    3bbf:	89 34 24             	mov    %esi,(%esp)
    3bc2:	e8 a1 fe ff ff       	call   3a68 <write>
    3bc7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3bc8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3bcc:	84 d2                	test   %dl,%dl
    3bce:	0f 84 80 00 00 00    	je     3c54 <printf+0xd8>
    c = fmt[i] & 0xff;
    3bd4:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
    3bd7:	85 ff                	test   %edi,%edi
    3bd9:	74 c9                	je     3ba4 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    3bdb:	83 ff 25             	cmp    $0x25,%edi
    3bde:	75 e7                	jne    3bc7 <printf+0x4b>
      if(c == 'd'){
    3be0:	83 fa 64             	cmp    $0x64,%edx
    3be3:	0f 84 0f 01 00 00    	je     3cf8 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    3be9:	25 f7 00 00 00       	and    $0xf7,%eax
    3bee:	83 f8 70             	cmp    $0x70,%eax
    3bf1:	74 75                	je     3c68 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    3bf3:	83 fa 73             	cmp    $0x73,%edx
    3bf6:	0f 84 90 00 00 00    	je     3c8c <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    3bfc:	83 fa 63             	cmp    $0x63,%edx
    3bff:	0f 84 c7 00 00 00    	je     3ccc <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    3c05:	83 fa 25             	cmp    $0x25,%edx
    3c08:	0f 84 0e 01 00 00    	je     3d1c <printf+0x1a0>
    3c0e:	89 55 d0             	mov    %edx,-0x30(%ebp)
    3c11:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3c15:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3c1c:	00 
    3c1d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    3c20:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c24:	89 34 24             	mov    %esi,(%esp)
    3c27:	e8 3c fe ff ff       	call   3a68 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
    3c2c:	8b 55 d0             	mov    -0x30(%ebp),%edx
    3c2f:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3c32:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3c39:	00 
    3c3a:	8d 45 e7             	lea    -0x19(%ebp),%eax
    3c3d:	89 44 24 04          	mov    %eax,0x4(%esp)
    3c41:	89 34 24             	mov    %esi,(%esp)
    3c44:	e8 1f fe ff ff       	call   3a68 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3c49:	31 ff                	xor    %edi,%edi
    3c4b:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    3c4c:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
    3c50:	84 d2                	test   %dl,%dl
    3c52:	75 80                	jne    3bd4 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
    3c54:	83 c4 3c             	add    $0x3c,%esp
    3c57:	5b                   	pop    %ebx
    3c58:	5e                   	pop    %esi
    3c59:	5f                   	pop    %edi
    3c5a:	5d                   	pop    %ebp
    3c5b:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
    3c5c:	bf 25 00 00 00       	mov    $0x25,%edi
    3c61:	e9 61 ff ff ff       	jmp    3bc7 <printf+0x4b>
    3c66:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
    3c68:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
    3c6f:	b9 10 00 00 00       	mov    $0x10,%ecx
    3c74:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3c77:	8b 10                	mov    (%eax),%edx
    3c79:	89 f0                	mov    %esi,%eax
    3c7b:	e8 68 fe ff ff       	call   3ae8 <printint>
        ap++;
    3c80:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3c84:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
    3c86:	e9 3c ff ff ff       	jmp    3bc7 <printf+0x4b>
    3c8b:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
    3c8c:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3c8f:	8b 38                	mov    (%eax),%edi
        ap++;
    3c91:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
    3c95:	85 ff                	test   %edi,%edi
    3c97:	0f 84 a1 00 00 00    	je     3d3e <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
    3c9d:	8a 07                	mov    (%edi),%al
    3c9f:	84 c0                	test   %al,%al
    3ca1:	74 22                	je     3cc5 <printf+0x149>
    3ca3:	90                   	nop
    3ca4:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3ca7:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3cae:	00 
    3caf:	8d 45 e3             	lea    -0x1d(%ebp),%eax
    3cb2:	89 44 24 04          	mov    %eax,0x4(%esp)
    3cb6:	89 34 24             	mov    %esi,(%esp)
    3cb9:	e8 aa fd ff ff       	call   3a68 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
    3cbe:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    3cbf:	8a 07                	mov    (%edi),%al
    3cc1:	84 c0                	test   %al,%al
    3cc3:	75 df                	jne    3ca4 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3cc5:	31 ff                	xor    %edi,%edi
    3cc7:	e9 fb fe ff ff       	jmp    3bc7 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
    3ccc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3ccf:	8b 00                	mov    (%eax),%eax
    3cd1:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3cd4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3cdb:	00 
    3cdc:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    3cdf:	89 44 24 04          	mov    %eax,0x4(%esp)
    3ce3:	89 34 24             	mov    %esi,(%esp)
    3ce6:	e8 7d fd ff ff       	call   3a68 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
    3ceb:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3cef:	31 ff                	xor    %edi,%edi
    3cf1:	e9 d1 fe ff ff       	jmp    3bc7 <printf+0x4b>
    3cf6:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
    3cf8:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
    3cff:	b9 0a 00 00 00       	mov    $0xa,%ecx
    3d04:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    3d07:	8b 10                	mov    (%eax),%edx
    3d09:	89 f0                	mov    %esi,%eax
    3d0b:	e8 d8 fd ff ff       	call   3ae8 <printint>
        ap++;
    3d10:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3d14:	66 31 ff             	xor    %di,%di
    3d17:	e9 ab fe ff ff       	jmp    3bc7 <printf+0x4b>
    3d1c:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
    3d20:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
    3d27:	00 
    3d28:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    3d2b:	89 44 24 04          	mov    %eax,0x4(%esp)
    3d2f:	89 34 24             	mov    %esi,(%esp)
    3d32:	e8 31 fd ff ff       	call   3a68 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    3d37:	31 ff                	xor    %edi,%edi
    3d39:	e9 89 fe ff ff       	jmp    3bc7 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
    3d3e:	bf 4c 56 00 00       	mov    $0x564c,%edi
    3d43:	e9 55 ff ff ff       	jmp    3c9d <printf+0x121>

00003d48 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    3d48:	55                   	push   %ebp
    3d49:	89 e5                	mov    %esp,%ebp
    3d4b:	57                   	push   %edi
    3d4c:	56                   	push   %esi
    3d4d:	53                   	push   %ebx
    3d4e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
    3d51:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3d54:	a1 c0 5f 00 00       	mov    0x5fc0,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3d59:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3d5b:	39 d0                	cmp    %edx,%eax
    3d5d:	72 11                	jb     3d70 <free+0x28>
    3d5f:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3d60:	39 c8                	cmp    %ecx,%eax
    3d62:	72 04                	jb     3d68 <free+0x20>
    3d64:	39 ca                	cmp    %ecx,%edx
    3d66:	72 10                	jb     3d78 <free+0x30>
    3d68:	89 c8                	mov    %ecx,%eax
    3d6a:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    3d6c:	39 d0                	cmp    %edx,%eax
    3d6e:	73 f0                	jae    3d60 <free+0x18>
    3d70:	39 ca                	cmp    %ecx,%edx
    3d72:	72 04                	jb     3d78 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    3d74:	39 c8                	cmp    %ecx,%eax
    3d76:	72 f0                	jb     3d68 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
    3d78:	8b 73 fc             	mov    -0x4(%ebx),%esi
    3d7b:	8d 3c f2             	lea    (%edx,%esi,8),%edi
    3d7e:	39 cf                	cmp    %ecx,%edi
    3d80:	74 1a                	je     3d9c <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    3d82:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    3d85:	8b 48 04             	mov    0x4(%eax),%ecx
    3d88:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    3d8b:	39 f2                	cmp    %esi,%edx
    3d8d:	74 24                	je     3db3 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    3d8f:	89 10                	mov    %edx,(%eax)
  freep = p;
    3d91:	a3 c0 5f 00 00       	mov    %eax,0x5fc0
}
    3d96:	5b                   	pop    %ebx
    3d97:	5e                   	pop    %esi
    3d98:	5f                   	pop    %edi
    3d99:	5d                   	pop    %ebp
    3d9a:	c3                   	ret    
    3d9b:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    3d9c:	03 71 04             	add    0x4(%ecx),%esi
    3d9f:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    3da2:	8b 08                	mov    (%eax),%ecx
    3da4:	8b 09                	mov    (%ecx),%ecx
    3da6:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    3da9:	8b 48 04             	mov    0x4(%eax),%ecx
    3dac:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    3daf:	39 f2                	cmp    %esi,%edx
    3db1:	75 dc                	jne    3d8f <free+0x47>
    p->s.size += bp->s.size;
    3db3:	03 4b fc             	add    -0x4(%ebx),%ecx
    3db6:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    3db9:	8b 53 f8             	mov    -0x8(%ebx),%edx
    3dbc:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    3dbe:	a3 c0 5f 00 00       	mov    %eax,0x5fc0
}
    3dc3:	5b                   	pop    %ebx
    3dc4:	5e                   	pop    %esi
    3dc5:	5f                   	pop    %edi
    3dc6:	5d                   	pop    %ebp
    3dc7:	c3                   	ret    

00003dc8 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    3dc8:	55                   	push   %ebp
    3dc9:	89 e5                	mov    %esp,%ebp
    3dcb:	57                   	push   %edi
    3dcc:	56                   	push   %esi
    3dcd:	53                   	push   %ebx
    3dce:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    3dd1:	8b 45 08             	mov    0x8(%ebp),%eax
    3dd4:	8d 70 07             	lea    0x7(%eax),%esi
    3dd7:	c1 ee 03             	shr    $0x3,%esi
    3dda:	46                   	inc    %esi
  if((prevp = freep) == 0){
    3ddb:	8b 1d c0 5f 00 00    	mov    0x5fc0,%ebx
    3de1:	85 db                	test   %ebx,%ebx
    3de3:	0f 84 91 00 00 00    	je     3e7a <malloc+0xb2>
    3de9:	8b 13                	mov    (%ebx),%edx
    3deb:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3dee:	39 ce                	cmp    %ecx,%esi
    3df0:	76 52                	jbe    3e44 <malloc+0x7c>
    3df2:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
    3df9:	eb 0c                	jmp    3e07 <malloc+0x3f>
    3dfb:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    3dfc:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    3dfe:	8b 48 04             	mov    0x4(%eax),%ecx
    3e01:	39 ce                	cmp    %ecx,%esi
    3e03:	76 43                	jbe    3e48 <malloc+0x80>
    3e05:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    3e07:	3b 15 c0 5f 00 00    	cmp    0x5fc0,%edx
    3e0d:	75 ed                	jne    3dfc <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    3e0f:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
    3e15:	76 51                	jbe    3e68 <malloc+0xa0>
    3e17:	89 d8                	mov    %ebx,%eax
    3e19:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    3e1b:	89 04 24             	mov    %eax,(%esp)
    3e1e:	e8 ad fc ff ff       	call   3ad0 <sbrk>
  if(p == (char*)-1)
    3e23:	83 f8 ff             	cmp    $0xffffffff,%eax
    3e26:	74 18                	je     3e40 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    3e28:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    3e2b:	83 c0 08             	add    $0x8,%eax
    3e2e:	89 04 24             	mov    %eax,(%esp)
    3e31:	e8 12 ff ff ff       	call   3d48 <free>
  return freep;
    3e36:	8b 15 c0 5f 00 00    	mov    0x5fc0,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    3e3c:	85 d2                	test   %edx,%edx
    3e3e:	75 bc                	jne    3dfc <malloc+0x34>
        return 0;
    3e40:	31 c0                	xor    %eax,%eax
    3e42:	eb 1c                	jmp    3e60 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    3e44:	89 d0                	mov    %edx,%eax
    3e46:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
    3e48:	39 ce                	cmp    %ecx,%esi
    3e4a:	74 28                	je     3e74 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    3e4c:	29 f1                	sub    %esi,%ecx
    3e4e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    3e51:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    3e54:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
    3e57:	89 15 c0 5f 00 00    	mov    %edx,0x5fc0
      return (void*)(p + 1);
    3e5d:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    3e60:	83 c4 1c             	add    $0x1c,%esp
    3e63:	5b                   	pop    %ebx
    3e64:	5e                   	pop    %esi
    3e65:	5f                   	pop    %edi
    3e66:	5d                   	pop    %ebp
    3e67:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    3e68:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
    3e6d:	bf 00 10 00 00       	mov    $0x1000,%edi
    3e72:	eb a7                	jmp    3e1b <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    3e74:	8b 08                	mov    (%eax),%ecx
    3e76:	89 0a                	mov    %ecx,(%edx)
    3e78:	eb dd                	jmp    3e57 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    3e7a:	c7 05 c0 5f 00 00 c4 	movl   $0x5fc4,0x5fc0
    3e81:	5f 00 00 
    3e84:	c7 05 c4 5f 00 00 c4 	movl   $0x5fc4,0x5fc4
    3e8b:	5f 00 00 
    base.s.size = 0;
    3e8e:	c7 05 c8 5f 00 00 00 	movl   $0x0,0x5fc8
    3e95:	00 00 00 
    3e98:	ba c4 5f 00 00       	mov    $0x5fc4,%edx
    3e9d:	e9 50 ff ff ff       	jmp    3df2 <malloc+0x2a>
