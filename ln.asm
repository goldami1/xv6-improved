
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	83 ec 10             	sub    $0x10,%esp
   a:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(argc != 3){
   d:	83 7d 08 03          	cmpl   $0x3,0x8(%ebp)
  11:	74 19                	je     2c <main+0x2c>
    printf(2, "Usage: ln old new\n");
  13:	c7 44 24 04 86 06 00 	movl   $0x686,0x4(%esp)
  1a:	00 
  1b:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  22:	e8 39 03 00 00       	call   360 <printf>
    exit();
  27:	e8 00 02 00 00       	call   22c <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2c:	8b 43 08             	mov    0x8(%ebx),%eax
  2f:	89 44 24 04          	mov    %eax,0x4(%esp)
  33:	8b 43 04             	mov    0x4(%ebx),%eax
  36:	89 04 24             	mov    %eax,(%esp)
  39:	e8 4e 02 00 00       	call   28c <link>
  3e:	85 c0                	test   %eax,%eax
  40:	78 05                	js     47 <main+0x47>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  42:	e8 e5 01 00 00       	call   22c <exit>
  if(argc != 3){
    printf(2, "Usage: ln old new\n");
    exit();
  }
  if(link(argv[1], argv[2]) < 0)
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  47:	8b 43 08             	mov    0x8(%ebx),%eax
  4a:	89 44 24 0c          	mov    %eax,0xc(%esp)
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	89 44 24 08          	mov    %eax,0x8(%esp)
  55:	c7 44 24 04 99 06 00 	movl   $0x699,0x4(%esp)
  5c:	00 
  5d:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  64:	e8 f7 02 00 00       	call   360 <printf>
  69:	eb d7                	jmp    42 <main+0x42>
  6b:	90                   	nop

0000006c <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  6c:	55                   	push   %ebp
  6d:	89 e5                	mov    %esp,%ebp
  6f:	53                   	push   %ebx
  70:	8b 45 08             	mov    0x8(%ebp),%eax
  73:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  76:	89 c2                	mov    %eax,%edx
  78:	42                   	inc    %edx
  79:	41                   	inc    %ecx
  7a:	8a 59 ff             	mov    -0x1(%ecx),%bl
  7d:	88 5a ff             	mov    %bl,-0x1(%edx)
  80:	84 db                	test   %bl,%bl
  82:	75 f4                	jne    78 <strcpy+0xc>
    ;
  return os;
}
  84:	5b                   	pop    %ebx
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    
  87:	90                   	nop

00000088 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  88:	55                   	push   %ebp
  89:	89 e5                	mov    %esp,%ebp
  8b:	53                   	push   %ebx
  8c:	8b 55 08             	mov    0x8(%ebp),%edx
  8f:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  92:	0f b6 02             	movzbl (%edx),%eax
  95:	84 c0                	test   %al,%al
  97:	74 27                	je     c0 <strcmp+0x38>
  99:	8a 19                	mov    (%ecx),%bl
  9b:	38 d8                	cmp    %bl,%al
  9d:	74 0b                	je     aa <strcmp+0x22>
  9f:	eb 26                	jmp    c7 <strcmp+0x3f>
  a1:	8d 76 00             	lea    0x0(%esi),%esi
  a4:	38 c8                	cmp    %cl,%al
  a6:	75 13                	jne    bb <strcmp+0x33>
    p++, q++;
  a8:	89 d9                	mov    %ebx,%ecx
  aa:	42                   	inc    %edx
  ab:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  ae:	0f b6 02             	movzbl (%edx),%eax
  b1:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  b5:	84 c0                	test   %al,%al
  b7:	75 eb                	jne    a4 <strcmp+0x1c>
  b9:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  bb:	29 c8                	sub    %ecx,%eax
}
  bd:	5b                   	pop    %ebx
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    
  c0:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  c3:	31 c0                	xor    %eax,%eax
  c5:	eb f4                	jmp    bb <strcmp+0x33>
  c7:	0f b6 cb             	movzbl %bl,%ecx
  ca:	eb ef                	jmp    bb <strcmp+0x33>

000000cc <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  cf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  d2:	80 39 00             	cmpb   $0x0,(%ecx)
  d5:	74 10                	je     e7 <strlen+0x1b>
  d7:	31 d2                	xor    %edx,%edx
  d9:	8d 76 00             	lea    0x0(%esi),%esi
  dc:	42                   	inc    %edx
  dd:	89 d0                	mov    %edx,%eax
  df:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  e3:	75 f7                	jne    dc <strlen+0x10>
    ;
  return n;
}
  e5:	5d                   	pop    %ebp
  e6:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  e7:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  e9:	5d                   	pop    %ebp
  ea:	c3                   	ret    
  eb:	90                   	nop

000000ec <memset>:

void*
memset(void *dst, int c, uint n)
{
  ec:	55                   	push   %ebp
  ed:	89 e5                	mov    %esp,%ebp
  ef:	57                   	push   %edi
  f0:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f3:	89 d7                	mov    %edx,%edi
  f5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  fb:	fc                   	cld    
  fc:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  fe:	89 d0                	mov    %edx,%eax
 100:	5f                   	pop    %edi
 101:	5d                   	pop    %ebp
 102:	c3                   	ret    
 103:	90                   	nop

00000104 <strchr>:

char*
strchr(const char *s, char c)
{
 104:	55                   	push   %ebp
 105:	89 e5                	mov    %esp,%ebp
 107:	53                   	push   %ebx
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10e:	8a 10                	mov    (%eax),%dl
 110:	84 d2                	test   %dl,%dl
 112:	74 13                	je     127 <strchr+0x23>
 114:	88 d9                	mov    %bl,%cl
    if(*s == c)
 116:	38 da                	cmp    %bl,%dl
 118:	75 06                	jne    120 <strchr+0x1c>
 11a:	eb 0d                	jmp    129 <strchr+0x25>
 11c:	38 ca                	cmp    %cl,%dl
 11e:	74 09                	je     129 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
 120:	40                   	inc    %eax
 121:	8a 10                	mov    (%eax),%dl
 123:	84 d2                	test   %dl,%dl
 125:	75 f5                	jne    11c <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
 127:	31 c0                	xor    %eax,%eax
}
 129:	5b                   	pop    %ebx
 12a:	5d                   	pop    %ebp
 12b:	c3                   	ret    

0000012c <gets>:

char*
gets(char *buf, int max)
{
 12c:	55                   	push   %ebp
 12d:	89 e5                	mov    %esp,%ebp
 12f:	57                   	push   %edi
 130:	56                   	push   %esi
 131:	53                   	push   %ebx
 132:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 135:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
 137:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13a:	eb 30                	jmp    16c <gets+0x40>
    cc = read(0, &c, 1);
 13c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 143:	00 
 144:	89 7c 24 04          	mov    %edi,0x4(%esp)
 148:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 14f:	e8 f0 00 00 00       	call   244 <read>
    if(cc < 1)
 154:	85 c0                	test   %eax,%eax
 156:	7e 1c                	jle    174 <gets+0x48>
      break;
    buf[i++] = c;
 158:	8a 45 e7             	mov    -0x19(%ebp),%al
 15b:	8b 55 08             	mov    0x8(%ebp),%edx
 15e:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 162:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 164:	3c 0a                	cmp    $0xa,%al
 166:	74 0c                	je     174 <gets+0x48>
 168:	3c 0d                	cmp    $0xd,%al
 16a:	74 08                	je     174 <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 16c:	8d 5e 01             	lea    0x1(%esi),%ebx
 16f:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 172:	7c c8                	jl     13c <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 17b:	83 c4 2c             	add    $0x2c,%esp
 17e:	5b                   	pop    %ebx
 17f:	5e                   	pop    %esi
 180:	5f                   	pop    %edi
 181:	5d                   	pop    %ebp
 182:	c3                   	ret    
 183:	90                   	nop

00000184 <stat>:

int
stat(char *n, struct stat *st)
{
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	56                   	push   %esi
 188:	53                   	push   %ebx
 189:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18c:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 193:	00 
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	89 04 24             	mov    %eax,(%esp)
 19a:	e8 cd 00 00 00       	call   26c <open>
 19f:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 1a1:	85 c0                	test   %eax,%eax
 1a3:	78 23                	js     1c8 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 1a5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a8:	89 44 24 04          	mov    %eax,0x4(%esp)
 1ac:	89 1c 24             	mov    %ebx,(%esp)
 1af:	e8 d0 00 00 00       	call   284 <fstat>
 1b4:	89 c6                	mov    %eax,%esi
  close(fd);
 1b6:	89 1c 24             	mov    %ebx,(%esp)
 1b9:	e8 96 00 00 00       	call   254 <close>
  return r;
 1be:	89 f0                	mov    %esi,%eax
}
 1c0:	83 c4 10             	add    $0x10,%esp
 1c3:	5b                   	pop    %ebx
 1c4:	5e                   	pop    %esi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
 1c7:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 1c8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1cd:	eb f1                	jmp    1c0 <stat+0x3c>
 1cf:	90                   	nop

000001d0 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	53                   	push   %ebx
 1d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d7:	0f be 11             	movsbl (%ecx),%edx
 1da:	8d 42 d0             	lea    -0x30(%edx),%eax
 1dd:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 1df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 1e4:	77 15                	ja     1fb <atoi+0x2b>
 1e6:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1e8:	41                   	inc    %ecx
 1e9:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1ec:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f0:	0f be 11             	movsbl (%ecx),%edx
 1f3:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1f6:	80 fb 09             	cmp    $0x9,%bl
 1f9:	76 ed                	jbe    1e8 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1fb:	5b                   	pop    %ebx
 1fc:	5d                   	pop    %ebp
 1fd:	c3                   	ret    
 1fe:	66 90                	xchg   %ax,%ax

00000200 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	56                   	push   %esi
 204:	53                   	push   %ebx
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 20b:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 20e:	31 d2                	xor    %edx,%edx
 210:	85 f6                	test   %esi,%esi
 212:	7e 0b                	jle    21f <memmove+0x1f>
    *dst++ = *src++;
 214:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 217:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 21a:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21b:	39 f2                	cmp    %esi,%edx
 21d:	75 f5                	jne    214 <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 21f:	5b                   	pop    %ebx
 220:	5e                   	pop    %esi
 221:	5d                   	pop    %ebp
 222:	c3                   	ret    
 223:	90                   	nop

00000224 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 224:	b8 01 00 00 00       	mov    $0x1,%eax
 229:	cd 40                	int    $0x40
 22b:	c3                   	ret    

0000022c <exit>:
SYSCALL(exit)
 22c:	b8 02 00 00 00       	mov    $0x2,%eax
 231:	cd 40                	int    $0x40
 233:	c3                   	ret    

00000234 <wait>:
SYSCALL(wait)
 234:	b8 03 00 00 00       	mov    $0x3,%eax
 239:	cd 40                	int    $0x40
 23b:	c3                   	ret    

0000023c <pipe>:
SYSCALL(pipe)
 23c:	b8 04 00 00 00       	mov    $0x4,%eax
 241:	cd 40                	int    $0x40
 243:	c3                   	ret    

00000244 <read>:
SYSCALL(read)
 244:	b8 05 00 00 00       	mov    $0x5,%eax
 249:	cd 40                	int    $0x40
 24b:	c3                   	ret    

0000024c <write>:
SYSCALL(write)
 24c:	b8 10 00 00 00       	mov    $0x10,%eax
 251:	cd 40                	int    $0x40
 253:	c3                   	ret    

00000254 <close>:
SYSCALL(close)
 254:	b8 15 00 00 00       	mov    $0x15,%eax
 259:	cd 40                	int    $0x40
 25b:	c3                   	ret    

0000025c <kill>:
SYSCALL(kill)
 25c:	b8 06 00 00 00       	mov    $0x6,%eax
 261:	cd 40                	int    $0x40
 263:	c3                   	ret    

00000264 <exec>:
SYSCALL(exec)
 264:	b8 07 00 00 00       	mov    $0x7,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <open>:
SYSCALL(open)
 26c:	b8 0f 00 00 00       	mov    $0xf,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <mknod>:
SYSCALL(mknod)
 274:	b8 11 00 00 00       	mov    $0x11,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <unlink>:
SYSCALL(unlink)
 27c:	b8 12 00 00 00       	mov    $0x12,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <fstat>:
SYSCALL(fstat)
 284:	b8 08 00 00 00       	mov    $0x8,%eax
 289:	cd 40                	int    $0x40
 28b:	c3                   	ret    

0000028c <link>:
SYSCALL(link)
 28c:	b8 13 00 00 00       	mov    $0x13,%eax
 291:	cd 40                	int    $0x40
 293:	c3                   	ret    

00000294 <mkdir>:
SYSCALL(mkdir)
 294:	b8 14 00 00 00       	mov    $0x14,%eax
 299:	cd 40                	int    $0x40
 29b:	c3                   	ret    

0000029c <chdir>:
SYSCALL(chdir)
 29c:	b8 09 00 00 00       	mov    $0x9,%eax
 2a1:	cd 40                	int    $0x40
 2a3:	c3                   	ret    

000002a4 <dup>:
SYSCALL(dup)
 2a4:	b8 0a 00 00 00       	mov    $0xa,%eax
 2a9:	cd 40                	int    $0x40
 2ab:	c3                   	ret    

000002ac <getpid>:
SYSCALL(getpid)
 2ac:	b8 0b 00 00 00       	mov    $0xb,%eax
 2b1:	cd 40                	int    $0x40
 2b3:	c3                   	ret    

000002b4 <sbrk>:
SYSCALL(sbrk)
 2b4:	b8 0c 00 00 00       	mov    $0xc,%eax
 2b9:	cd 40                	int    $0x40
 2bb:	c3                   	ret    

000002bc <sleep>:
SYSCALL(sleep)
 2bc:	b8 0d 00 00 00       	mov    $0xd,%eax
 2c1:	cd 40                	int    $0x40
 2c3:	c3                   	ret    

000002c4 <uptime>:
SYSCALL(uptime)
 2c4:	b8 0e 00 00 00       	mov    $0xe,%eax
 2c9:	cd 40                	int    $0x40
 2cb:	c3                   	ret    

000002cc <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2cc:	55                   	push   %ebp
 2cd:	89 e5                	mov    %esp,%ebp
 2cf:	57                   	push   %edi
 2d0:	56                   	push   %esi
 2d1:	53                   	push   %ebx
 2d2:	83 ec 4c             	sub    $0x4c,%esp
 2d5:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 2d7:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2d9:	8b 5d 08             	mov    0x8(%ebp),%ebx
 2dc:	85 db                	test   %ebx,%ebx
 2de:	74 04                	je     2e4 <printint+0x18>
 2e0:	85 d2                	test   %edx,%edx
 2e2:	78 70                	js     354 <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 2e4:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2eb:	31 ff                	xor    %edi,%edi
 2ed:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2f0:	89 75 c0             	mov    %esi,-0x40(%ebp)
 2f3:	89 ce                	mov    %ecx,%esi
 2f5:	eb 03                	jmp    2fa <printint+0x2e>
 2f7:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2f8:	89 cf                	mov    %ecx,%edi
 2fa:	8d 4f 01             	lea    0x1(%edi),%ecx
 2fd:	31 d2                	xor    %edx,%edx
 2ff:	f7 f6                	div    %esi
 301:	8a 92 b4 06 00 00    	mov    0x6b4(%edx),%dl
 307:	88 55 c7             	mov    %dl,-0x39(%ebp)
 30a:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 30d:	85 c0                	test   %eax,%eax
 30f:	75 e7                	jne    2f8 <printint+0x2c>
 311:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 314:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 316:	8b 55 bc             	mov    -0x44(%ebp),%edx
 319:	85 d2                	test   %edx,%edx
 31b:	74 08                	je     325 <printint+0x59>
    buf[i++] = '-';
 31d:	8d 4f 02             	lea    0x2(%edi),%ecx
 320:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 325:	8d 79 ff             	lea    -0x1(%ecx),%edi
 328:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 32c:	88 45 c7             	mov    %al,-0x39(%ebp)
 32f:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 332:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 339:	00 
 33a:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 33e:	89 34 24             	mov    %esi,(%esp)
 341:	e8 06 ff ff ff       	call   24c <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 346:	4f                   	dec    %edi
 347:	83 ff ff             	cmp    $0xffffffff,%edi
 34a:	75 dc                	jne    328 <printint+0x5c>
    putc(fd, buf[i]);
}
 34c:	83 c4 4c             	add    $0x4c,%esp
 34f:	5b                   	pop    %ebx
 350:	5e                   	pop    %esi
 351:	5f                   	pop    %edi
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 354:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 356:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 35d:	eb 8c                	jmp    2eb <printint+0x1f>
 35f:	90                   	nop

00000360 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	57                   	push   %edi
 364:	56                   	push   %esi
 365:	53                   	push   %ebx
 366:	83 ec 3c             	sub    $0x3c,%esp
 369:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 36c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 36f:	0f b6 13             	movzbl (%ebx),%edx
 372:	84 d2                	test   %dl,%dl
 374:	0f 84 be 00 00 00    	je     438 <printf+0xd8>
 37a:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 37b:	8d 45 10             	lea    0x10(%ebp),%eax
 37e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 381:	31 ff                	xor    %edi,%edi
 383:	eb 33                	jmp    3b8 <printf+0x58>
 385:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 388:	83 fa 25             	cmp    $0x25,%edx
 38b:	0f 84 af 00 00 00    	je     440 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 391:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 394:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 39b:	00 
 39c:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 39f:	89 44 24 04          	mov    %eax,0x4(%esp)
 3a3:	89 34 24             	mov    %esi,(%esp)
 3a6:	e8 a1 fe ff ff       	call   24c <write>
 3ab:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3ac:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 3b0:	84 d2                	test   %dl,%dl
 3b2:	0f 84 80 00 00 00    	je     438 <printf+0xd8>
    c = fmt[i] & 0xff;
 3b8:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 3bb:	85 ff                	test   %edi,%edi
 3bd:	74 c9                	je     388 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 3bf:	83 ff 25             	cmp    $0x25,%edi
 3c2:	75 e7                	jne    3ab <printf+0x4b>
      if(c == 'd'){
 3c4:	83 fa 64             	cmp    $0x64,%edx
 3c7:	0f 84 0f 01 00 00    	je     4dc <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3cd:	25 f7 00 00 00       	and    $0xf7,%eax
 3d2:	83 f8 70             	cmp    $0x70,%eax
 3d5:	74 75                	je     44c <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3d7:	83 fa 73             	cmp    $0x73,%edx
 3da:	0f 84 90 00 00 00    	je     470 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3e0:	83 fa 63             	cmp    $0x63,%edx
 3e3:	0f 84 c7 00 00 00    	je     4b0 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3e9:	83 fa 25             	cmp    $0x25,%edx
 3ec:	0f 84 0e 01 00 00    	je     500 <printf+0x1a0>
 3f2:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3f5:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3f9:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 400:	00 
 401:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 404:	89 44 24 04          	mov    %eax,0x4(%esp)
 408:	89 34 24             	mov    %esi,(%esp)
 40b:	e8 3c fe ff ff       	call   24c <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 410:	8b 55 d0             	mov    -0x30(%ebp),%edx
 413:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 416:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 41d:	00 
 41e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 421:	89 44 24 04          	mov    %eax,0x4(%esp)
 425:	89 34 24             	mov    %esi,(%esp)
 428:	e8 1f fe ff ff       	call   24c <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 42d:	31 ff                	xor    %edi,%edi
 42f:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 430:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 434:	84 d2                	test   %dl,%dl
 436:	75 80                	jne    3b8 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 438:	83 c4 3c             	add    $0x3c,%esp
 43b:	5b                   	pop    %ebx
 43c:	5e                   	pop    %esi
 43d:	5f                   	pop    %edi
 43e:	5d                   	pop    %ebp
 43f:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 440:	bf 25 00 00 00       	mov    $0x25,%edi
 445:	e9 61 ff ff ff       	jmp    3ab <printf+0x4b>
 44a:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 44c:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 453:	b9 10 00 00 00       	mov    $0x10,%ecx
 458:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 45b:	8b 10                	mov    (%eax),%edx
 45d:	89 f0                	mov    %esi,%eax
 45f:	e8 68 fe ff ff       	call   2cc <printint>
        ap++;
 464:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 468:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 46a:	e9 3c ff ff ff       	jmp    3ab <printf+0x4b>
 46f:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 470:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 473:	8b 38                	mov    (%eax),%edi
        ap++;
 475:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 479:	85 ff                	test   %edi,%edi
 47b:	0f 84 a1 00 00 00    	je     522 <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 481:	8a 07                	mov    (%edi),%al
 483:	84 c0                	test   %al,%al
 485:	74 22                	je     4a9 <printf+0x149>
 487:	90                   	nop
 488:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 48b:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 492:	00 
 493:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 496:	89 44 24 04          	mov    %eax,0x4(%esp)
 49a:	89 34 24             	mov    %esi,(%esp)
 49d:	e8 aa fd ff ff       	call   24c <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 4a2:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 4a3:	8a 07                	mov    (%edi),%al
 4a5:	84 c0                	test   %al,%al
 4a7:	75 df                	jne    488 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4a9:	31 ff                	xor    %edi,%edi
 4ab:	e9 fb fe ff ff       	jmp    3ab <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 4b0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4b3:	8b 00                	mov    (%eax),%eax
 4b5:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4b8:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4bf:	00 
 4c0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 4c3:	89 44 24 04          	mov    %eax,0x4(%esp)
 4c7:	89 34 24             	mov    %esi,(%esp)
 4ca:	e8 7d fd ff ff       	call   24c <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 4cf:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d3:	31 ff                	xor    %edi,%edi
 4d5:	e9 d1 fe ff ff       	jmp    3ab <printf+0x4b>
 4da:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 4dc:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 4e3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4eb:	8b 10                	mov    (%eax),%edx
 4ed:	89 f0                	mov    %esi,%eax
 4ef:	e8 d8 fd ff ff       	call   2cc <printint>
        ap++;
 4f4:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4f8:	66 31 ff             	xor    %di,%di
 4fb:	e9 ab fe ff ff       	jmp    3ab <printf+0x4b>
 500:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 504:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 50b:	00 
 50c:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 50f:	89 44 24 04          	mov    %eax,0x4(%esp)
 513:	89 34 24             	mov    %esi,(%esp)
 516:	e8 31 fd ff ff       	call   24c <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 51b:	31 ff                	xor    %edi,%edi
 51d:	e9 89 fe ff ff       	jmp    3ab <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 522:	bf ad 06 00 00       	mov    $0x6ad,%edi
 527:	e9 55 ff ff ff       	jmp    481 <printf+0x121>

0000052c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 52c:	55                   	push   %ebp
 52d:	89 e5                	mov    %esp,%ebp
 52f:	57                   	push   %edi
 530:	56                   	push   %esi
 531:	53                   	push   %ebx
 532:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 535:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 538:	a1 28 09 00 00       	mov    0x928,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 53d:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53f:	39 d0                	cmp    %edx,%eax
 541:	72 11                	jb     554 <free+0x28>
 543:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 544:	39 c8                	cmp    %ecx,%eax
 546:	72 04                	jb     54c <free+0x20>
 548:	39 ca                	cmp    %ecx,%edx
 54a:	72 10                	jb     55c <free+0x30>
 54c:	89 c8                	mov    %ecx,%eax
 54e:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 550:	39 d0                	cmp    %edx,%eax
 552:	73 f0                	jae    544 <free+0x18>
 554:	39 ca                	cmp    %ecx,%edx
 556:	72 04                	jb     55c <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 558:	39 c8                	cmp    %ecx,%eax
 55a:	72 f0                	jb     54c <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 55c:	8b 73 fc             	mov    -0x4(%ebx),%esi
 55f:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 562:	39 cf                	cmp    %ecx,%edi
 564:	74 1a                	je     580 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 566:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 569:	8b 48 04             	mov    0x4(%eax),%ecx
 56c:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 56f:	39 f2                	cmp    %esi,%edx
 571:	74 24                	je     597 <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 573:	89 10                	mov    %edx,(%eax)
  freep = p;
 575:	a3 28 09 00 00       	mov    %eax,0x928
}
 57a:	5b                   	pop    %ebx
 57b:	5e                   	pop    %esi
 57c:	5f                   	pop    %edi
 57d:	5d                   	pop    %ebp
 57e:	c3                   	ret    
 57f:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 580:	03 71 04             	add    0x4(%ecx),%esi
 583:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 586:	8b 08                	mov    (%eax),%ecx
 588:	8b 09                	mov    (%ecx),%ecx
 58a:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 58d:	8b 48 04             	mov    0x4(%eax),%ecx
 590:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 593:	39 f2                	cmp    %esi,%edx
 595:	75 dc                	jne    573 <free+0x47>
    p->s.size += bp->s.size;
 597:	03 4b fc             	add    -0x4(%ebx),%ecx
 59a:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 59d:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5a0:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 5a2:	a3 28 09 00 00       	mov    %eax,0x928
}
 5a7:	5b                   	pop    %ebx
 5a8:	5e                   	pop    %esi
 5a9:	5f                   	pop    %edi
 5aa:	5d                   	pop    %ebp
 5ab:	c3                   	ret    

000005ac <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5ac:	55                   	push   %ebp
 5ad:	89 e5                	mov    %esp,%ebp
 5af:	57                   	push   %edi
 5b0:	56                   	push   %esi
 5b1:	53                   	push   %ebx
 5b2:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5b5:	8b 45 08             	mov    0x8(%ebp),%eax
 5b8:	8d 70 07             	lea    0x7(%eax),%esi
 5bb:	c1 ee 03             	shr    $0x3,%esi
 5be:	46                   	inc    %esi
  if((prevp = freep) == 0){
 5bf:	8b 1d 28 09 00 00    	mov    0x928,%ebx
 5c5:	85 db                	test   %ebx,%ebx
 5c7:	0f 84 91 00 00 00    	je     65e <malloc+0xb2>
 5cd:	8b 13                	mov    (%ebx),%edx
 5cf:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5d2:	39 ce                	cmp    %ecx,%esi
 5d4:	76 52                	jbe    628 <malloc+0x7c>
 5d6:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 5dd:	eb 0c                	jmp    5eb <malloc+0x3f>
 5df:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5e2:	8b 48 04             	mov    0x4(%eax),%ecx
 5e5:	39 ce                	cmp    %ecx,%esi
 5e7:	76 43                	jbe    62c <malloc+0x80>
 5e9:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5eb:	3b 15 28 09 00 00    	cmp    0x928,%edx
 5f1:	75 ed                	jne    5e0 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5f3:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5f9:	76 51                	jbe    64c <malloc+0xa0>
 5fb:	89 d8                	mov    %ebx,%eax
 5fd:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 5ff:	89 04 24             	mov    %eax,(%esp)
 602:	e8 ad fc ff ff       	call   2b4 <sbrk>
  if(p == (char*)-1)
 607:	83 f8 ff             	cmp    $0xffffffff,%eax
 60a:	74 18                	je     624 <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 60c:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 60f:	83 c0 08             	add    $0x8,%eax
 612:	89 04 24             	mov    %eax,(%esp)
 615:	e8 12 ff ff ff       	call   52c <free>
  return freep;
 61a:	8b 15 28 09 00 00    	mov    0x928,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 620:	85 d2                	test   %edx,%edx
 622:	75 bc                	jne    5e0 <malloc+0x34>
        return 0;
 624:	31 c0                	xor    %eax,%eax
 626:	eb 1c                	jmp    644 <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 628:	89 d0                	mov    %edx,%eax
 62a:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 62c:	39 ce                	cmp    %ecx,%esi
 62e:	74 28                	je     658 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 630:	29 f1                	sub    %esi,%ecx
 632:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 635:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 638:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 63b:	89 15 28 09 00 00    	mov    %edx,0x928
      return (void*)(p + 1);
 641:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 644:	83 c4 1c             	add    $0x1c,%esp
 647:	5b                   	pop    %ebx
 648:	5e                   	pop    %esi
 649:	5f                   	pop    %edi
 64a:	5d                   	pop    %ebp
 64b:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 64c:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 651:	bf 00 10 00 00       	mov    $0x1000,%edi
 656:	eb a7                	jmp    5ff <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 658:	8b 08                	mov    (%eax),%ecx
 65a:	89 0a                	mov    %ecx,(%edx)
 65c:	eb dd                	jmp    63b <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 65e:	c7 05 28 09 00 00 2c 	movl   $0x92c,0x928
 665:	09 00 00 
 668:	c7 05 2c 09 00 00 2c 	movl   $0x92c,0x92c
 66f:	09 00 00 
    base.s.size = 0;
 672:	c7 05 30 09 00 00 00 	movl   $0x0,0x930
 679:	00 00 00 
 67c:	ba 2c 09 00 00       	mov    $0x92c,%edx
 681:	e9 50 ff ff ff       	jmp    5d6 <malloc+0x2a>
