
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 e4 f0             	and    $0xfffffff0,%esp
       6:	83 ec 10             	sub    $0x10,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
       9:	eb 0a                	jmp    15 <main+0x15>
       b:	90                   	nop
    if(fd >= 3){
       c:	83 f8 02             	cmp    $0x2,%eax
       f:	0f 8f c5 00 00 00    	jg     da <main+0xda>
{
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      15:	c7 44 24 04 02 00 00 	movl   $0x2,0x4(%esp)
      1c:	00 
      1d:	c7 04 24 c1 11 00 00 	movl   $0x11c1,(%esp)
      24:	e8 db 0c 00 00       	call   d04 <open>
      29:	85 c0                	test   %eax,%eax
      2b:	79 df                	jns    c <main+0xc>
      2d:	eb 1b                	jmp    4a <main+0x4a>
      2f:	90                   	nop
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      30:	80 3d c2 17 00 00 20 	cmpb   $0x20,0x17c2
      37:	74 5d                	je     96 <main+0x96>
      39:	8d 76 00             	lea    0x0(%esi),%esi
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      3c:	e8 23 01 00 00       	call   164 <fork1>
      41:	85 c0                	test   %eax,%eax
      43:	74 38                	je     7d <main+0x7d>
      runcmd(parsecmd(buf));
    wait();
      45:	e8 82 0c 00 00       	call   ccc <wait>
      break;
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
      4a:	c7 44 24 04 64 00 00 	movl   $0x64,0x4(%esp)
      51:	00 
      52:	c7 04 24 c0 17 00 00 	movl   $0x17c0,(%esp)
      59:	e8 8a 00 00 00       	call   e8 <getcmd>
      5e:	85 c0                	test   %eax,%eax
      60:	78 2f                	js     91 <main+0x91>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      62:	80 3d c0 17 00 00 63 	cmpb   $0x63,0x17c0
      69:	75 d1                	jne    3c <main+0x3c>
      6b:	80 3d c1 17 00 00 64 	cmpb   $0x64,0x17c1
      72:	74 bc                	je     30 <main+0x30>
      buf[strlen(buf)-1] = 0;  // chop \n
      if(chdir(buf+3) < 0)
        printf(2, "cannot cd %s\n", buf+3);
      continue;
    }
    if(fork1() == 0)
      74:	e8 eb 00 00 00       	call   164 <fork1>
      79:	85 c0                	test   %eax,%eax
      7b:	75 c8                	jne    45 <main+0x45>
      runcmd(parsecmd(buf));
      7d:	c7 04 24 c0 17 00 00 	movl   $0x17c0,(%esp)
      84:	e8 ff 09 00 00       	call   a88 <parsecmd>
      89:	89 04 24             	mov    %eax,(%esp)
      8c:	e8 f3 00 00 00       	call   184 <runcmd>
    wait();
  }
  exit();
      91:	e8 2e 0c 00 00       	call   cc4 <exit>

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      // Chdir must be called by the parent, not the child.
      buf[strlen(buf)-1] = 0;  // chop \n
      96:	c7 04 24 c0 17 00 00 	movl   $0x17c0,(%esp)
      9d:	e8 c2 0a 00 00       	call   b64 <strlen>
      a2:	c6 80 bf 17 00 00 00 	movb   $0x0,0x17bf(%eax)
      if(chdir(buf+3) < 0)
      a9:	c7 04 24 c3 17 00 00 	movl   $0x17c3,(%esp)
      b0:	e8 7f 0c 00 00       	call   d34 <chdir>
      b5:	85 c0                	test   %eax,%eax
      b7:	79 91                	jns    4a <main+0x4a>
        printf(2, "cannot cd %s\n", buf+3);
      b9:	c7 44 24 08 c3 17 00 	movl   $0x17c3,0x8(%esp)
      c0:	00 
      c1:	c7 44 24 04 c9 11 00 	movl   $0x11c9,0x4(%esp)
      c8:	00 
      c9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
      d0:	e8 23 0d 00 00       	call   df8 <printf>
      d5:	e9 70 ff ff ff       	jmp    4a <main+0x4a>
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
    if(fd >= 3){
      close(fd);
      da:	89 04 24             	mov    %eax,(%esp)
      dd:	e8 0a 0c 00 00       	call   cec <close>
      break;
      e2:	e9 63 ff ff ff       	jmp    4a <main+0x4a>
      e7:	90                   	nop

000000e8 <getcmd>:
  exit();
}

int
getcmd(char *buf, int nbuf)
{
      e8:	55                   	push   %ebp
      e9:	89 e5                	mov    %esp,%ebp
      eb:	56                   	push   %esi
      ec:	53                   	push   %ebx
      ed:	83 ec 10             	sub    $0x10,%esp
      f0:	8b 5d 08             	mov    0x8(%ebp),%ebx
      f3:	8b 75 0c             	mov    0xc(%ebp),%esi
  printf(2, "$ ");
      f6:	c7 44 24 04 20 11 00 	movl   $0x1120,0x4(%esp)
      fd:	00 
      fe:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     105:	e8 ee 0c 00 00       	call   df8 <printf>
  memset(buf, 0, nbuf);
     10a:	89 74 24 08          	mov    %esi,0x8(%esp)
     10e:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     115:	00 
     116:	89 1c 24             	mov    %ebx,(%esp)
     119:	e8 66 0a 00 00       	call   b84 <memset>
  gets(buf, nbuf);
     11e:	89 74 24 04          	mov    %esi,0x4(%esp)
     122:	89 1c 24             	mov    %ebx,(%esp)
     125:	e8 9a 0a 00 00       	call   bc4 <gets>
  if(buf[0] == 0) // EOF
     12a:	31 c0                	xor    %eax,%eax
     12c:	80 3b 00             	cmpb   $0x0,(%ebx)
     12f:	0f 94 c0             	sete   %al
     132:	f7 d8                	neg    %eax
    return -1;
  return 0;
}
     134:	83 c4 10             	add    $0x10,%esp
     137:	5b                   	pop    %ebx
     138:	5e                   	pop    %esi
     139:	5d                   	pop    %ebp
     13a:	c3                   	ret    
     13b:	90                   	nop

0000013c <panic>:
  exit();
}

void
panic(char *s)
{
     13c:	55                   	push   %ebp
     13d:	89 e5                	mov    %esp,%ebp
     13f:	83 ec 18             	sub    $0x18,%esp
  printf(2, "%s\n", s);
     142:	8b 45 08             	mov    0x8(%ebp),%eax
     145:	89 44 24 08          	mov    %eax,0x8(%esp)
     149:	c7 44 24 04 bd 11 00 	movl   $0x11bd,0x4(%esp)
     150:	00 
     151:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     158:	e8 9b 0c 00 00       	call   df8 <printf>
  exit();
     15d:	e8 62 0b 00 00       	call   cc4 <exit>
     162:	66 90                	xchg   %ax,%ax

00000164 <fork1>:
}

int
fork1(void)
{
     164:	55                   	push   %ebp
     165:	89 e5                	mov    %esp,%ebp
     167:	83 ec 18             	sub    $0x18,%esp
  int pid;

  pid = fork();
     16a:	e8 4d 0b 00 00       	call   cbc <fork>
  if(pid == -1)
     16f:	83 f8 ff             	cmp    $0xffffffff,%eax
     172:	74 02                	je     176 <fork1+0x12>
    panic("fork");
  return pid;
}
     174:	c9                   	leave  
     175:	c3                   	ret    
{
  int pid;

  pid = fork();
  if(pid == -1)
    panic("fork");
     176:	c7 04 24 23 11 00 00 	movl   $0x1123,(%esp)
     17d:	e8 ba ff ff ff       	call   13c <panic>
     182:	66 90                	xchg   %ax,%ax

00000184 <runcmd>:
struct cmd *parsecmd(char*);

// Execute cmd.  Never returns.
void
runcmd(struct cmd *cmd)
{
     184:	55                   	push   %ebp
     185:	89 e5                	mov    %esp,%ebp
     187:	53                   	push   %ebx
     188:	83 ec 24             	sub    $0x24,%esp
     18b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     18e:	85 db                	test   %ebx,%ebx
     190:	74 5f                	je     1f1 <runcmd+0x6d>
    exit();

  switch(cmd->type){
     192:	83 3b 05             	cmpl   $0x5,(%ebx)
     195:	0f 87 de 00 00 00    	ja     279 <runcmd+0xf5>
     19b:	8b 03                	mov    (%ebx),%eax
     19d:	ff 24 85 d8 11 00 00 	jmp    *0x11d8(,%eax,4)
    runcmd(lcmd->right);
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
     1a4:	8d 45 f0             	lea    -0x10(%ebp),%eax
     1a7:	89 04 24             	mov    %eax,(%esp)
     1aa:	e8 25 0b 00 00       	call   cd4 <pipe>
     1af:	85 c0                	test   %eax,%eax
     1b1:	0f 88 ce 00 00 00    	js     285 <runcmd+0x101>
      panic("pipe");
    if(fork1() == 0){
     1b7:	e8 a8 ff ff ff       	call   164 <fork1>
     1bc:	85 c0                	test   %eax,%eax
     1be:	0f 84 25 01 00 00    	je     2e9 <runcmd+0x165>
      dup(p[1]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
     1c4:	e8 9b ff ff ff       	call   164 <fork1>
     1c9:	85 c0                	test   %eax,%eax
     1cb:	0f 84 e0 00 00 00    	je     2b1 <runcmd+0x12d>
      dup(p[0]);
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->right);
    }
    close(p[0]);
     1d1:	8b 45 f0             	mov    -0x10(%ebp),%eax
     1d4:	89 04 24             	mov    %eax,(%esp)
     1d7:	e8 10 0b 00 00       	call   cec <close>
    close(p[1]);
     1dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
     1df:	89 04 24             	mov    %eax,(%esp)
     1e2:	e8 05 0b 00 00       	call   cec <close>
    wait();
     1e7:	e8 e0 0a 00 00       	call   ccc <wait>
    wait();
     1ec:	e8 db 0a 00 00       	call   ccc <wait>
  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
      exit();
     1f1:	e8 ce 0a 00 00       	call   cc4 <exit>
    wait();
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
     1f6:	e8 69 ff ff ff       	call   164 <fork1>
     1fb:	85 c0                	test   %eax,%eax
     1fd:	75 f2                	jne    1f1 <runcmd+0x6d>
     1ff:	eb 6d                	jmp    26e <runcmd+0xea>
  default:
    panic("runcmd");

  case EXEC:
    ecmd = (struct execcmd*)cmd;
    if(ecmd->argv[0] == 0)
     201:	8b 43 04             	mov    0x4(%ebx),%eax
     204:	85 c0                	test   %eax,%eax
     206:	74 e9                	je     1f1 <runcmd+0x6d>
      exit();
    exec(ecmd->argv[0], ecmd->argv);
     208:	8d 53 04             	lea    0x4(%ebx),%edx
     20b:	89 54 24 04          	mov    %edx,0x4(%esp)
     20f:	89 04 24             	mov    %eax,(%esp)
     212:	e8 e5 0a 00 00       	call   cfc <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     217:	8b 43 04             	mov    0x4(%ebx),%eax
     21a:	89 44 24 08          	mov    %eax,0x8(%esp)
     21e:	c7 44 24 04 2f 11 00 	movl   $0x112f,0x4(%esp)
     225:	00 
     226:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     22d:	e8 c6 0b 00 00       	call   df8 <printf>
    break;
     232:	eb bd                	jmp    1f1 <runcmd+0x6d>
    runcmd(rcmd->cmd);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    if(fork1() == 0)
     234:	e8 2b ff ff ff       	call   164 <fork1>
     239:	85 c0                	test   %eax,%eax
     23b:	74 31                	je     26e <runcmd+0xea>
      runcmd(lcmd->left);
    wait();
     23d:	e8 8a 0a 00 00       	call   ccc <wait>
    runcmd(lcmd->right);
     242:	8b 43 08             	mov    0x8(%ebx),%eax
     245:	89 04 24             	mov    %eax,(%esp)
     248:	e8 37 ff ff ff       	call   184 <runcmd>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
     24d:	8b 43 14             	mov    0x14(%ebx),%eax
     250:	89 04 24             	mov    %eax,(%esp)
     253:	e8 94 0a 00 00       	call   cec <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     258:	8b 43 10             	mov    0x10(%ebx),%eax
     25b:	89 44 24 04          	mov    %eax,0x4(%esp)
     25f:	8b 43 08             	mov    0x8(%ebx),%eax
     262:	89 04 24             	mov    %eax,(%esp)
     265:	e8 9a 0a 00 00       	call   d04 <open>
     26a:	85 c0                	test   %eax,%eax
     26c:	78 23                	js     291 <runcmd+0x10d>
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    if(fork1() == 0)
      runcmd(bcmd->cmd);
     26e:	8b 43 04             	mov    0x4(%ebx),%eax
     271:	89 04 24             	mov    %eax,(%esp)
     274:	e8 0b ff ff ff       	call   184 <runcmd>
  if(cmd == 0)
    exit();

  switch(cmd->type){
  default:
    panic("runcmd");
     279:	c7 04 24 28 11 00 00 	movl   $0x1128,(%esp)
     280:	e8 b7 fe ff ff       	call   13c <panic>
    break;

  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
     285:	c7 04 24 4f 11 00 00 	movl   $0x114f,(%esp)
     28c:	e8 ab fe ff ff       	call   13c <panic>

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    close(rcmd->fd);
    if(open(rcmd->file, rcmd->mode) < 0){
      printf(2, "open %s failed\n", rcmd->file);
     291:	8b 43 08             	mov    0x8(%ebx),%eax
     294:	89 44 24 08          	mov    %eax,0x8(%esp)
     298:	c7 44 24 04 3f 11 00 	movl   $0x113f,0x4(%esp)
     29f:	00 
     2a0:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     2a7:	e8 4c 0b 00 00       	call   df8 <printf>
     2ac:	e9 40 ff ff ff       	jmp    1f1 <runcmd+0x6d>
      close(p[0]);
      close(p[1]);
      runcmd(pcmd->left);
    }
    if(fork1() == 0){
      close(0);
     2b1:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     2b8:	e8 2f 0a 00 00       	call   cec <close>
      dup(p[0]);
     2bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2c0:	89 04 24             	mov    %eax,(%esp)
     2c3:	e8 74 0a 00 00       	call   d3c <dup>
      close(p[0]);
     2c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
     2cb:	89 04 24             	mov    %eax,(%esp)
     2ce:	e8 19 0a 00 00       	call   cec <close>
      close(p[1]);
     2d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2d6:	89 04 24             	mov    %eax,(%esp)
     2d9:	e8 0e 0a 00 00       	call   cec <close>
      runcmd(pcmd->right);
     2de:	8b 43 08             	mov    0x8(%ebx),%eax
     2e1:	89 04 24             	mov    %eax,(%esp)
     2e4:	e8 9b fe ff ff       	call   184 <runcmd>
  case PIPE:
    pcmd = (struct pipecmd*)cmd;
    if(pipe(p) < 0)
      panic("pipe");
    if(fork1() == 0){
      close(1);
     2e9:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     2f0:	e8 f7 09 00 00       	call   cec <close>
      dup(p[1]);
     2f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
     2f8:	89 04 24             	mov    %eax,(%esp)
     2fb:	e8 3c 0a 00 00       	call   d3c <dup>
      close(p[0]);
     300:	8b 45 f0             	mov    -0x10(%ebp),%eax
     303:	89 04 24             	mov    %eax,(%esp)
     306:	e8 e1 09 00 00       	call   cec <close>
      close(p[1]);
     30b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     30e:	89 04 24             	mov    %eax,(%esp)
     311:	e8 d6 09 00 00       	call   cec <close>
      runcmd(pcmd->left);
     316:	8b 43 04             	mov    0x4(%ebx),%eax
     319:	89 04 24             	mov    %eax,(%esp)
     31c:	e8 63 fe ff ff       	call   184 <runcmd>
     321:	8d 76 00             	lea    0x0(%esi),%esi

00000324 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     324:	55                   	push   %ebp
     325:	89 e5                	mov    %esp,%ebp
     327:	53                   	push   %ebx
     328:	83 ec 14             	sub    $0x14,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     32b:	c7 04 24 54 00 00 00 	movl   $0x54,(%esp)
     332:	e8 0d 0d 00 00       	call   1044 <malloc>
     337:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     339:	c7 44 24 08 54 00 00 	movl   $0x54,0x8(%esp)
     340:	00 
     341:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     348:	00 
     349:	89 04 24             	mov    %eax,(%esp)
     34c:	e8 33 08 00 00       	call   b84 <memset>
  cmd->type = EXEC;
     351:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     357:	89 d8                	mov    %ebx,%eax
     359:	83 c4 14             	add    $0x14,%esp
     35c:	5b                   	pop    %ebx
     35d:	5d                   	pop    %ebp
     35e:	c3                   	ret    
     35f:	90                   	nop

00000360 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 14             	sub    $0x14,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	c7 04 24 18 00 00 00 	movl   $0x18,(%esp)
     36e:	e8 d1 0c 00 00       	call   1044 <malloc>
     373:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     375:	c7 44 24 08 18 00 00 	movl   $0x18,0x8(%esp)
     37c:	00 
     37d:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     384:	00 
     385:	89 04 24             	mov    %eax,(%esp)
     388:	e8 f7 07 00 00       	call   b84 <memset>
  cmd->type = REDIR;
     38d:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     393:	8b 45 08             	mov    0x8(%ebp),%eax
     396:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     399:	8b 45 0c             	mov    0xc(%ebp),%eax
     39c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     39f:	8b 45 10             	mov    0x10(%ebp),%eax
     3a2:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     3a5:	8b 45 14             	mov    0x14(%ebp),%eax
     3a8:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     3ab:	8b 45 18             	mov    0x18(%ebp),%eax
     3ae:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3b1:	89 d8                	mov    %ebx,%eax
     3b3:	83 c4 14             	add    $0x14,%esp
     3b6:	5b                   	pop    %ebx
     3b7:	5d                   	pop    %ebp
     3b8:	c3                   	ret    
     3b9:	8d 76 00             	lea    0x0(%esi),%esi

000003bc <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3bc:	55                   	push   %ebp
     3bd:	89 e5                	mov    %esp,%ebp
     3bf:	53                   	push   %ebx
     3c0:	83 ec 14             	sub    $0x14,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3c3:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     3ca:	e8 75 0c 00 00       	call   1044 <malloc>
     3cf:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3d1:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     3d8:	00 
     3d9:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     3e0:	00 
     3e1:	89 04 24             	mov    %eax,(%esp)
     3e4:	e8 9b 07 00 00       	call   b84 <memset>
  cmd->type = PIPE;
     3e9:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3ef:	8b 45 08             	mov    0x8(%ebp),%eax
     3f2:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3f5:	8b 45 0c             	mov    0xc(%ebp),%eax
     3f8:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3fb:	89 d8                	mov    %ebx,%eax
     3fd:	83 c4 14             	add    $0x14,%esp
     400:	5b                   	pop    %ebx
     401:	5d                   	pop    %ebp
     402:	c3                   	ret    
     403:	90                   	nop

00000404 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     404:	55                   	push   %ebp
     405:	89 e5                	mov    %esp,%ebp
     407:	53                   	push   %ebx
     408:	83 ec 14             	sub    $0x14,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     40b:	c7 04 24 0c 00 00 00 	movl   $0xc,(%esp)
     412:	e8 2d 0c 00 00       	call   1044 <malloc>
     417:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     419:	c7 44 24 08 0c 00 00 	movl   $0xc,0x8(%esp)
     420:	00 
     421:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     428:	00 
     429:	89 04 24             	mov    %eax,(%esp)
     42c:	e8 53 07 00 00       	call   b84 <memset>
  cmd->type = LIST;
     431:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     437:	8b 45 08             	mov    0x8(%ebp),%eax
     43a:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     43d:	8b 45 0c             	mov    0xc(%ebp),%eax
     440:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     443:	89 d8                	mov    %ebx,%eax
     445:	83 c4 14             	add    $0x14,%esp
     448:	5b                   	pop    %ebx
     449:	5d                   	pop    %ebp
     44a:	c3                   	ret    
     44b:	90                   	nop

0000044c <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     44c:	55                   	push   %ebp
     44d:	89 e5                	mov    %esp,%ebp
     44f:	53                   	push   %ebx
     450:	83 ec 14             	sub    $0x14,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     453:	c7 04 24 08 00 00 00 	movl   $0x8,(%esp)
     45a:	e8 e5 0b 00 00       	call   1044 <malloc>
     45f:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     461:	c7 44 24 08 08 00 00 	movl   $0x8,0x8(%esp)
     468:	00 
     469:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     470:	00 
     471:	89 04 24             	mov    %eax,(%esp)
     474:	e8 0b 07 00 00       	call   b84 <memset>
  cmd->type = BACK;
     479:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     47f:	8b 45 08             	mov    0x8(%ebp),%eax
     482:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     485:	89 d8                	mov    %ebx,%eax
     487:	83 c4 14             	add    $0x14,%esp
     48a:	5b                   	pop    %ebx
     48b:	5d                   	pop    %ebp
     48c:	c3                   	ret    
     48d:	8d 76 00             	lea    0x0(%esi),%esi

00000490 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     490:	55                   	push   %ebp
     491:	89 e5                	mov    %esp,%ebp
     493:	57                   	push   %edi
     494:	56                   	push   %esi
     495:	53                   	push   %ebx
     496:	83 ec 1c             	sub    $0x1c,%esp
     499:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     49c:	8b 75 10             	mov    0x10(%ebp),%esi
  char *s;
  int ret;

  s = *ps;
     49f:	8b 45 08             	mov    0x8(%ebp),%eax
     4a2:	8b 38                	mov    (%eax),%edi
  while(s < es && strchr(whitespace, *s))
     4a4:	39 df                	cmp    %ebx,%edi
     4a6:	72 09                	jb     4b1 <gettoken+0x21>
     4a8:	eb 1e                	jmp    4c8 <gettoken+0x38>
     4aa:	66 90                	xchg   %ax,%ax
    s++;
     4ac:	47                   	inc    %edi
{
  char *s;
  int ret;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     4ad:	39 df                	cmp    %ebx,%edi
     4af:	74 17                	je     4c8 <gettoken+0x38>
     4b1:	0f be 07             	movsbl (%edi),%eax
     4b4:	89 44 24 04          	mov    %eax,0x4(%esp)
     4b8:	c7 04 24 b4 17 00 00 	movl   $0x17b4,(%esp)
     4bf:	e8 d8 06 00 00       	call   b9c <strchr>
     4c4:	85 c0                	test   %eax,%eax
     4c6:	75 e4                	jne    4ac <gettoken+0x1c>
    s++;
  if(q)
     4c8:	85 f6                	test   %esi,%esi
     4ca:	74 02                	je     4ce <gettoken+0x3e>
    *q = s;
     4cc:	89 3e                	mov    %edi,(%esi)
  ret = *s;
     4ce:	8a 0f                	mov    (%edi),%cl
     4d0:	0f be f1             	movsbl %cl,%esi
     4d3:	89 f0                	mov    %esi,%eax
  switch(*s){
     4d5:	80 f9 29             	cmp    $0x29,%cl
     4d8:	7f 4e                	jg     528 <gettoken+0x98>
     4da:	80 f9 28             	cmp    $0x28,%cl
     4dd:	7d 54                	jge    533 <gettoken+0xa3>
     4df:	84 c9                	test   %cl,%cl
     4e1:	0f 85 bd 00 00 00    	jne    5a4 <gettoken+0x114>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4e7:	8b 45 14             	mov    0x14(%ebp),%eax
     4ea:	85 c0                	test   %eax,%eax
     4ec:	74 05                	je     4f3 <gettoken+0x63>
    *eq = s;
     4ee:	8b 45 14             	mov    0x14(%ebp),%eax
     4f1:	89 38                	mov    %edi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4f3:	39 df                	cmp    %ebx,%edi
     4f5:	72 0a                	jb     501 <gettoken+0x71>
     4f7:	eb 1f                	jmp    518 <gettoken+0x88>
     4f9:	8d 76 00             	lea    0x0(%esi),%esi
    s++;
     4fc:	47                   	inc    %edi
    break;
  }
  if(eq)
    *eq = s;

  while(s < es && strchr(whitespace, *s))
     4fd:	39 df                	cmp    %ebx,%edi
     4ff:	74 17                	je     518 <gettoken+0x88>
     501:	0f be 07             	movsbl (%edi),%eax
     504:	89 44 24 04          	mov    %eax,0x4(%esp)
     508:	c7 04 24 b4 17 00 00 	movl   $0x17b4,(%esp)
     50f:	e8 88 06 00 00       	call   b9c <strchr>
     514:	85 c0                	test   %eax,%eax
     516:	75 e4                	jne    4fc <gettoken+0x6c>
    s++;
  *ps = s;
     518:	8b 45 08             	mov    0x8(%ebp),%eax
     51b:	89 38                	mov    %edi,(%eax)
  return ret;
}
     51d:	89 f0                	mov    %esi,%eax
     51f:	83 c4 1c             	add    $0x1c,%esp
     522:	5b                   	pop    %ebx
     523:	5e                   	pop    %esi
     524:	5f                   	pop    %edi
     525:	5d                   	pop    %ebp
     526:	c3                   	ret    
     527:	90                   	nop
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     528:	80 f9 3e             	cmp    $0x3e,%cl
     52b:	75 0b                	jne    538 <gettoken+0xa8>
  case '<':
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
     52d:	80 7f 01 3e          	cmpb   $0x3e,0x1(%edi)
     531:	74 61                	je     594 <gettoken+0x104>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     533:	47                   	inc    %edi
     534:	eb b1                	jmp    4e7 <gettoken+0x57>
     536:	66 90                	xchg   %ax,%ax
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     538:	7f 4e                	jg     588 <gettoken+0xf8>
     53a:	83 e9 3b             	sub    $0x3b,%ecx
     53d:	80 f9 01             	cmp    $0x1,%cl
     540:	76 f1                	jbe    533 <gettoken+0xa3>
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     542:	39 fb                	cmp    %edi,%ebx
     544:	77 21                	ja     567 <gettoken+0xd7>
     546:	eb 33                	jmp    57b <gettoken+0xeb>
     548:	0f be 07             	movsbl (%edi),%eax
     54b:	89 44 24 04          	mov    %eax,0x4(%esp)
     54f:	c7 04 24 ac 17 00 00 	movl   $0x17ac,(%esp)
     556:	e8 41 06 00 00       	call   b9c <strchr>
     55b:	85 c0                	test   %eax,%eax
     55d:	75 1c                	jne    57b <gettoken+0xeb>
      s++;
     55f:	47                   	inc    %edi
      s++;
    }
    break;
  default:
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     560:	39 df                	cmp    %ebx,%edi
     562:	74 17                	je     57b <gettoken+0xeb>
     564:	0f be 07             	movsbl (%edi),%eax
     567:	89 44 24 04          	mov    %eax,0x4(%esp)
     56b:	c7 04 24 b4 17 00 00 	movl   $0x17b4,(%esp)
     572:	e8 25 06 00 00       	call   b9c <strchr>
     577:	85 c0                	test   %eax,%eax
     579:	74 cd                	je     548 <gettoken+0xb8>
      ret = '+';
      s++;
    }
    break;
  default:
    ret = 'a';
     57b:	be 61 00 00 00       	mov    $0x61,%esi
     580:	e9 62 ff ff ff       	jmp    4e7 <gettoken+0x57>
     585:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     588:	80 f9 7c             	cmp    $0x7c,%cl
     58b:	75 b5                	jne    542 <gettoken+0xb2>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     58d:	47                   	inc    %edi
     58e:	e9 54 ff ff ff       	jmp    4e7 <gettoken+0x57>
     593:	90                   	nop
    if(*s == '>'){
      ret = '+';
      s++;
     594:	83 c7 02             	add    $0x2,%edi
    s++;
    break;
  case '>':
    s++;
    if(*s == '>'){
      ret = '+';
     597:	be 2b 00 00 00       	mov    $0x2b,%esi
     59c:	e9 46 ff ff ff       	jmp    4e7 <gettoken+0x57>
     5a1:	8d 76 00             	lea    0x0(%esi),%esi
  while(s < es && strchr(whitespace, *s))
    s++;
  if(q)
    *q = s;
  ret = *s;
  switch(*s){
     5a4:	80 f9 26             	cmp    $0x26,%cl
     5a7:	75 99                	jne    542 <gettoken+0xb2>
  case '&':
  case '<':
    s++;
    break;
  case '>':
    s++;
     5a9:	47                   	inc    %edi
     5aa:	e9 38 ff ff ff       	jmp    4e7 <gettoken+0x57>
     5af:	90                   	nop

000005b0 <peek>:
  return ret;
}

int
peek(char **ps, char *es, char *toks)
{
     5b0:	55                   	push   %ebp
     5b1:	89 e5                	mov    %esp,%ebp
     5b3:	57                   	push   %edi
     5b4:	56                   	push   %esi
     5b5:	53                   	push   %ebx
     5b6:	83 ec 1c             	sub    $0x1c,%esp
     5b9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5bc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5bf:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5c1:	39 f3                	cmp    %esi,%ebx
     5c3:	72 08                	jb     5cd <peek+0x1d>
     5c5:	eb 1d                	jmp    5e4 <peek+0x34>
     5c7:	90                   	nop
    s++;
     5c8:	43                   	inc    %ebx
peek(char **ps, char *es, char *toks)
{
  char *s;

  s = *ps;
  while(s < es && strchr(whitespace, *s))
     5c9:	39 f3                	cmp    %esi,%ebx
     5cb:	74 17                	je     5e4 <peek+0x34>
     5cd:	0f be 03             	movsbl (%ebx),%eax
     5d0:	89 44 24 04          	mov    %eax,0x4(%esp)
     5d4:	c7 04 24 b4 17 00 00 	movl   $0x17b4,(%esp)
     5db:	e8 bc 05 00 00       	call   b9c <strchr>
     5e0:	85 c0                	test   %eax,%eax
     5e2:	75 e4                	jne    5c8 <peek+0x18>
    s++;
  *ps = s;
     5e4:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     5e6:	0f be 03             	movsbl (%ebx),%eax
     5e9:	84 c0                	test   %al,%al
     5eb:	75 0b                	jne    5f8 <peek+0x48>
     5ed:	31 c0                	xor    %eax,%eax
}
     5ef:	83 c4 1c             	add    $0x1c,%esp
     5f2:	5b                   	pop    %ebx
     5f3:	5e                   	pop    %esi
     5f4:	5f                   	pop    %edi
     5f5:	5d                   	pop    %ebp
     5f6:	c3                   	ret    
     5f7:	90                   	nop

  s = *ps;
  while(s < es && strchr(whitespace, *s))
    s++;
  *ps = s;
  return *s && strchr(toks, *s);
     5f8:	89 44 24 04          	mov    %eax,0x4(%esp)
     5fc:	8b 45 10             	mov    0x10(%ebp),%eax
     5ff:	89 04 24             	mov    %eax,(%esp)
     602:	e8 95 05 00 00       	call   b9c <strchr>
     607:	85 c0                	test   %eax,%eax
     609:	0f 95 c0             	setne  %al
     60c:	0f b6 c0             	movzbl %al,%eax
}
     60f:	83 c4 1c             	add    $0x1c,%esp
     612:	5b                   	pop    %ebx
     613:	5e                   	pop    %esi
     614:	5f                   	pop    %edi
     615:	5d                   	pop    %ebp
     616:	c3                   	ret    
     617:	90                   	nop

00000618 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     618:	55                   	push   %ebp
     619:	89 e5                	mov    %esp,%ebp
     61b:	57                   	push   %edi
     61c:	56                   	push   %esi
     61d:	53                   	push   %ebx
     61e:	83 ec 3c             	sub    $0x3c,%esp
     621:	8b 75 0c             	mov    0xc(%ebp),%esi
     624:	8b 5d 10             	mov    0x10(%ebp),%ebx
     627:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     628:	c7 44 24 08 71 11 00 	movl   $0x1171,0x8(%esp)
     62f:	00 
     630:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     634:	89 34 24             	mov    %esi,(%esp)
     637:	e8 74 ff ff ff       	call   5b0 <peek>
     63c:	85 c0                	test   %eax,%eax
     63e:	0f 84 94 00 00 00    	je     6d8 <parseredirs+0xc0>
    tok = gettoken(ps, es, 0, 0);
     644:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     64b:	00 
     64c:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     653:	00 
     654:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     658:	89 34 24             	mov    %esi,(%esp)
     65b:	e8 30 fe ff ff       	call   490 <gettoken>
     660:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     662:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     665:	89 44 24 0c          	mov    %eax,0xc(%esp)
     669:	8d 45 e0             	lea    -0x20(%ebp),%eax
     66c:	89 44 24 08          	mov    %eax,0x8(%esp)
     670:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     674:	89 34 24             	mov    %esi,(%esp)
     677:	e8 14 fe ff ff       	call   490 <gettoken>
     67c:	83 f8 61             	cmp    $0x61,%eax
     67f:	75 62                	jne    6e3 <parseredirs+0xcb>
      panic("missing file for redirection");
    switch(tok){
     681:	83 ff 3c             	cmp    $0x3c,%edi
     684:	74 3e                	je     6c4 <parseredirs+0xac>
     686:	83 ff 3e             	cmp    $0x3e,%edi
     689:	74 05                	je     690 <parseredirs+0x78>
     68b:	83 ff 2b             	cmp    $0x2b,%edi
     68e:	75 98                	jne    628 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     690:	c7 44 24 10 01 00 00 	movl   $0x1,0x10(%esp)
     697:	00 
     698:	c7 44 24 0c 01 02 00 	movl   $0x201,0xc(%esp)
     69f:	00 
     6a0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     6a3:	89 44 24 08          	mov    %eax,0x8(%esp)
     6a7:	8b 45 e0             	mov    -0x20(%ebp),%eax
     6aa:	89 44 24 04          	mov    %eax,0x4(%esp)
     6ae:	8b 45 08             	mov    0x8(%ebp),%eax
     6b1:	89 04 24             	mov    %eax,(%esp)
     6b4:	e8 a7 fc ff ff       	call   360 <redircmd>
     6b9:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6bc:	e9 67 ff ff ff       	jmp    628 <parseredirs+0x10>
     6c1:	8d 76 00             	lea    0x0(%esi),%esi
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
    switch(tok){
    case '<':
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c4:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
     6cb:	00 
     6cc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     6d3:	00 
     6d4:	eb ca                	jmp    6a0 <parseredirs+0x88>
     6d6:	66 90                	xchg   %ax,%ax
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    }
  }
  return cmd;
}
     6d8:	8b 45 08             	mov    0x8(%ebp),%eax
     6db:	83 c4 3c             	add    $0x3c,%esp
     6de:	5b                   	pop    %ebx
     6df:	5e                   	pop    %esi
     6e0:	5f                   	pop    %edi
     6e1:	5d                   	pop    %ebp
     6e2:	c3                   	ret    
  char *q, *eq;

  while(peek(ps, es, "<>")){
    tok = gettoken(ps, es, 0, 0);
    if(gettoken(ps, es, &q, &eq) != 'a')
      panic("missing file for redirection");
     6e3:	c7 04 24 54 11 00 00 	movl   $0x1154,(%esp)
     6ea:	e8 4d fa ff ff       	call   13c <panic>
     6ef:	90                   	nop

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 3c             	sub    $0x3c,%esp
     6f9:	8b 75 08             	mov    0x8(%ebp),%esi
     6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ff:	c7 44 24 08 74 11 00 	movl   $0x1174,0x8(%esp)
     706:	00 
     707:	89 7c 24 04          	mov    %edi,0x4(%esp)
     70b:	89 34 24             	mov    %esi,(%esp)
     70e:	e8 9d fe ff ff       	call   5b0 <peek>
     713:	85 c0                	test   %eax,%eax
     715:	0f 85 a1 00 00 00    	jne    7bc <parseexec+0xcc>
    return parseblock(ps, es);

  ret = execcmd();
     71b:	e8 04 fc ff ff       	call   324 <execcmd>
     720:	89 c3                	mov    %eax,%ebx
     722:	89 45 cc             	mov    %eax,-0x34(%ebp)
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     725:	89 7c 24 08          	mov    %edi,0x8(%esp)
     729:	89 74 24 04          	mov    %esi,0x4(%esp)
     72d:	89 04 24             	mov    %eax,(%esp)
     730:	e8 e3 fe ff ff       	call   618 <parseredirs>
     735:	89 45 d0             	mov    %eax,-0x30(%ebp)
    return parseblock(ps, es);

  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
     738:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     73f:	eb 19                	jmp    75a <parseexec+0x6a>
     741:	8d 76 00             	lea    0x0(%esi),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     744:	89 7c 24 08          	mov    %edi,0x8(%esp)
     748:	89 74 24 04          	mov    %esi,0x4(%esp)
     74c:	8b 45 d0             	mov    -0x30(%ebp),%eax
     74f:	89 04 24             	mov    %eax,(%esp)
     752:	e8 c1 fe ff ff       	call   618 <parseredirs>
     757:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = execcmd();
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
     75a:	c7 44 24 08 8b 11 00 	movl   $0x118b,0x8(%esp)
     761:	00 
     762:	89 7c 24 04          	mov    %edi,0x4(%esp)
     766:	89 34 24             	mov    %esi,(%esp)
     769:	e8 42 fe ff ff       	call   5b0 <peek>
     76e:	85 c0                	test   %eax,%eax
     770:	75 5e                	jne    7d0 <parseexec+0xe0>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     772:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     775:	89 44 24 0c          	mov    %eax,0xc(%esp)
     779:	8d 45 e0             	lea    -0x20(%ebp),%eax
     77c:	89 44 24 08          	mov    %eax,0x8(%esp)
     780:	89 7c 24 04          	mov    %edi,0x4(%esp)
     784:	89 34 24             	mov    %esi,(%esp)
     787:	e8 04 fd ff ff       	call   490 <gettoken>
     78c:	85 c0                	test   %eax,%eax
     78e:	74 40                	je     7d0 <parseexec+0xe0>
      break;
    if(tok != 'a')
     790:	83 f8 61             	cmp    $0x61,%eax
     793:	75 5d                	jne    7f2 <parseexec+0x102>
      panic("syntax");
    cmd->argv[argc] = q;
     795:	8b 45 e0             	mov    -0x20(%ebp),%eax
     798:	89 43 04             	mov    %eax,0x4(%ebx)
    cmd->eargv[argc] = eq;
     79b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     79e:	89 43 2c             	mov    %eax,0x2c(%ebx)
    argc++;
     7a1:	ff 45 d4             	incl   -0x2c(%ebp)
     7a4:	83 c3 04             	add    $0x4,%ebx
    if(argc >= MAXARGS)
     7a7:	83 7d d4 0a          	cmpl   $0xa,-0x2c(%ebp)
     7ab:	75 97                	jne    744 <parseexec+0x54>
      panic("too many args");
     7ad:	c7 04 24 7d 11 00 00 	movl   $0x117d,(%esp)
     7b4:	e8 83 f9 ff ff       	call   13c <panic>
     7b9:	8d 76 00             	lea    0x0(%esi),%esi
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
    return parseblock(ps, es);
     7bc:	89 7c 24 04          	mov    %edi,0x4(%esp)
     7c0:	89 34 24             	mov    %esi,(%esp)
     7c3:	e8 70 01 00 00       	call   938 <parseblock>
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7c8:	83 c4 3c             	add    $0x3c,%esp
     7cb:	5b                   	pop    %ebx
     7cc:	5e                   	pop    %esi
     7cd:	5f                   	pop    %edi
     7ce:	5d                   	pop    %ebp
     7cf:	c3                   	ret    
     7d0:	8b 45 cc             	mov    -0x34(%ebp),%eax
     7d3:	8b 55 d4             	mov    -0x2c(%ebp),%edx
     7d6:	8d 04 90             	lea    (%eax,%edx,4),%eax
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
  }
  cmd->argv[argc] = 0;
     7d9:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7e0:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
  return ret;
     7e7:	8b 45 d0             	mov    -0x30(%ebp),%eax
}
     7ea:	83 c4 3c             	add    $0x3c,%esp
     7ed:	5b                   	pop    %ebx
     7ee:	5e                   	pop    %esi
     7ef:	5f                   	pop    %edi
     7f0:	5d                   	pop    %ebp
     7f1:	c3                   	ret    
  ret = parseredirs(ret, ps, es);
  while(!peek(ps, es, "|)&;")){
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
      break;
    if(tok != 'a')
      panic("syntax");
     7f2:	c7 04 24 76 11 00 00 	movl   $0x1176,(%esp)
     7f9:	e8 3e f9 ff ff       	call   13c <panic>
     7fe:	66 90                	xchg   %ax,%ax

00000800 <parsepipe>:
  return cmd;
}

struct cmd*
parsepipe(char **ps, char *es)
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 1c             	sub    $0x1c,%esp
     809:	8b 5d 08             	mov    0x8(%ebp),%ebx
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parseexec(ps, es);
     80f:	89 74 24 04          	mov    %esi,0x4(%esp)
     813:	89 1c 24             	mov    %ebx,(%esp)
     816:	e8 d5 fe ff ff       	call   6f0 <parseexec>
     81b:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     81d:	c7 44 24 08 90 11 00 	movl   $0x1190,0x8(%esp)
     824:	00 
     825:	89 74 24 04          	mov    %esi,0x4(%esp)
     829:	89 1c 24             	mov    %ebx,(%esp)
     82c:	e8 7f fd ff ff       	call   5b0 <peek>
     831:	85 c0                	test   %eax,%eax
     833:	75 0b                	jne    840 <parsepipe+0x40>
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
  }
  return cmd;
}
     835:	89 f8                	mov    %edi,%eax
     837:	83 c4 1c             	add    $0x1c,%esp
     83a:	5b                   	pop    %ebx
     83b:	5e                   	pop    %esi
     83c:	5f                   	pop    %edi
     83d:	5d                   	pop    %ebp
     83e:	c3                   	ret    
     83f:	90                   	nop
{
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
     840:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     847:	00 
     848:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     84f:	00 
     850:	89 74 24 04          	mov    %esi,0x4(%esp)
     854:	89 1c 24             	mov    %ebx,(%esp)
     857:	e8 34 fc ff ff       	call   490 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     85c:	89 74 24 04          	mov    %esi,0x4(%esp)
     860:	89 1c 24             	mov    %ebx,(%esp)
     863:	e8 98 ff ff ff       	call   800 <parsepipe>
     868:	89 45 0c             	mov    %eax,0xc(%ebp)
     86b:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     86e:	83 c4 1c             	add    $0x1c,%esp
     871:	5b                   	pop    %ebx
     872:	5e                   	pop    %esi
     873:	5f                   	pop    %edi
     874:	5d                   	pop    %ebp
  struct cmd *cmd;

  cmd = parseexec(ps, es);
  if(peek(ps, es, "|")){
    gettoken(ps, es, 0, 0);
    cmd = pipecmd(cmd, parsepipe(ps, es));
     875:	e9 42 fb ff ff       	jmp    3bc <pipecmd>
     87a:	66 90                	xchg   %ax,%ax

0000087c <parseline>:
  return cmd;
}

struct cmd*
parseline(char **ps, char *es)
{
     87c:	55                   	push   %ebp
     87d:	89 e5                	mov    %esp,%ebp
     87f:	57                   	push   %edi
     880:	56                   	push   %esi
     881:	53                   	push   %ebx
     882:	83 ec 1c             	sub    $0x1c,%esp
     885:	8b 5d 08             	mov    0x8(%ebp),%ebx
     888:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
     88b:	89 74 24 04          	mov    %esi,0x4(%esp)
     88f:	89 1c 24             	mov    %ebx,(%esp)
     892:	e8 69 ff ff ff       	call   800 <parsepipe>
     897:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     899:	eb 27                	jmp    8c2 <parseline+0x46>
     89b:	90                   	nop
    gettoken(ps, es, 0, 0);
     89c:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     8a3:	00 
     8a4:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     8ab:	00 
     8ac:	89 74 24 04          	mov    %esi,0x4(%esp)
     8b0:	89 1c 24             	mov    %ebx,(%esp)
     8b3:	e8 d8 fb ff ff       	call   490 <gettoken>
    cmd = backcmd(cmd);
     8b8:	89 3c 24             	mov    %edi,(%esp)
     8bb:	e8 8c fb ff ff       	call   44c <backcmd>
     8c0:	89 c7                	mov    %eax,%edi
parseline(char **ps, char *es)
{
  struct cmd *cmd;

  cmd = parsepipe(ps, es);
  while(peek(ps, es, "&")){
     8c2:	c7 44 24 08 92 11 00 	movl   $0x1192,0x8(%esp)
     8c9:	00 
     8ca:	89 74 24 04          	mov    %esi,0x4(%esp)
     8ce:	89 1c 24             	mov    %ebx,(%esp)
     8d1:	e8 da fc ff ff       	call   5b0 <peek>
     8d6:	85 c0                	test   %eax,%eax
     8d8:	75 c2                	jne    89c <parseline+0x20>
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
     8da:	c7 44 24 08 8e 11 00 	movl   $0x118e,0x8(%esp)
     8e1:	00 
     8e2:	89 74 24 04          	mov    %esi,0x4(%esp)
     8e6:	89 1c 24             	mov    %ebx,(%esp)
     8e9:	e8 c2 fc ff ff       	call   5b0 <peek>
     8ee:	85 c0                	test   %eax,%eax
     8f0:	75 0a                	jne    8fc <parseline+0x80>
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
  }
  return cmd;
}
     8f2:	89 f8                	mov    %edi,%eax
     8f4:	83 c4 1c             	add    $0x1c,%esp
     8f7:	5b                   	pop    %ebx
     8f8:	5e                   	pop    %esi
     8f9:	5f                   	pop    %edi
     8fa:	5d                   	pop    %ebp
     8fb:	c3                   	ret    
  while(peek(ps, es, "&")){
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
     8fc:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     903:	00 
     904:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     90b:	00 
     90c:	89 74 24 04          	mov    %esi,0x4(%esp)
     910:	89 1c 24             	mov    %ebx,(%esp)
     913:	e8 78 fb ff ff       	call   490 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     918:	89 74 24 04          	mov    %esi,0x4(%esp)
     91c:	89 1c 24             	mov    %ebx,(%esp)
     91f:	e8 58 ff ff ff       	call   87c <parseline>
     924:	89 45 0c             	mov    %eax,0xc(%ebp)
     927:	89 7d 08             	mov    %edi,0x8(%ebp)
  }
  return cmd;
}
     92a:	83 c4 1c             	add    $0x1c,%esp
     92d:	5b                   	pop    %ebx
     92e:	5e                   	pop    %esi
     92f:	5f                   	pop    %edi
     930:	5d                   	pop    %ebp
    gettoken(ps, es, 0, 0);
    cmd = backcmd(cmd);
  }
  if(peek(ps, es, ";")){
    gettoken(ps, es, 0, 0);
    cmd = listcmd(cmd, parseline(ps, es));
     931:	e9 ce fa ff ff       	jmp    404 <listcmd>
     936:	66 90                	xchg   %ax,%ax

00000938 <parseblock>:
  return cmd;
}

struct cmd*
parseblock(char **ps, char *es)
{
     938:	55                   	push   %ebp
     939:	89 e5                	mov    %esp,%ebp
     93b:	57                   	push   %edi
     93c:	56                   	push   %esi
     93d:	53                   	push   %ebx
     93e:	83 ec 1c             	sub    $0x1c,%esp
     941:	8b 5d 08             	mov    0x8(%ebp),%ebx
     944:	8b 75 0c             	mov    0xc(%ebp),%esi
  struct cmd *cmd;

  if(!peek(ps, es, "("))
     947:	c7 44 24 08 74 11 00 	movl   $0x1174,0x8(%esp)
     94e:	00 
     94f:	89 74 24 04          	mov    %esi,0x4(%esp)
     953:	89 1c 24             	mov    %ebx,(%esp)
     956:	e8 55 fc ff ff       	call   5b0 <peek>
     95b:	85 c0                	test   %eax,%eax
     95d:	74 76                	je     9d5 <parseblock+0x9d>
    panic("parseblock");
  gettoken(ps, es, 0, 0);
     95f:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     966:	00 
     967:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     96e:	00 
     96f:	89 74 24 04          	mov    %esi,0x4(%esp)
     973:	89 1c 24             	mov    %ebx,(%esp)
     976:	e8 15 fb ff ff       	call   490 <gettoken>
  cmd = parseline(ps, es);
     97b:	89 74 24 04          	mov    %esi,0x4(%esp)
     97f:	89 1c 24             	mov    %ebx,(%esp)
     982:	e8 f5 fe ff ff       	call   87c <parseline>
     987:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     989:	c7 44 24 08 b0 11 00 	movl   $0x11b0,0x8(%esp)
     990:	00 
     991:	89 74 24 04          	mov    %esi,0x4(%esp)
     995:	89 1c 24             	mov    %ebx,(%esp)
     998:	e8 13 fc ff ff       	call   5b0 <peek>
     99d:	85 c0                	test   %eax,%eax
     99f:	74 40                	je     9e1 <parseblock+0xa9>
    panic("syntax - missing )");
  gettoken(ps, es, 0, 0);
     9a1:	c7 44 24 0c 00 00 00 	movl   $0x0,0xc(%esp)
     9a8:	00 
     9a9:	c7 44 24 08 00 00 00 	movl   $0x0,0x8(%esp)
     9b0:	00 
     9b1:	89 74 24 04          	mov    %esi,0x4(%esp)
     9b5:	89 1c 24             	mov    %ebx,(%esp)
     9b8:	e8 d3 fa ff ff       	call   490 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     9bd:	89 74 24 08          	mov    %esi,0x8(%esp)
     9c1:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     9c5:	89 3c 24             	mov    %edi,(%esp)
     9c8:	e8 4b fc ff ff       	call   618 <parseredirs>
  return cmd;
}
     9cd:	83 c4 1c             	add    $0x1c,%esp
     9d0:	5b                   	pop    %ebx
     9d1:	5e                   	pop    %esi
     9d2:	5f                   	pop    %edi
     9d3:	5d                   	pop    %ebp
     9d4:	c3                   	ret    
parseblock(char **ps, char *es)
{
  struct cmd *cmd;

  if(!peek(ps, es, "("))
    panic("parseblock");
     9d5:	c7 04 24 94 11 00 00 	movl   $0x1194,(%esp)
     9dc:	e8 5b f7 ff ff       	call   13c <panic>
  gettoken(ps, es, 0, 0);
  cmd = parseline(ps, es);
  if(!peek(ps, es, ")"))
    panic("syntax - missing )");
     9e1:	c7 04 24 9f 11 00 00 	movl   $0x119f,(%esp)
     9e8:	e8 4f f7 ff ff       	call   13c <panic>
     9ed:	8d 76 00             	lea    0x0(%esi),%esi

000009f0 <nulterminate>:
}

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9f0:	55                   	push   %ebp
     9f1:	89 e5                	mov    %esp,%ebp
     9f3:	53                   	push   %ebx
     9f4:	83 ec 14             	sub    $0x14,%esp
     9f7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9fa:	85 db                	test   %ebx,%ebx
     9fc:	0f 84 82 00 00 00    	je     a84 <nulterminate+0x94>
    return 0;

  switch(cmd->type){
     a02:	83 3b 05             	cmpl   $0x5,(%ebx)
     a05:	77 45                	ja     a4c <nulterminate+0x5c>
     a07:	8b 03                	mov    (%ebx),%eax
     a09:	ff 24 85 f0 11 00 00 	jmp    *0x11f0(,%eax,4)
    nulterminate(pcmd->right);
    break;

  case LIST:
    lcmd = (struct listcmd*)cmd;
    nulterminate(lcmd->left);
     a10:	8b 43 04             	mov    0x4(%ebx),%eax
     a13:	89 04 24             	mov    %eax,(%esp)
     a16:	e8 d5 ff ff ff       	call   9f0 <nulterminate>
    nulterminate(lcmd->right);
     a1b:	8b 43 08             	mov    0x8(%ebx),%eax
     a1e:	89 04 24             	mov    %eax,(%esp)
     a21:	e8 ca ff ff ff       	call   9f0 <nulterminate>
    break;
     a26:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a28:	83 c4 14             	add    $0x14,%esp
     a2b:	5b                   	pop    %ebx
     a2c:	5d                   	pop    %ebp
     a2d:	c3                   	ret    
     a2e:	66 90                	xchg   %ax,%ax
     a30:	89 d8                	mov    %ebx,%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a32:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a35:	85 c9                	test   %ecx,%ecx
     a37:	74 13                	je     a4c <nulterminate+0x5c>
     a39:	8d 76 00             	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a3c:	8b 50 2c             	mov    0x2c(%eax),%edx
     a3f:	c6 02 00             	movb   $0x0,(%edx)
     a42:	83 c0 04             	add    $0x4,%eax
    return 0;

  switch(cmd->type){
  case EXEC:
    ecmd = (struct execcmd*)cmd;
    for(i=0; ecmd->argv[i]; i++)
     a45:	8b 50 04             	mov    0x4(%eax),%edx
     a48:	85 d2                	test   %edx,%edx
     a4a:	75 f0                	jne    a3c <nulterminate+0x4c>
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;

  switch(cmd->type){
     a4c:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a4e:	83 c4 14             	add    $0x14,%esp
     a51:	5b                   	pop    %ebx
     a52:	5d                   	pop    %ebp
     a53:	c3                   	ret    
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     a54:	8b 43 04             	mov    0x4(%ebx),%eax
     a57:	89 04 24             	mov    %eax,(%esp)
     a5a:	e8 91 ff ff ff       	call   9f0 <nulterminate>
    break;
     a5f:	89 d8                	mov    %ebx,%eax
  }
  return cmd;
}
     a61:	83 c4 14             	add    $0x14,%esp
     a64:	5b                   	pop    %ebx
     a65:	5d                   	pop    %ebp
     a66:	c3                   	ret    
     a67:	90                   	nop
      *ecmd->eargv[i] = 0;
    break;

  case REDIR:
    rcmd = (struct redircmd*)cmd;
    nulterminate(rcmd->cmd);
     a68:	8b 43 04             	mov    0x4(%ebx),%eax
     a6b:	89 04 24             	mov    %eax,(%esp)
     a6e:	e8 7d ff ff ff       	call   9f0 <nulterminate>
    *rcmd->efile = 0;
     a73:	8b 43 0c             	mov    0xc(%ebx),%eax
     a76:	c6 00 00             	movb   $0x0,(%eax)
    break;
     a79:	89 d8                	mov    %ebx,%eax
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
    break;
  }
  return cmd;
}
     a7b:	83 c4 14             	add    $0x14,%esp
     a7e:	5b                   	pop    %ebx
     a7f:	5d                   	pop    %ebp
     a80:	c3                   	ret    
     a81:	8d 76 00             	lea    0x0(%esi),%esi
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
    return 0;
     a84:	31 c0                	xor    %eax,%eax
     a86:	eb a0                	jmp    a28 <nulterminate+0x38>

00000a88 <parsecmd>:
struct cmd *parseexec(char**, char*);
struct cmd *nulterminate(struct cmd*);

struct cmd*
parsecmd(char *s)
{
     a88:	55                   	push   %ebp
     a89:	89 e5                	mov    %esp,%ebp
     a8b:	56                   	push   %esi
     a8c:	53                   	push   %ebx
     a8d:	83 ec 10             	sub    $0x10,%esp
  char *es;
  struct cmd *cmd;

  es = s + strlen(s);
     a90:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a93:	89 1c 24             	mov    %ebx,(%esp)
     a96:	e8 c9 00 00 00       	call   b64 <strlen>
     a9b:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a9d:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     aa1:	8d 45 08             	lea    0x8(%ebp),%eax
     aa4:	89 04 24             	mov    %eax,(%esp)
     aa7:	e8 d0 fd ff ff       	call   87c <parseline>
     aac:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     aae:	c7 44 24 08 3e 11 00 	movl   $0x113e,0x8(%esp)
     ab5:	00 
     ab6:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     aba:	8d 45 08             	lea    0x8(%ebp),%eax
     abd:	89 04 24             	mov    %eax,(%esp)
     ac0:	e8 eb fa ff ff       	call   5b0 <peek>
  if(s != es){
     ac5:	8b 45 08             	mov    0x8(%ebp),%eax
     ac8:	39 d8                	cmp    %ebx,%eax
     aca:	75 11                	jne    add <parsecmd+0x55>
    printf(2, "leftovers: %s\n", s);
    panic("syntax");
  }
  nulterminate(cmd);
     acc:	89 34 24             	mov    %esi,(%esp)
     acf:	e8 1c ff ff ff       	call   9f0 <nulterminate>
  return cmd;
}
     ad4:	89 f0                	mov    %esi,%eax
     ad6:	83 c4 10             	add    $0x10,%esp
     ad9:	5b                   	pop    %ebx
     ada:	5e                   	pop    %esi
     adb:	5d                   	pop    %ebp
     adc:	c3                   	ret    

  es = s + strlen(s);
  cmd = parseline(&s, es);
  peek(&s, es, "");
  if(s != es){
    printf(2, "leftovers: %s\n", s);
     add:	89 44 24 08          	mov    %eax,0x8(%esp)
     ae1:	c7 44 24 04 b2 11 00 	movl   $0x11b2,0x4(%esp)
     ae8:	00 
     ae9:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
     af0:	e8 03 03 00 00       	call   df8 <printf>
    panic("syntax");
     af5:	c7 04 24 76 11 00 00 	movl   $0x1176,(%esp)
     afc:	e8 3b f6 ff ff       	call   13c <panic>
     b01:	66 90                	xchg   %ax,%ax
     b03:	90                   	nop

00000b04 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
     b04:	55                   	push   %ebp
     b05:	89 e5                	mov    %esp,%ebp
     b07:	53                   	push   %ebx
     b08:	8b 45 08             	mov    0x8(%ebp),%eax
     b0b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     b0e:	89 c2                	mov    %eax,%edx
     b10:	42                   	inc    %edx
     b11:	41                   	inc    %ecx
     b12:	8a 59 ff             	mov    -0x1(%ecx),%bl
     b15:	88 5a ff             	mov    %bl,-0x1(%edx)
     b18:	84 db                	test   %bl,%bl
     b1a:	75 f4                	jne    b10 <strcpy+0xc>
    ;
  return os;
}
     b1c:	5b                   	pop    %ebx
     b1d:	5d                   	pop    %ebp
     b1e:	c3                   	ret    
     b1f:	90                   	nop

00000b20 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     b20:	55                   	push   %ebp
     b21:	89 e5                	mov    %esp,%ebp
     b23:	53                   	push   %ebx
     b24:	8b 55 08             	mov    0x8(%ebp),%edx
     b27:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     b2a:	0f b6 02             	movzbl (%edx),%eax
     b2d:	84 c0                	test   %al,%al
     b2f:	74 27                	je     b58 <strcmp+0x38>
     b31:	8a 19                	mov    (%ecx),%bl
     b33:	38 d8                	cmp    %bl,%al
     b35:	74 0b                	je     b42 <strcmp+0x22>
     b37:	eb 26                	jmp    b5f <strcmp+0x3f>
     b39:	8d 76 00             	lea    0x0(%esi),%esi
     b3c:	38 c8                	cmp    %cl,%al
     b3e:	75 13                	jne    b53 <strcmp+0x33>
    p++, q++;
     b40:	89 d9                	mov    %ebx,%ecx
     b42:	42                   	inc    %edx
     b43:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b46:	0f b6 02             	movzbl (%edx),%eax
     b49:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
     b4d:	84 c0                	test   %al,%al
     b4f:	75 eb                	jne    b3c <strcmp+0x1c>
     b51:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
     b53:	29 c8                	sub    %ecx,%eax
}
     b55:	5b                   	pop    %ebx
     b56:	5d                   	pop    %ebp
     b57:	c3                   	ret    
     b58:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
     b5b:	31 c0                	xor    %eax,%eax
     b5d:	eb f4                	jmp    b53 <strcmp+0x33>
     b5f:	0f b6 cb             	movzbl %bl,%ecx
     b62:	eb ef                	jmp    b53 <strcmp+0x33>

00000b64 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
     b64:	55                   	push   %ebp
     b65:	89 e5                	mov    %esp,%ebp
     b67:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b6a:	80 39 00             	cmpb   $0x0,(%ecx)
     b6d:	74 10                	je     b7f <strlen+0x1b>
     b6f:	31 d2                	xor    %edx,%edx
     b71:	8d 76 00             	lea    0x0(%esi),%esi
     b74:	42                   	inc    %edx
     b75:	89 d0                	mov    %edx,%eax
     b77:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b7b:	75 f7                	jne    b74 <strlen+0x10>
    ;
  return n;
}
     b7d:	5d                   	pop    %ebp
     b7e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
     b7f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
     b81:	5d                   	pop    %ebp
     b82:	c3                   	ret    
     b83:	90                   	nop

00000b84 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b84:	55                   	push   %ebp
     b85:	89 e5                	mov    %esp,%ebp
     b87:	57                   	push   %edi
     b88:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b8b:	89 d7                	mov    %edx,%edi
     b8d:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b90:	8b 45 0c             	mov    0xc(%ebp),%eax
     b93:	fc                   	cld    
     b94:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b96:	89 d0                	mov    %edx,%eax
     b98:	5f                   	pop    %edi
     b99:	5d                   	pop    %ebp
     b9a:	c3                   	ret    
     b9b:	90                   	nop

00000b9c <strchr>:

char*
strchr(const char *s, char c)
{
     b9c:	55                   	push   %ebp
     b9d:	89 e5                	mov    %esp,%ebp
     b9f:	53                   	push   %ebx
     ba0:	8b 45 08             	mov    0x8(%ebp),%eax
     ba3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     ba6:	8a 10                	mov    (%eax),%dl
     ba8:	84 d2                	test   %dl,%dl
     baa:	74 13                	je     bbf <strchr+0x23>
     bac:	88 d9                	mov    %bl,%cl
    if(*s == c)
     bae:	38 da                	cmp    %bl,%dl
     bb0:	75 06                	jne    bb8 <strchr+0x1c>
     bb2:	eb 0d                	jmp    bc1 <strchr+0x25>
     bb4:	38 ca                	cmp    %cl,%dl
     bb6:	74 09                	je     bc1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
     bb8:	40                   	inc    %eax
     bb9:	8a 10                	mov    (%eax),%dl
     bbb:	84 d2                	test   %dl,%dl
     bbd:	75 f5                	jne    bb4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
     bbf:	31 c0                	xor    %eax,%eax
}
     bc1:	5b                   	pop    %ebx
     bc2:	5d                   	pop    %ebp
     bc3:	c3                   	ret    

00000bc4 <gets>:

char*
gets(char *buf, int max)
{
     bc4:	55                   	push   %ebp
     bc5:	89 e5                	mov    %esp,%ebp
     bc7:	57                   	push   %edi
     bc8:	56                   	push   %esi
     bc9:	53                   	push   %ebx
     bca:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bcd:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
     bcf:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bd2:	eb 30                	jmp    c04 <gets+0x40>
    cc = read(0, &c, 1);
     bd4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     bdb:	00 
     bdc:	89 7c 24 04          	mov    %edi,0x4(%esp)
     be0:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     be7:	e8 f0 00 00 00       	call   cdc <read>
    if(cc < 1)
     bec:	85 c0                	test   %eax,%eax
     bee:	7e 1c                	jle    c0c <gets+0x48>
      break;
    buf[i++] = c;
     bf0:	8a 45 e7             	mov    -0x19(%ebp),%al
     bf3:	8b 55 08             	mov    0x8(%ebp),%edx
     bf6:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bfa:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
     bfc:	3c 0a                	cmp    $0xa,%al
     bfe:	74 0c                	je     c0c <gets+0x48>
     c00:	3c 0d                	cmp    $0xd,%al
     c02:	74 08                	je     c0c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     c04:	8d 5e 01             	lea    0x1(%esi),%ebx
     c07:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c0a:	7c c8                	jl     bd4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
     c0c:	8b 45 08             	mov    0x8(%ebp),%eax
     c0f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
     c13:	83 c4 2c             	add    $0x2c,%esp
     c16:	5b                   	pop    %ebx
     c17:	5e                   	pop    %esi
     c18:	5f                   	pop    %edi
     c19:	5d                   	pop    %ebp
     c1a:	c3                   	ret    
     c1b:	90                   	nop

00000c1c <stat>:

int
stat(char *n, struct stat *st)
{
     c1c:	55                   	push   %ebp
     c1d:	89 e5                	mov    %esp,%ebp
     c1f:	56                   	push   %esi
     c20:	53                   	push   %ebx
     c21:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c24:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
     c2b:	00 
     c2c:	8b 45 08             	mov    0x8(%ebp),%eax
     c2f:	89 04 24             	mov    %eax,(%esp)
     c32:	e8 cd 00 00 00       	call   d04 <open>
     c37:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
     c39:	85 c0                	test   %eax,%eax
     c3b:	78 23                	js     c60 <stat+0x44>
    return -1;
  r = fstat(fd, st);
     c3d:	8b 45 0c             	mov    0xc(%ebp),%eax
     c40:	89 44 24 04          	mov    %eax,0x4(%esp)
     c44:	89 1c 24             	mov    %ebx,(%esp)
     c47:	e8 d0 00 00 00       	call   d1c <fstat>
     c4c:	89 c6                	mov    %eax,%esi
  close(fd);
     c4e:	89 1c 24             	mov    %ebx,(%esp)
     c51:	e8 96 00 00 00       	call   cec <close>
  return r;
     c56:	89 f0                	mov    %esi,%eax
}
     c58:	83 c4 10             	add    $0x10,%esp
     c5b:	5b                   	pop    %ebx
     c5c:	5e                   	pop    %esi
     c5d:	5d                   	pop    %ebp
     c5e:	c3                   	ret    
     c5f:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
     c60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
     c65:	eb f1                	jmp    c58 <stat+0x3c>
     c67:	90                   	nop

00000c68 <atoi>:
  return r;
}

int
atoi(const char *s)
{
     c68:	55                   	push   %ebp
     c69:	89 e5                	mov    %esp,%ebp
     c6b:	53                   	push   %ebx
     c6c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c6f:	0f be 11             	movsbl (%ecx),%edx
     c72:	8d 42 d0             	lea    -0x30(%edx),%eax
     c75:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
     c77:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     c7c:	77 15                	ja     c93 <atoi+0x2b>
     c7e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
     c80:	41                   	inc    %ecx
     c81:	8d 04 80             	lea    (%eax,%eax,4),%eax
     c84:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     c88:	0f be 11             	movsbl (%ecx),%edx
     c8b:	8d 5a d0             	lea    -0x30(%edx),%ebx
     c8e:	80 fb 09             	cmp    $0x9,%bl
     c91:	76 ed                	jbe    c80 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
     c93:	5b                   	pop    %ebx
     c94:	5d                   	pop    %ebp
     c95:	c3                   	ret    
     c96:	66 90                	xchg   %ax,%ax

00000c98 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
     c98:	55                   	push   %ebp
     c99:	89 e5                	mov    %esp,%ebp
     c9b:	56                   	push   %esi
     c9c:	53                   	push   %ebx
     c9d:	8b 45 08             	mov    0x8(%ebp),%eax
     ca0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     ca3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     ca6:	31 d2                	xor    %edx,%edx
     ca8:	85 f6                	test   %esi,%esi
     caa:	7e 0b                	jle    cb7 <memmove+0x1f>
    *dst++ = *src++;
     cac:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
     caf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cb2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cb3:	39 f2                	cmp    %esi,%edx
     cb5:	75 f5                	jne    cac <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
     cb7:	5b                   	pop    %ebx
     cb8:	5e                   	pop    %esi
     cb9:	5d                   	pop    %ebp
     cba:	c3                   	ret    
     cbb:	90                   	nop

00000cbc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
     cbc:	b8 01 00 00 00       	mov    $0x1,%eax
     cc1:	cd 40                	int    $0x40
     cc3:	c3                   	ret    

00000cc4 <exit>:
SYSCALL(exit)
     cc4:	b8 02 00 00 00       	mov    $0x2,%eax
     cc9:	cd 40                	int    $0x40
     ccb:	c3                   	ret    

00000ccc <wait>:
SYSCALL(wait)
     ccc:	b8 03 00 00 00       	mov    $0x3,%eax
     cd1:	cd 40                	int    $0x40
     cd3:	c3                   	ret    

00000cd4 <pipe>:
SYSCALL(pipe)
     cd4:	b8 04 00 00 00       	mov    $0x4,%eax
     cd9:	cd 40                	int    $0x40
     cdb:	c3                   	ret    

00000cdc <read>:
SYSCALL(read)
     cdc:	b8 05 00 00 00       	mov    $0x5,%eax
     ce1:	cd 40                	int    $0x40
     ce3:	c3                   	ret    

00000ce4 <write>:
SYSCALL(write)
     ce4:	b8 10 00 00 00       	mov    $0x10,%eax
     ce9:	cd 40                	int    $0x40
     ceb:	c3                   	ret    

00000cec <close>:
SYSCALL(close)
     cec:	b8 15 00 00 00       	mov    $0x15,%eax
     cf1:	cd 40                	int    $0x40
     cf3:	c3                   	ret    

00000cf4 <kill>:
SYSCALL(kill)
     cf4:	b8 06 00 00 00       	mov    $0x6,%eax
     cf9:	cd 40                	int    $0x40
     cfb:	c3                   	ret    

00000cfc <exec>:
SYSCALL(exec)
     cfc:	b8 07 00 00 00       	mov    $0x7,%eax
     d01:	cd 40                	int    $0x40
     d03:	c3                   	ret    

00000d04 <open>:
SYSCALL(open)
     d04:	b8 0f 00 00 00       	mov    $0xf,%eax
     d09:	cd 40                	int    $0x40
     d0b:	c3                   	ret    

00000d0c <mknod>:
SYSCALL(mknod)
     d0c:	b8 11 00 00 00       	mov    $0x11,%eax
     d11:	cd 40                	int    $0x40
     d13:	c3                   	ret    

00000d14 <unlink>:
SYSCALL(unlink)
     d14:	b8 12 00 00 00       	mov    $0x12,%eax
     d19:	cd 40                	int    $0x40
     d1b:	c3                   	ret    

00000d1c <fstat>:
SYSCALL(fstat)
     d1c:	b8 08 00 00 00       	mov    $0x8,%eax
     d21:	cd 40                	int    $0x40
     d23:	c3                   	ret    

00000d24 <link>:
SYSCALL(link)
     d24:	b8 13 00 00 00       	mov    $0x13,%eax
     d29:	cd 40                	int    $0x40
     d2b:	c3                   	ret    

00000d2c <mkdir>:
SYSCALL(mkdir)
     d2c:	b8 14 00 00 00       	mov    $0x14,%eax
     d31:	cd 40                	int    $0x40
     d33:	c3                   	ret    

00000d34 <chdir>:
SYSCALL(chdir)
     d34:	b8 09 00 00 00       	mov    $0x9,%eax
     d39:	cd 40                	int    $0x40
     d3b:	c3                   	ret    

00000d3c <dup>:
SYSCALL(dup)
     d3c:	b8 0a 00 00 00       	mov    $0xa,%eax
     d41:	cd 40                	int    $0x40
     d43:	c3                   	ret    

00000d44 <getpid>:
SYSCALL(getpid)
     d44:	b8 0b 00 00 00       	mov    $0xb,%eax
     d49:	cd 40                	int    $0x40
     d4b:	c3                   	ret    

00000d4c <sbrk>:
SYSCALL(sbrk)
     d4c:	b8 0c 00 00 00       	mov    $0xc,%eax
     d51:	cd 40                	int    $0x40
     d53:	c3                   	ret    

00000d54 <sleep>:
SYSCALL(sleep)
     d54:	b8 0d 00 00 00       	mov    $0xd,%eax
     d59:	cd 40                	int    $0x40
     d5b:	c3                   	ret    

00000d5c <uptime>:
SYSCALL(uptime)
     d5c:	b8 0e 00 00 00       	mov    $0xe,%eax
     d61:	cd 40                	int    $0x40
     d63:	c3                   	ret    

00000d64 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
     d64:	55                   	push   %ebp
     d65:	89 e5                	mov    %esp,%ebp
     d67:	57                   	push   %edi
     d68:	56                   	push   %esi
     d69:	53                   	push   %ebx
     d6a:	83 ec 4c             	sub    $0x4c,%esp
     d6d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     d6f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
     d71:	8b 5d 08             	mov    0x8(%ebp),%ebx
     d74:	85 db                	test   %ebx,%ebx
     d76:	74 04                	je     d7c <printint+0x18>
     d78:	85 d2                	test   %edx,%edx
     d7a:	78 70                	js     dec <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     d7c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
     d83:	31 ff                	xor    %edi,%edi
     d85:	8d 5d d7             	lea    -0x29(%ebp),%ebx
     d88:	89 75 c0             	mov    %esi,-0x40(%ebp)
     d8b:	89 ce                	mov    %ecx,%esi
     d8d:	eb 03                	jmp    d92 <printint+0x2e>
     d8f:	90                   	nop
  do{
    buf[i++] = digits[x % base];
     d90:	89 cf                	mov    %ecx,%edi
     d92:	8d 4f 01             	lea    0x1(%edi),%ecx
     d95:	31 d2                	xor    %edx,%edx
     d97:	f7 f6                	div    %esi
     d99:	8a 92 0f 12 00 00    	mov    0x120f(%edx),%dl
     d9f:	88 55 c7             	mov    %dl,-0x39(%ebp)
     da2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
     da5:	85 c0                	test   %eax,%eax
     da7:	75 e7                	jne    d90 <printint+0x2c>
     da9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
     dac:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
     dae:	8b 55 bc             	mov    -0x44(%ebp),%edx
     db1:	85 d2                	test   %edx,%edx
     db3:	74 08                	je     dbd <printint+0x59>
    buf[i++] = '-';
     db5:	8d 4f 02             	lea    0x2(%edi),%ecx
     db8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
     dbd:	8d 79 ff             	lea    -0x1(%ecx),%edi
     dc0:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
     dc4:	88 45 c7             	mov    %al,-0x39(%ebp)
     dc7:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     dca:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     dd1:	00 
     dd2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
     dd6:	89 34 24             	mov    %esi,(%esp)
     dd9:	e8 06 ff ff ff       	call   ce4 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
     dde:	4f                   	dec    %edi
     ddf:	83 ff ff             	cmp    $0xffffffff,%edi
     de2:	75 dc                	jne    dc0 <printint+0x5c>
    putc(fd, buf[i]);
}
     de4:	83 c4 4c             	add    $0x4c,%esp
     de7:	5b                   	pop    %ebx
     de8:	5e                   	pop    %esi
     de9:	5f                   	pop    %edi
     dea:	5d                   	pop    %ebp
     deb:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
     dec:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
     dee:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
     df5:	eb 8c                	jmp    d83 <printint+0x1f>
     df7:	90                   	nop

00000df8 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
     df8:	55                   	push   %ebp
     df9:	89 e5                	mov    %esp,%ebp
     dfb:	57                   	push   %edi
     dfc:	56                   	push   %esi
     dfd:	53                   	push   %ebx
     dfe:	83 ec 3c             	sub    $0x3c,%esp
     e01:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e04:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     e07:	0f b6 13             	movzbl (%ebx),%edx
     e0a:	84 d2                	test   %dl,%dl
     e0c:	0f 84 be 00 00 00    	je     ed0 <printf+0xd8>
     e12:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
     e13:	8d 45 10             	lea    0x10(%ebp),%eax
     e16:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
     e19:	31 ff                	xor    %edi,%edi
     e1b:	eb 33                	jmp    e50 <printf+0x58>
     e1d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
     e20:	83 fa 25             	cmp    $0x25,%edx
     e23:	0f 84 af 00 00 00    	je     ed8 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
     e29:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e2c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e33:	00 
     e34:	8d 45 e2             	lea    -0x1e(%ebp),%eax
     e37:	89 44 24 04          	mov    %eax,0x4(%esp)
     e3b:	89 34 24             	mov    %esi,(%esp)
     e3e:	e8 a1 fe ff ff       	call   ce4 <write>
     e43:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     e44:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     e48:	84 d2                	test   %dl,%dl
     e4a:	0f 84 80 00 00 00    	je     ed0 <printf+0xd8>
    c = fmt[i] & 0xff;
     e50:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
     e53:	85 ff                	test   %edi,%edi
     e55:	74 c9                	je     e20 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
     e57:	83 ff 25             	cmp    $0x25,%edi
     e5a:	75 e7                	jne    e43 <printf+0x4b>
      if(c == 'd'){
     e5c:	83 fa 64             	cmp    $0x64,%edx
     e5f:	0f 84 0f 01 00 00    	je     f74 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
     e65:	25 f7 00 00 00       	and    $0xf7,%eax
     e6a:	83 f8 70             	cmp    $0x70,%eax
     e6d:	74 75                	je     ee4 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
     e6f:	83 fa 73             	cmp    $0x73,%edx
     e72:	0f 84 90 00 00 00    	je     f08 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
     e78:	83 fa 63             	cmp    $0x63,%edx
     e7b:	0f 84 c7 00 00 00    	je     f48 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
     e81:	83 fa 25             	cmp    $0x25,%edx
     e84:	0f 84 0e 01 00 00    	je     f98 <printf+0x1a0>
     e8a:	89 55 d0             	mov    %edx,-0x30(%ebp)
     e8d:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     e91:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     e98:	00 
     e99:	8d 45 e6             	lea    -0x1a(%ebp),%eax
     e9c:	89 44 24 04          	mov    %eax,0x4(%esp)
     ea0:	89 34 24             	mov    %esi,(%esp)
     ea3:	e8 3c fe ff ff       	call   ce4 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
     ea8:	8b 55 d0             	mov    -0x30(%ebp),%edx
     eab:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     eae:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     eb5:	00 
     eb6:	8d 45 e7             	lea    -0x19(%ebp),%eax
     eb9:	89 44 24 04          	mov    %eax,0x4(%esp)
     ebd:	89 34 24             	mov    %esi,(%esp)
     ec0:	e8 1f fe ff ff       	call   ce4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     ec5:	31 ff                	xor    %edi,%edi
     ec7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
     ec8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
     ecc:	84 d2                	test   %dl,%dl
     ece:	75 80                	jne    e50 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
     ed0:	83 c4 3c             	add    $0x3c,%esp
     ed3:	5b                   	pop    %ebx
     ed4:	5e                   	pop    %esi
     ed5:	5f                   	pop    %edi
     ed6:	5d                   	pop    %ebp
     ed7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
     ed8:	bf 25 00 00 00       	mov    $0x25,%edi
     edd:	e9 61 ff ff ff       	jmp    e43 <printf+0x4b>
     ee2:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
     ee4:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
     eeb:	b9 10 00 00 00       	mov    $0x10,%ecx
     ef0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     ef3:	8b 10                	mov    (%eax),%edx
     ef5:	89 f0                	mov    %esi,%eax
     ef7:	e8 68 fe ff ff       	call   d64 <printint>
        ap++;
     efc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f00:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
     f02:	e9 3c ff ff ff       	jmp    e43 <printf+0x4b>
     f07:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
     f08:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f0b:	8b 38                	mov    (%eax),%edi
        ap++;
     f0d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
     f11:	85 ff                	test   %edi,%edi
     f13:	0f 84 a1 00 00 00    	je     fba <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
     f19:	8a 07                	mov    (%edi),%al
     f1b:	84 c0                	test   %al,%al
     f1d:	74 22                	je     f41 <printf+0x149>
     f1f:	90                   	nop
     f20:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f23:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f2a:	00 
     f2b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
     f2e:	89 44 24 04          	mov    %eax,0x4(%esp)
     f32:	89 34 24             	mov    %esi,(%esp)
     f35:	e8 aa fd ff ff       	call   ce4 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
     f3a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
     f3b:	8a 07                	mov    (%edi),%al
     f3d:	84 c0                	test   %al,%al
     f3f:	75 df                	jne    f20 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f41:	31 ff                	xor    %edi,%edi
     f43:	e9 fb fe ff ff       	jmp    e43 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
     f48:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f4b:	8b 00                	mov    (%eax),%eax
     f4d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f50:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     f57:	00 
     f58:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     f5b:	89 44 24 04          	mov    %eax,0x4(%esp)
     f5f:	89 34 24             	mov    %esi,(%esp)
     f62:	e8 7d fd ff ff       	call   ce4 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
     f67:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f6b:	31 ff                	xor    %edi,%edi
     f6d:	e9 d1 fe ff ff       	jmp    e43 <printf+0x4b>
     f72:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
     f74:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
     f7b:	b9 0a 00 00 00       	mov    $0xa,%ecx
     f80:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     f83:	8b 10                	mov    (%eax),%edx
     f85:	89 f0                	mov    %esi,%eax
     f87:	e8 d8 fd ff ff       	call   d64 <printint>
        ap++;
     f8c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     f90:	66 31 ff             	xor    %di,%di
     f93:	e9 ab fe ff ff       	jmp    e43 <printf+0x4b>
     f98:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
     f9c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
     fa3:	00 
     fa4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
     fa7:	89 44 24 04          	mov    %eax,0x4(%esp)
     fab:	89 34 24             	mov    %esi,(%esp)
     fae:	e8 31 fd ff ff       	call   ce4 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
     fb3:	31 ff                	xor    %edi,%edi
     fb5:	e9 89 fe ff ff       	jmp    e43 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
     fba:	bf 08 12 00 00       	mov    $0x1208,%edi
     fbf:	e9 55 ff ff ff       	jmp    f19 <printf+0x121>

00000fc4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     fc4:	55                   	push   %ebp
     fc5:	89 e5                	mov    %esp,%ebp
     fc7:	57                   	push   %edi
     fc8:	56                   	push   %esi
     fc9:	53                   	push   %ebx
     fca:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
     fcd:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd0:	a1 24 18 00 00       	mov    0x1824,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fd5:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fd7:	39 d0                	cmp    %edx,%eax
     fd9:	72 11                	jb     fec <free+0x28>
     fdb:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     fdc:	39 c8                	cmp    %ecx,%eax
     fde:	72 04                	jb     fe4 <free+0x20>
     fe0:	39 ca                	cmp    %ecx,%edx
     fe2:	72 10                	jb     ff4 <free+0x30>
     fe4:	89 c8                	mov    %ecx,%eax
     fe6:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     fe8:	39 d0                	cmp    %edx,%eax
     fea:	73 f0                	jae    fdc <free+0x18>
     fec:	39 ca                	cmp    %ecx,%edx
     fee:	72 04                	jb     ff4 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     ff0:	39 c8                	cmp    %ecx,%eax
     ff2:	72 f0                	jb     fe4 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ff4:	8b 73 fc             	mov    -0x4(%ebx),%esi
     ff7:	8d 3c f2             	lea    (%edx,%esi,8),%edi
     ffa:	39 cf                	cmp    %ecx,%edi
     ffc:	74 1a                	je     1018 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
     ffe:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1001:	8b 48 04             	mov    0x4(%eax),%ecx
    1004:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    1007:	39 f2                	cmp    %esi,%edx
    1009:	74 24                	je     102f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    100b:	89 10                	mov    %edx,(%eax)
  freep = p;
    100d:	a3 24 18 00 00       	mov    %eax,0x1824
}
    1012:	5b                   	pop    %ebx
    1013:	5e                   	pop    %esi
    1014:	5f                   	pop    %edi
    1015:	5d                   	pop    %ebp
    1016:	c3                   	ret    
    1017:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    1018:	03 71 04             	add    0x4(%ecx),%esi
    101b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    101e:	8b 08                	mov    (%eax),%ecx
    1020:	8b 09                	mov    (%ecx),%ecx
    1022:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    1025:	8b 48 04             	mov    0x4(%eax),%ecx
    1028:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
    102b:	39 f2                	cmp    %esi,%edx
    102d:	75 dc                	jne    100b <free+0x47>
    p->s.size += bp->s.size;
    102f:	03 4b fc             	add    -0x4(%ebx),%ecx
    1032:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    1035:	8b 53 f8             	mov    -0x8(%ebx),%edx
    1038:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
    103a:	a3 24 18 00 00       	mov    %eax,0x1824
}
    103f:	5b                   	pop    %ebx
    1040:	5e                   	pop    %esi
    1041:	5f                   	pop    %edi
    1042:	5d                   	pop    %ebp
    1043:	c3                   	ret    

00001044 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    1044:	55                   	push   %ebp
    1045:	89 e5                	mov    %esp,%ebp
    1047:	57                   	push   %edi
    1048:	56                   	push   %esi
    1049:	53                   	push   %ebx
    104a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    104d:	8b 45 08             	mov    0x8(%ebp),%eax
    1050:	8d 70 07             	lea    0x7(%eax),%esi
    1053:	c1 ee 03             	shr    $0x3,%esi
    1056:	46                   	inc    %esi
  if((prevp = freep) == 0){
    1057:	8b 1d 24 18 00 00    	mov    0x1824,%ebx
    105d:	85 db                	test   %ebx,%ebx
    105f:	0f 84 91 00 00 00    	je     10f6 <malloc+0xb2>
    1065:	8b 13                	mov    (%ebx),%edx
    1067:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    106a:	39 ce                	cmp    %ecx,%esi
    106c:	76 52                	jbe    10c0 <malloc+0x7c>
    106e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
    1075:	eb 0c                	jmp    1083 <malloc+0x3f>
    1077:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1078:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    107a:	8b 48 04             	mov    0x4(%eax),%ecx
    107d:	39 ce                	cmp    %ecx,%esi
    107f:	76 43                	jbe    10c4 <malloc+0x80>
    1081:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1083:	3b 15 24 18 00 00    	cmp    0x1824,%edx
    1089:	75 ed                	jne    1078 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    108b:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
    1091:	76 51                	jbe    10e4 <malloc+0xa0>
    1093:	89 d8                	mov    %ebx,%eax
    1095:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
    1097:	89 04 24             	mov    %eax,(%esp)
    109a:	e8 ad fc ff ff       	call   d4c <sbrk>
  if(p == (char*)-1)
    109f:	83 f8 ff             	cmp    $0xffffffff,%eax
    10a2:	74 18                	je     10bc <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
    10a4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
    10a7:	83 c0 08             	add    $0x8,%eax
    10aa:	89 04 24             	mov    %eax,(%esp)
    10ad:	e8 12 ff ff ff       	call   fc4 <free>
  return freep;
    10b2:	8b 15 24 18 00 00    	mov    0x1824,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
    10b8:	85 d2                	test   %edx,%edx
    10ba:	75 bc                	jne    1078 <malloc+0x34>
        return 0;
    10bc:	31 c0                	xor    %eax,%eax
    10be:	eb 1c                	jmp    10dc <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    10c0:	89 d0                	mov    %edx,%eax
    10c2:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
    10c4:	39 ce                	cmp    %ecx,%esi
    10c6:	74 28                	je     10f0 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
    10c8:	29 f1                	sub    %esi,%ecx
    10ca:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    10cd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    10d0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
    10d3:	89 15 24 18 00 00    	mov    %edx,0x1824
      return (void*)(p + 1);
    10d9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    10dc:	83 c4 1c             	add    $0x1c,%esp
    10df:	5b                   	pop    %ebx
    10e0:	5e                   	pop    %esi
    10e1:	5f                   	pop    %edi
    10e2:	5d                   	pop    %ebp
    10e3:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
    10e4:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
    10e9:	bf 00 10 00 00       	mov    $0x1000,%edi
    10ee:	eb a7                	jmp    1097 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
    10f0:	8b 08                	mov    (%eax),%ecx
    10f2:	89 0a                	mov    %ecx,(%edx)
    10f4:	eb dd                	jmp    10d3 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    10f6:	c7 05 24 18 00 00 28 	movl   $0x1828,0x1824
    10fd:	18 00 00 
    1100:	c7 05 28 18 00 00 28 	movl   $0x1828,0x1828
    1107:	18 00 00 
    base.s.size = 0;
    110a:	c7 05 2c 18 00 00 00 	movl   $0x0,0x182c
    1111:	00 00 00 
    1114:	ba 28 18 00 00       	mov    $0x1828,%edx
    1119:	e9 50 ff ff ff       	jmp    106e <malloc+0x2a>
