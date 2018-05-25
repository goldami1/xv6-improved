
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	56                   	push   %esi
   5:	53                   	push   %ebx
   6:	83 e4 f0             	and    $0xfffffff0,%esp
   9:	83 ec 10             	sub    $0x10,%esp
   c:	8b 75 08             	mov    0x8(%ebp),%esi
   f:	8b 7d 0c             	mov    0xc(%ebp),%edi
  int i;

  if(argc < 2){
  12:	83 fe 01             	cmp    $0x1,%esi
  15:	7e 22                	jle    39 <main+0x39>
  17:	bb 01 00 00 00       	mov    $0x1,%ebx
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  1c:	8b 04 9f             	mov    (%edi,%ebx,4),%eax
  1f:	89 04 24             	mov    %eax,(%esp)
  22:	e8 91 01 00 00       	call   1b8 <atoi>
  27:	89 04 24             	mov    %eax,(%esp)
  2a:	e8 15 02 00 00       	call   244 <kill>

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
  2f:	43                   	inc    %ebx
  30:	39 f3                	cmp    %esi,%ebx
  32:	75 e8                	jne    1c <main+0x1c>
    kill(atoi(argv[i]));
  exit();
  34:	e8 db 01 00 00       	call   214 <exit>
main(int argc, char **argv)
{
  int i;

  if(argc < 2){
    printf(2, "usage: kill pid...\n");
  39:	c7 44 24 04 6e 06 00 	movl   $0x66e,0x4(%esp)
  40:	00 
  41:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  48:	e8 fb 02 00 00       	call   348 <printf>
    exit();
  4d:	e8 c2 01 00 00       	call   214 <exit>
  52:	66 90                	xchg   %ax,%ax

00000054 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  54:	55                   	push   %ebp
  55:	89 e5                	mov    %esp,%ebp
  57:	53                   	push   %ebx
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  5e:	89 c2                	mov    %eax,%edx
  60:	42                   	inc    %edx
  61:	41                   	inc    %ecx
  62:	8a 59 ff             	mov    -0x1(%ecx),%bl
  65:	88 5a ff             	mov    %bl,-0x1(%edx)
  68:	84 db                	test   %bl,%bl
  6a:	75 f4                	jne    60 <strcpy+0xc>
    ;
  return os;
}
  6c:	5b                   	pop    %ebx
  6d:	5d                   	pop    %ebp
  6e:	c3                   	ret    
  6f:	90                   	nop

00000070 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  70:	55                   	push   %ebp
  71:	89 e5                	mov    %esp,%ebp
  73:	53                   	push   %ebx
  74:	8b 55 08             	mov    0x8(%ebp),%edx
  77:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  7a:	0f b6 02             	movzbl (%edx),%eax
  7d:	84 c0                	test   %al,%al
  7f:	74 27                	je     a8 <strcmp+0x38>
  81:	8a 19                	mov    (%ecx),%bl
  83:	38 d8                	cmp    %bl,%al
  85:	74 0b                	je     92 <strcmp+0x22>
  87:	eb 26                	jmp    af <strcmp+0x3f>
  89:	8d 76 00             	lea    0x0(%esi),%esi
  8c:	38 c8                	cmp    %cl,%al
  8e:	75 13                	jne    a3 <strcmp+0x33>
    p++, q++;
  90:	89 d9                	mov    %ebx,%ecx
  92:	42                   	inc    %edx
  93:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  96:	0f b6 02             	movzbl (%edx),%eax
  99:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  9d:	84 c0                	test   %al,%al
  9f:	75 eb                	jne    8c <strcmp+0x1c>
  a1:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  a3:	29 c8                	sub    %ecx,%eax
}
  a5:	5b                   	pop    %ebx
  a6:	5d                   	pop    %ebp
  a7:	c3                   	ret    
  a8:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ab:	31 c0                	xor    %eax,%eax
  ad:	eb f4                	jmp    a3 <strcmp+0x33>
  af:	0f b6 cb             	movzbl %bl,%ecx
  b2:	eb ef                	jmp    a3 <strcmp+0x33>

000000b4 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  b4:	55                   	push   %ebp
  b5:	89 e5                	mov    %esp,%ebp
  b7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  ba:	80 39 00             	cmpb   $0x0,(%ecx)
  bd:	74 10                	je     cf <strlen+0x1b>
  bf:	31 d2                	xor    %edx,%edx
  c1:	8d 76 00             	lea    0x0(%esi),%esi
  c4:	42                   	inc    %edx
  c5:	89 d0                	mov    %edx,%eax
  c7:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  cb:	75 f7                	jne    c4 <strlen+0x10>
    ;
  return n;
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  cf:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  d1:	5d                   	pop    %ebp
  d2:	c3                   	ret    
  d3:	90                   	nop

000000d4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  d4:	55                   	push   %ebp
  d5:	89 e5                	mov    %esp,%ebp
  d7:	57                   	push   %edi
  d8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  db:	89 d7                	mov    %edx,%edi
  dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  e3:	fc                   	cld    
  e4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  e6:	89 d0                	mov    %edx,%eax
  e8:	5f                   	pop    %edi
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop

000000ec <strchr>:

char*
strchr(const char *s, char c)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	53                   	push   %ebx
  f0:	8b 45 08             	mov    0x8(%ebp),%eax
  f3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  f6:	8a 10                	mov    (%eax),%dl
  f8:	84 d2                	test   %dl,%dl
  fa:	74 13                	je     10f <strchr+0x23>
  fc:	88 d9                	mov    %bl,%cl
    if(*s == c)
  fe:	38 da                	cmp    %bl,%dl
 100:	75 06                	jne    108 <strchr+0x1c>
 102:	eb 0d                	jmp    111 <strchr+0x25>
 104:	38 ca                	cmp    %cl,%dl
 106:	74 09                	je     111 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 108:	40                   	inc    %eax
 109:	8a 10                	mov    (%eax),%dl
 10b:	84 d2                	test   %dl,%dl
 10d:	75 f5                	jne    104 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 10f:	31 c0                	xor    %eax,%eax
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <gets>:

char*
gets(char *buf, int max)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	57                   	push   %edi
 118:	56                   	push   %esi
 119:	53                   	push   %ebx
 11a:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11d:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 11f:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 122:	eb 30                	jmp    154 <gets+0x40>
    cc = read(0, &c, 1);
 124:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 12b:	00 
 12c:	89 7c 24 04          	mov    %edi,0x4(%esp)
 130:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 137:	e8 f0 00 00 00       	call   22c <read>
    if(cc < 1)
 13c:	85 c0                	test   %eax,%eax
 13e:	7e 1c                	jle    15c <gets+0x48>
      break;
    buf[i++] = c;
 140:	8a 45 e7             	mov    -0x19(%ebp),%al
 143:	8b 55 08             	mov    0x8(%ebp),%edx
 146:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 14c:	3c 0a                	cmp    $0xa,%al
 14e:	74 0c                	je     15c <gets+0x48>
 150:	3c 0d                	cmp    $0xd,%al
 152:	74 08                	je     15c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 154:	8d 5e 01             	lea    0x1(%esi),%ebx
 157:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 15a:	7c c8                	jl     124 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 15c:	8b 45 08             	mov    0x8(%ebp),%eax
 15f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 163:	83 c4 2c             	add    $0x2c,%esp
 166:	5b                   	pop    %ebx
 167:	5e                   	pop    %esi
 168:	5f                   	pop    %edi
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
 16b:	90                   	nop

0000016c <stat>:

int
stat(char *n, struct stat *st)
{
 16c:	55                   	push   %ebp
 16d:	89 e5                	mov    %esp,%ebp
 16f:	56                   	push   %esi
 170:	53                   	push   %ebx
 171:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 174:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 17b:	00 
 17c:	8b 45 08             	mov    0x8(%ebp),%eax
 17f:	89 04 24             	mov    %eax,(%esp)
 182:	e8 cd 00 00 00       	call   254 <open>
 187:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 189:	85 c0                	test   %eax,%eax
 18b:	78 23                	js     1b0 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 18d:	8b 45 0c             	mov    0xc(%ebp),%eax
 190:	89 44 24 04          	mov    %eax,0x4(%esp)
 194:	89 1c 24             	mov    %ebx,(%esp)
 197:	e8 d0 00 00 00       	call   26c <fstat>
 19c:	89 c6                	mov    %eax,%esi
  close(fd);
 19e:	89 1c 24             	mov    %ebx,(%esp)
 1a1:	e8 96 00 00 00       	call   23c <close>
  return r;
 1a6:	89 f0                	mov    %esi,%eax
}
 1a8:	83 c4 10             	add    $0x10,%esp
 1ab:	5b                   	pop    %ebx
 1ac:	5e                   	pop    %esi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    
 1af:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1b0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1b5:	eb f1                	jmp    1a8 <stat+0x3c>
 1b7:	90                   	nop

000001b8 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	53                   	push   %ebx
 1bc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1bf:	0f be 11             	movsbl (%ecx),%edx
 1c2:	8d 42 d0             	lea    -0x30(%edx),%eax
 1c5:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 1c7:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1cc:	77 15                	ja     1e3 <atoi+0x2b>
 1ce:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1d0:	41                   	inc    %ecx
 1d1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1d4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d8:	0f be 11             	movsbl (%ecx),%edx
 1db:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1de:	80 fb 09             	cmp    $0x9,%bl
 1e1:	76 ed                	jbe    1d0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1e3:	5b                   	pop    %ebx
 1e4:	5d                   	pop    %ebp
 1e5:	c3                   	ret    
 1e6:	66 90                	xchg   %ax,%ax

000001e8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1e8:	55                   	push   %ebp
 1e9:	89 e5                	mov    %esp,%ebp
 1eb:	56                   	push   %esi
 1ec:	53                   	push   %ebx
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
 1f0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1f3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f6:	31 d2                	xor    %edx,%edx
 1f8:	85 f6                	test   %esi,%esi
 1fa:	7e 0b                	jle    207 <memmove+0x1f>
    *dst++ = *src++;
 1fc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1ff:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 202:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 203:	39 f2                	cmp    %esi,%edx
 205:	75 f5                	jne    1fc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 207:	5b                   	pop    %ebx
 208:	5e                   	pop    %esi
 209:	5d                   	pop    %ebp
 20a:	c3                   	ret    
 20b:	90                   	nop

0000020c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 20c:	b8 01 00 00 00       	mov    $0x1,%eax
 211:	cd 40                	int    $0x40
 213:	c3                   	ret    

00000214 <exit>:
SYSCALL(exit)
 214:	b8 02 00 00 00       	mov    $0x2,%eax
 219:	cd 40                	int    $0x40
 21b:	c3                   	ret    

0000021c <wait>:
SYSCALL(wait)
 21c:	b8 03 00 00 00       	mov    $0x3,%eax
 221:	cd 40                	int    $0x40
 223:	c3                   	ret    

00000224 <pipe>:
SYSCALL(pipe)
 224:	b8 04 00 00 00       	mov    $0x4,%eax
 229:	cd 40                	int    $0x40
 22b:	c3                   	ret    

0000022c <read>:
SYSCALL(read)
 22c:	b8 05 00 00 00       	mov    $0x5,%eax
 231:	cd 40                	int    $0x40
 233:	c3                   	ret    

00000234 <write>:
SYSCALL(write)
 234:	b8 10 00 00 00       	mov    $0x10,%eax
 239:	cd 40                	int    $0x40
 23b:	c3                   	ret    

0000023c <close>:
SYSCALL(close)
 23c:	b8 15 00 00 00       	mov    $0x15,%eax
 241:	cd 40                	int    $0x40
 243:	c3                   	ret    

00000244 <kill>:
SYSCALL(kill)
 244:	b8 06 00 00 00       	mov    $0x6,%eax
 249:	cd 40                	int    $0x40
 24b:	c3                   	ret    

0000024c <exec>:
SYSCALL(exec)
 24c:	b8 07 00 00 00       	mov    $0x7,%eax
 251:	cd 40                	int    $0x40
 253:	c3                   	ret    

00000254 <open>:
SYSCALL(open)
 254:	b8 0f 00 00 00       	mov    $0xf,%eax
 259:	cd 40                	int    $0x40
 25b:	c3                   	ret    

0000025c <mknod>:
SYSCALL(mknod)
 25c:	b8 11 00 00 00       	mov    $0x11,%eax
 261:	cd 40                	int    $0x40
 263:	c3                   	ret    

00000264 <unlink>:
SYSCALL(unlink)
 264:	b8 12 00 00 00       	mov    $0x12,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <fstat>:
SYSCALL(fstat)
 26c:	b8 08 00 00 00       	mov    $0x8,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <link>:
SYSCALL(link)
 274:	b8 13 00 00 00       	mov    $0x13,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <mkdir>:
SYSCALL(mkdir)
 27c:	b8 14 00 00 00       	mov    $0x14,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <chdir>:
SYSCALL(chdir)
 284:	b8 09 00 00 00       	mov    $0x9,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <dup>:
SYSCALL(dup)
 28c:	b8 0a 00 00 00       	mov    $0xa,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <getpid>:
SYSCALL(getpid)
 294:	b8 0b 00 00 00       	mov    $0xb,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <sbrk>:
SYSCALL(sbrk)
 29c:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <sleep>:
SYSCALL(sleep)
 2a4:	b8 0d 00 00 00       	mov    $0xd,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <uptime>:
SYSCALL(uptime)
 2ac:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	57                   	push   %edi
 2b8:	56                   	push   %esi
 2b9:	53                   	push   %ebx
 2ba:	83 ec 4c             	sub    $0x4c,%esp
 2bd:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2bf:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c1:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2c4:	85 db                	test   %ebx,%ebx
 2c6:	74 04                	je     2cc <printint+0x18>
 2c8:	85 d2                	test   %edx,%edx
 2ca:	78 70                	js     33c <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2cc:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2d3:	31 ff                	xor    %edi,%edi
 2d5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2d8:	89 75 c0             	mov    %esi,-0x40(%ebp)
 2db:	89 ce                	mov    %ecx,%esi
 2dd:	eb 03                	jmp    2e2 <printint+0x2e>
 2df:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2e0:	89 cf                	mov    %ecx,%edi
 2e2:	8d 4f 01             	lea    0x1(%edi),%ecx
 2e5:	31 d2                	xor    %edx,%edx
 2e7:	f7 f6                	div    %esi
 2e9:	8a 92 89 06 00 00    	mov    0x689(%edx),%dl
 2ef:	88 55 c7             	mov    %dl,-0x39(%ebp)
 2f2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2f5:	85 c0                	test   %eax,%eax
 2f7:	75 e7                	jne    2e0 <printint+0x2c>
 2f9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2fc:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 2fe:	8b 55 bc             	mov    -0x44(%ebp),%edx
 301:	85 d2                	test   %edx,%edx
 303:	74 08                	je     30d <printint+0x59>
    buf[i++] = '-';
 305:	8d 4f 02             	lea    0x2(%edi),%ecx
 308:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 30d:	8d 79 ff             	lea    -0x1(%ecx),%edi
 310:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 314:	88 45 c7             	mov    %al,-0x39(%ebp)
 317:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 31a:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 321:	00 
 322:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 326:	89 34 24             	mov    %esi,(%esp)
 329:	e8 06 ff ff ff       	call   234 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 32e:	4f                   	dec    %edi
 32f:	83 ff ff             	cmp    $0xffffffff,%edi
 332:	75 dc                	jne    310 <printint+0x5c>
    putc(fd, buf[i]);
}
 334:	83 c4 4c             	add    $0x4c,%esp
 337:	5b                   	pop    %ebx
 338:	5e                   	pop    %esi
 339:	5f                   	pop    %edi
 33a:	5d                   	pop    %ebp
 33b:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 33c:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 33e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 345:	eb 8c                	jmp    2d3 <printint+0x1f>
 347:	90                   	nop

00000348 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	57                   	push   %edi
 34c:	56                   	push   %esi
 34d:	53                   	push   %ebx
 34e:	83 ec 3c             	sub    $0x3c,%esp
 351:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 354:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 357:	0f b6 13             	movzbl (%ebx),%edx
 35a:	84 d2                	test   %dl,%dl
 35c:	0f 84 be 00 00 00    	je     420 <printf+0xd8>
 362:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 363:	8d 45 10             	lea    0x10(%ebp),%eax
 366:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 369:	31 ff                	xor    %edi,%edi
 36b:	eb 33                	jmp    3a0 <printf+0x58>
 36d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 370:	83 fa 25             	cmp    $0x25,%edx
 373:	0f 84 af 00 00 00    	je     428 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 379:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 37c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 383:	00 
 384:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 387:	89 44 24 04          	mov    %eax,0x4(%esp)
 38b:	89 34 24             	mov    %esi,(%esp)
 38e:	e8 a1 fe ff ff       	call   234 <write>
 393:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 394:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 398:	84 d2                	test   %dl,%dl
 39a:	0f 84 80 00 00 00    	je     420 <printf+0xd8>
    c = fmt[i] & 0xff;
 3a0:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 3a3:	85 ff                	test   %edi,%edi
 3a5:	74 c9                	je     370 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3a7:	83 ff 25             	cmp    $0x25,%edi
 3aa:	75 e7                	jne    393 <printf+0x4b>
      if(c == 'd'){
 3ac:	83 fa 64             	cmp    $0x64,%edx
 3af:	0f 84 0f 01 00 00    	je     4c4 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3b5:	25 f7 00 00 00       	and    $0xf7,%eax
 3ba:	83 f8 70             	cmp    $0x70,%eax
 3bd:	74 75                	je     434 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3bf:	83 fa 73             	cmp    $0x73,%edx
 3c2:	0f 84 90 00 00 00    	je     458 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3c8:	83 fa 63             	cmp    $0x63,%edx
 3cb:	0f 84 c7 00 00 00    	je     498 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3d1:	83 fa 25             	cmp    $0x25,%edx
 3d4:	0f 84 0e 01 00 00    	je     4e8 <printf+0x1a0>
 3da:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3dd:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3e1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3e8:	00 
 3e9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3ec:	89 44 24 04          	mov    %eax,0x4(%esp)
 3f0:	89 34 24             	mov    %esi,(%esp)
 3f3:	e8 3c fe ff ff       	call   234 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3f8:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3fb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3fe:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 405:	00 
 406:	8d 45 e7             	lea    -0x19(%ebp),%eax
 409:	89 44 24 04          	mov    %eax,0x4(%esp)
 40d:	89 34 24             	mov    %esi,(%esp)
 410:	e8 1f fe ff ff       	call   234 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 415:	31 ff                	xor    %edi,%edi
 417:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 418:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 41c:	84 d2                	test   %dl,%dl
 41e:	75 80                	jne    3a0 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 420:	83 c4 3c             	add    $0x3c,%esp
 423:	5b                   	pop    %ebx
 424:	5e                   	pop    %esi
 425:	5f                   	pop    %edi
 426:	5d                   	pop    %ebp
 427:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 428:	bf 25 00 00 00       	mov    $0x25,%edi
 42d:	e9 61 ff ff ff       	jmp    393 <printf+0x4b>
 432:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 434:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 43b:	b9 10 00 00 00       	mov    $0x10,%ecx
 440:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 443:	8b 10                	mov    (%eax),%edx
 445:	89 f0                	mov    %esi,%eax
 447:	e8 68 fe ff ff       	call   2b4 <printint>
        ap++;
 44c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 450:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 452:	e9 3c ff ff ff       	jmp    393 <printf+0x4b>
 457:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 458:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 45b:	8b 38                	mov    (%eax),%edi
        ap++;
 45d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 461:	85 ff                	test   %edi,%edi
 463:	0f 84 a1 00 00 00    	je     50a <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 469:	8a 07                	mov    (%edi),%al
 46b:	84 c0                	test   %al,%al
 46d:	74 22                	je     491 <printf+0x149>
 46f:	90                   	nop
 470:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 473:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 47a:	00 
 47b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 47e:	89 44 24 04          	mov    %eax,0x4(%esp)
 482:	89 34 24             	mov    %esi,(%esp)
 485:	e8 aa fd ff ff       	call   234 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 48a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 48b:	8a 07                	mov    (%edi),%al
 48d:	84 c0                	test   %al,%al
 48f:	75 df                	jne    470 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 491:	31 ff                	xor    %edi,%edi
 493:	e9 fb fe ff ff       	jmp    393 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 498:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 49b:	8b 00                	mov    (%eax),%eax
 49d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4a0:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4a7:	00 
 4a8:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4ab:	89 44 24 04          	mov    %eax,0x4(%esp)
 4af:	89 34 24             	mov    %esi,(%esp)
 4b2:	e8 7d fd ff ff       	call   234 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 4b7:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4bb:	31 ff                	xor    %edi,%edi
 4bd:	e9 d1 fe ff ff       	jmp    393 <printf+0x4b>
 4c2:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4c4:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4cb:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4d0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4d3:	8b 10                	mov    (%eax),%edx
 4d5:	89 f0                	mov    %esi,%eax
 4d7:	e8 d8 fd ff ff       	call   2b4 <printint>
        ap++;
 4dc:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4e0:	66 31 ff             	xor    %di,%di
 4e3:	e9 ab fe ff ff       	jmp    393 <printf+0x4b>
 4e8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4ec:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4f3:	00 
 4f4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4f7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4fb:	89 34 24             	mov    %esi,(%esp)
 4fe:	e8 31 fd ff ff       	call   234 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 503:	31 ff                	xor    %edi,%edi
 505:	e9 89 fe ff ff       	jmp    393 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 50a:	bf 82 06 00 00       	mov    $0x682,%edi
 50f:	e9 55 ff ff ff       	jmp    469 <printf+0x121>

00000514 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 514:	55                   	push   %ebp
 515:	89 e5                	mov    %esp,%ebp
 517:	57                   	push   %edi
 518:	56                   	push   %esi
 519:	53                   	push   %ebx
 51a:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 51d:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 520:	a1 00 09 00 00       	mov    0x900,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 525:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 527:	39 d0                	cmp    %edx,%eax
 529:	72 11                	jb     53c <free+0x28>
 52b:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 52c:	39 c8                	cmp    %ecx,%eax
 52e:	72 04                	jb     534 <free+0x20>
 530:	39 ca                	cmp    %ecx,%edx
 532:	72 10                	jb     544 <free+0x30>
 534:	89 c8                	mov    %ecx,%eax
 536:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 538:	39 d0                	cmp    %edx,%eax
 53a:	73 f0                	jae    52c <free+0x18>
 53c:	39 ca                	cmp    %ecx,%edx
 53e:	72 04                	jb     544 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 540:	39 c8                	cmp    %ecx,%eax
 542:	72 f0                	jb     534 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 544:	8b 73 fc             	mov    -0x4(%ebx),%esi
 547:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 54a:	39 cf                	cmp    %ecx,%edi
 54c:	74 1a                	je     568 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 54e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 551:	8b 48 04             	mov    0x4(%eax),%ecx
 554:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 557:	39 f2                	cmp    %esi,%edx
 559:	74 24                	je     57f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 55b:	89 10                	mov    %edx,(%eax)
  freep = p;
 55d:	a3 00 09 00 00       	mov    %eax,0x900
}
 562:	5b                   	pop    %ebx
 563:	5e                   	pop    %esi
 564:	5f                   	pop    %edi
 565:	5d                   	pop    %ebp
 566:	c3                   	ret    
 567:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 568:	03 71 04             	add    0x4(%ecx),%esi
 56b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 56e:	8b 08                	mov    (%eax),%ecx
 570:	8b 09                	mov    (%ecx),%ecx
 572:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 575:	8b 48 04             	mov    0x4(%eax),%ecx
 578:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 57b:	39 f2                	cmp    %esi,%edx
 57d:	75 dc                	jne    55b <free+0x47>
    p->s.size += bp->s.size;
 57f:	03 4b fc             	add    -0x4(%ebx),%ecx
 582:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 585:	8b 53 f8             	mov    -0x8(%ebx),%edx
 588:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 58a:	a3 00 09 00 00       	mov    %eax,0x900
}
 58f:	5b                   	pop    %ebx
 590:	5e                   	pop    %esi
 591:	5f                   	pop    %edi
 592:	5d                   	pop    %ebp
 593:	c3                   	ret    

00000594 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 594:	55                   	push   %ebp
 595:	89 e5                	mov    %esp,%ebp
 597:	57                   	push   %edi
 598:	56                   	push   %esi
 599:	53                   	push   %ebx
 59a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 59d:	8b 45 08             	mov    0x8(%ebp),%eax
 5a0:	8d 70 07             	lea    0x7(%eax),%esi
 5a3:	c1 ee 03             	shr    $0x3,%esi
 5a6:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5a7:	8b 1d 00 09 00 00    	mov    0x900,%ebx
 5ad:	85 db                	test   %ebx,%ebx
 5af:	0f 84 91 00 00 00    	je     646 <malloc+0xb2>
 5b5:	8b 13                	mov    (%ebx),%edx
 5b7:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5ba:	39 ce                	cmp    %ecx,%esi
 5bc:	76 52                	jbe    610 <malloc+0x7c>
 5be:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5c5:	eb 0c                	jmp    5d3 <malloc+0x3f>
 5c7:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5c8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5ca:	8b 48 04             	mov    0x4(%eax),%ecx
 5cd:	39 ce                	cmp    %ecx,%esi
 5cf:	76 43                	jbe    614 <malloc+0x80>
 5d1:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5d3:	3b 15 00 09 00 00    	cmp    0x900,%edx
 5d9:	75 ed                	jne    5c8 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5db:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5e1:	76 51                	jbe    634 <malloc+0xa0>
 5e3:	89 d8                	mov    %ebx,%eax
 5e5:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 5e7:	89 04 24             	mov    %eax,(%esp)
 5ea:	e8 ad fc ff ff       	call   29c <sbrk>
  if(p == (char*)-1)
 5ef:	83 f8 ff             	cmp    $0xffffffff,%eax
 5f2:	74 18                	je     60c <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5f4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 5f7:	83 c0 08             	add    $0x8,%eax
 5fa:	89 04 24             	mov    %eax,(%esp)
 5fd:	e8 12 ff ff ff       	call   514 <free>
  return freep;
 602:	8b 15 00 09 00 00    	mov    0x900,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 608:	85 d2                	test   %edx,%edx
 60a:	75 bc                	jne    5c8 <malloc+0x34>
        return 0;
 60c:	31 c0                	xor    %eax,%eax
 60e:	eb 1c                	jmp    62c <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 610:	89 d0                	mov    %edx,%eax
 612:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 614:	39 ce                	cmp    %ecx,%esi
 616:	74 28                	je     640 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 618:	29 f1                	sub    %esi,%ecx
 61a:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 61d:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 620:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 623:	89 15 00 09 00 00    	mov    %edx,0x900
      return (void*)(p + 1);
 629:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 62c:	83 c4 1c             	add    $0x1c,%esp
 62f:	5b                   	pop    %ebx
 630:	5e                   	pop    %esi
 631:	5f                   	pop    %edi
 632:	5d                   	pop    %ebp
 633:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 634:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 639:	bf 00 10 00 00       	mov    $0x1000,%edi
 63e:	eb a7                	jmp    5e7 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 640:	8b 08                	mov    (%eax),%ecx
 642:	89 0a                	mov    %ecx,(%edx)
 644:	eb dd                	jmp    623 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 646:	c7 05 00 09 00 00 04 	movl   $0x904,0x900
 64d:	09 00 00 
 650:	c7 05 04 09 00 00 04 	movl   $0x904,0x904
 657:	09 00 00 
    base.s.size = 0;
 65a:	c7 05 08 09 00 00 00 	movl   $0x0,0x908
 661:	00 00 00 
 664:	ba 04 09 00 00       	mov    $0x904,%edx
 669:	e9 50 ff ff ff       	jmp    5be <malloc+0x2a>
