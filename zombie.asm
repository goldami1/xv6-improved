
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 10             	sub    $0x10,%esp
  if(fork() > 0)
   9:	e8 ce 01 00 00       	call   1dc <fork>
   e:	85 c0                	test   %eax,%eax
  10:	7e 0c                	jle    1e <main+0x1e>
    sleep(5);  // Let child exit before parent.
  12:	c7 04 24 05 00 00 00 	movl   $0x5,(%esp)
  19:	e8 56 02 00 00       	call   274 <sleep>
  exit();
  1e:	e8 c1 01 00 00       	call   1e4 <exit>
  23:	90                   	nop

00000024 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, char *t)
{
  24:	55                   	push   %ebp
  25:	89 e5                	mov    %esp,%ebp
  27:	53                   	push   %ebx
  28:	8b 45 08             	mov    0x8(%ebp),%eax
  2b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  2e:	89 c2                	mov    %eax,%edx
  30:	42                   	inc    %edx
  31:	41                   	inc    %ecx
  32:	8a 59 ff             	mov    -0x1(%ecx),%bl
  35:	88 5a ff             	mov    %bl,-0x1(%edx)
  38:	84 db                	test   %bl,%bl
  3a:	75 f4                	jne    30 <strcpy+0xc>
    ;
  return os;
}
  3c:	5b                   	pop    %ebx
  3d:	5d                   	pop    %ebp
  3e:	c3                   	ret    
  3f:	90                   	nop

00000040 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  40:	55                   	push   %ebp
  41:	89 e5                	mov    %esp,%ebp
  43:	53                   	push   %ebx
  44:	8b 55 08             	mov    0x8(%ebp),%edx
  47:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  4a:	0f b6 02             	movzbl (%edx),%eax
  4d:	84 c0                	test   %al,%al
  4f:	74 27                	je     78 <strcmp+0x38>
  51:	8a 19                	mov    (%ecx),%bl
  53:	38 d8                	cmp    %bl,%al
  55:	74 0b                	je     62 <strcmp+0x22>
  57:	eb 26                	jmp    7f <strcmp+0x3f>
  59:	8d 76 00             	lea    0x0(%esi),%esi
  5c:	38 c8                	cmp    %cl,%al
  5e:	75 13                	jne    73 <strcmp+0x33>
    p++, q++;
  60:	89 d9                	mov    %ebx,%ecx
  62:	42                   	inc    %edx
  63:	8d 59 01             	lea    0x1(%ecx),%ebx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  66:	0f b6 02             	movzbl (%edx),%eax
  69:	0f b6 49 01          	movzbl 0x1(%ecx),%ecx
  6d:	84 c0                	test   %al,%al
  6f:	75 eb                	jne    5c <strcmp+0x1c>
  71:	31 c0                	xor    %eax,%eax
    p++, q++;
  return (uchar)*p - (uchar)*q;
  73:	29 c8                	sub    %ecx,%eax
}
  75:	5b                   	pop    %ebx
  76:	5d                   	pop    %ebp
  77:	c3                   	ret    
  78:	0f b6 09             	movzbl (%ecx),%ecx
}

int
strcmp(const char *p, const char *q)
{
  while(*p && *p == *q)
  7b:	31 c0                	xor    %eax,%eax
  7d:	eb f4                	jmp    73 <strcmp+0x33>
  7f:	0f b6 cb             	movzbl %bl,%ecx
  82:	eb ef                	jmp    73 <strcmp+0x33>

00000084 <strlen>:
  return (uchar)*p - (uchar)*q;
}

uint
strlen(char *s)
{
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  8a:	80 39 00             	cmpb   $0x0,(%ecx)
  8d:	74 10                	je     9f <strlen+0x1b>
  8f:	31 d2                	xor    %edx,%edx
  91:	8d 76 00             	lea    0x0(%esi),%esi
  94:	42                   	inc    %edx
  95:	89 d0                	mov    %edx,%eax
  97:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  9b:	75 f7                	jne    94 <strlen+0x10>
    ;
  return n;
}
  9d:	5d                   	pop    %ebp
  9e:	c3                   	ret    
uint
strlen(char *s)
{
  int n;

  for(n = 0; s[n]; n++)
  9f:	31 c0                	xor    %eax,%eax
    ;
  return n;
}
  a1:	5d                   	pop    %ebp
  a2:	c3                   	ret    
  a3:	90                   	nop

000000a4 <memset>:

void*
memset(void *dst, int c, uint n)
{
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	57                   	push   %edi
  a8:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ab:	89 d7                	mov    %edx,%edi
  ad:	8b 4d 10             	mov    0x10(%ebp),%ecx
  b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  b3:	fc                   	cld    
  b4:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  b6:	89 d0                	mov    %edx,%eax
  b8:	5f                   	pop    %edi
  b9:	5d                   	pop    %ebp
  ba:	c3                   	ret    
  bb:	90                   	nop

000000bc <strchr>:

char*
strchr(const char *s, char c)
{
  bc:	55                   	push   %ebp
  bd:	89 e5                	mov    %esp,%ebp
  bf:	53                   	push   %ebx
  c0:	8b 45 08             	mov    0x8(%ebp),%eax
  c3:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
  c6:	8a 10                	mov    (%eax),%dl
  c8:	84 d2                	test   %dl,%dl
  ca:	74 13                	je     df <strchr+0x23>
  cc:	88 d9                	mov    %bl,%cl
    if(*s == c)
  ce:	38 da                	cmp    %bl,%dl
  d0:	75 06                	jne    d8 <strchr+0x1c>
  d2:	eb 0d                	jmp    e1 <strchr+0x25>
  d4:	38 ca                	cmp    %cl,%dl
  d6:	74 09                	je     e1 <strchr+0x25>
}

char*
strchr(const char *s, char c)
{
  for(; *s; s++)
  d8:	40                   	inc    %eax
  d9:	8a 10                	mov    (%eax),%dl
  db:	84 d2                	test   %dl,%dl
  dd:	75 f5                	jne    d4 <strchr+0x18>
    if(*s == c)
      return (char*)s;
  return 0;
  df:	31 c0                	xor    %eax,%eax
}
  e1:	5b                   	pop    %ebx
  e2:	5d                   	pop    %ebp
  e3:	c3                   	ret    

000000e4 <gets>:

char*
gets(char *buf, int max)
{
  e4:	55                   	push   %ebp
  e5:	89 e5                	mov    %esp,%ebp
  e7:	57                   	push   %edi
  e8:	56                   	push   %esi
  e9:	53                   	push   %ebx
  ea:	83 ec 2c             	sub    $0x2c,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  ed:	31 f6                	xor    %esi,%esi
    cc = read(0, &c, 1);
  ef:	8d 7d e7             	lea    -0x19(%ebp),%edi
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
  f2:	eb 30                	jmp    124 <gets+0x40>
    cc = read(0, &c, 1);
  f4:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
  fb:	00 
  fc:	89 7c 24 04          	mov    %edi,0x4(%esp)
 100:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 107:	e8 f0 00 00 00       	call   1fc <read>
    if(cc < 1)
 10c:	85 c0                	test   %eax,%eax
 10e:	7e 1c                	jle    12c <gets+0x48>
      break;
    buf[i++] = c;
 110:	8a 45 e7             	mov    -0x19(%ebp),%al
 113:	8b 55 08             	mov    0x8(%ebp),%edx
 116:	88 44 1a ff          	mov    %al,-0x1(%edx,%ebx,1)
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11a:	89 de                	mov    %ebx,%esi
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 11c:	3c 0a                	cmp    $0xa,%al
 11e:	74 0c                	je     12c <gets+0x48>
 120:	3c 0d                	cmp    $0xd,%al
 122:	74 08                	je     12c <gets+0x48>
gets(char *buf, int max)
{
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 124:	8d 5e 01             	lea    0x1(%esi),%ebx
 127:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 12a:	7c c8                	jl     f4 <gets+0x10>
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
      break;
  }
  buf[i] = '\0';
 12c:	8b 45 08             	mov    0x8(%ebp),%eax
 12f:	c6 04 30 00          	movb   $0x0,(%eax,%esi,1)
  return buf;
}
 133:	83 c4 2c             	add    $0x2c,%esp
 136:	5b                   	pop    %ebx
 137:	5e                   	pop    %esi
 138:	5f                   	pop    %edi
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    
 13b:	90                   	nop

0000013c <stat>:

int
stat(char *n, struct stat *st)
{
 13c:	55                   	push   %ebp
 13d:	89 e5                	mov    %esp,%ebp
 13f:	56                   	push   %esi
 140:	53                   	push   %ebx
 141:	83 ec 10             	sub    $0x10,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 144:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 14b:	00 
 14c:	8b 45 08             	mov    0x8(%ebp),%eax
 14f:	89 04 24             	mov    %eax,(%esp)
 152:	e8 cd 00 00 00       	call   224 <open>
 157:	89 c3                	mov    %eax,%ebx
  if(fd < 0)
 159:	85 c0                	test   %eax,%eax
 15b:	78 23                	js     180 <stat+0x44>
    return -1;
  r = fstat(fd, st);
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	89 44 24 04          	mov    %eax,0x4(%esp)
 164:	89 1c 24             	mov    %ebx,(%esp)
 167:	e8 d0 00 00 00       	call   23c <fstat>
 16c:	89 c6                	mov    %eax,%esi
  close(fd);
 16e:	89 1c 24             	mov    %ebx,(%esp)
 171:	e8 96 00 00 00       	call   20c <close>
  return r;
 176:	89 f0                	mov    %esi,%eax
}
 178:	83 c4 10             	add    $0x10,%esp
 17b:	5b                   	pop    %ebx
 17c:	5e                   	pop    %esi
 17d:	5d                   	pop    %ebp
 17e:	c3                   	ret    
 17f:	90                   	nop
  int fd;
  int r;

  fd = open(n, O_RDONLY);
  if(fd < 0)
    return -1;
 180:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 185:	eb f1                	jmp    178 <stat+0x3c>
 187:	90                   	nop

00000188 <atoi>:
  return r;
}

int
atoi(const char *s)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	53                   	push   %ebx
 18c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 18f:	0f be 11             	movsbl (%ecx),%edx
 192:	8d 42 d0             	lea    -0x30(%edx),%eax
 195:	3c 09                	cmp    $0x9,%al
int
atoi(const char *s)
{
  int n;

  n = 0;
 197:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 19c:	77 15                	ja     1b3 <atoi+0x2b>
 19e:	66 90                	xchg   %ax,%ax
    n = n*10 + *s++ - '0';
 1a0:	41                   	inc    %ecx
 1a1:	8d 04 80             	lea    (%eax,%eax,4),%eax
 1a4:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
atoi(const char *s)
{
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1a8:	0f be 11             	movsbl (%ecx),%edx
 1ab:	8d 5a d0             	lea    -0x30(%edx),%ebx
 1ae:	80 fb 09             	cmp    $0x9,%bl
 1b1:	76 ed                	jbe    1a0 <atoi+0x18>
    n = n*10 + *s++ - '0';
  return n;
}
 1b3:	5b                   	pop    %ebx
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    
 1b6:	66 90                	xchg   %ax,%ax

000001b8 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1b8:	55                   	push   %ebp
 1b9:	89 e5                	mov    %esp,%ebp
 1bb:	56                   	push   %esi
 1bc:	53                   	push   %ebx
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
 1c0:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 1c3:	8b 75 10             	mov    0x10(%ebp),%esi
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1c6:	31 d2                	xor    %edx,%edx
 1c8:	85 f6                	test   %esi,%esi
 1ca:	7e 0b                	jle    1d7 <memmove+0x1f>
    *dst++ = *src++;
 1cc:	8a 0c 13             	mov    (%ebx,%edx,1),%cl
 1cf:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 1d2:	42                   	inc    %edx
{
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1d3:	39 f2                	cmp    %esi,%edx
 1d5:	75 f5                	jne    1cc <memmove+0x14>
    *dst++ = *src++;
  return vdst;
}
 1d7:	5b                   	pop    %ebx
 1d8:	5e                   	pop    %esi
 1d9:	5d                   	pop    %ebp
 1da:	c3                   	ret    
 1db:	90                   	nop

000001dc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 1dc:	b8 01 00 00 00       	mov    $0x1,%eax
 1e1:	cd 40                	int    $0x40
 1e3:	c3                   	ret    

000001e4 <exit>:
SYSCALL(exit)
 1e4:	b8 02 00 00 00       	mov    $0x2,%eax
 1e9:	cd 40                	int    $0x40
 1eb:	c3                   	ret    

000001ec <wait>:
SYSCALL(wait)
 1ec:	b8 03 00 00 00       	mov    $0x3,%eax
 1f1:	cd 40                	int    $0x40
 1f3:	c3                   	ret    

000001f4 <pipe>:
SYSCALL(pipe)
 1f4:	b8 04 00 00 00       	mov    $0x4,%eax
 1f9:	cd 40                	int    $0x40
 1fb:	c3                   	ret    

000001fc <read>:
SYSCALL(read)
 1fc:	b8 05 00 00 00       	mov    $0x5,%eax
 201:	cd 40                	int    $0x40
 203:	c3                   	ret    

00000204 <write>:
SYSCALL(write)
 204:	b8 10 00 00 00       	mov    $0x10,%eax
 209:	cd 40                	int    $0x40
 20b:	c3                   	ret    

0000020c <close>:
SYSCALL(close)
 20c:	b8 15 00 00 00       	mov    $0x15,%eax
 211:	cd 40                	int    $0x40
 213:	c3                   	ret    

00000214 <kill>:
SYSCALL(kill)
 214:	b8 06 00 00 00       	mov    $0x6,%eax
 219:	cd 40                	int    $0x40
 21b:	c3                   	ret    

0000021c <exec>:
SYSCALL(exec)
 21c:	b8 07 00 00 00       	mov    $0x7,%eax
 221:	cd 40                	int    $0x40
 223:	c3                   	ret    

00000224 <open>:
SYSCALL(open)
 224:	b8 0f 00 00 00       	mov    $0xf,%eax
 229:	cd 40                	int    $0x40
 22b:	c3                   	ret    

0000022c <mknod>:
SYSCALL(mknod)
 22c:	b8 11 00 00 00       	mov    $0x11,%eax
 231:	cd 40                	int    $0x40
 233:	c3                   	ret    

00000234 <unlink>:
SYSCALL(unlink)
 234:	b8 12 00 00 00       	mov    $0x12,%eax
 239:	cd 40                	int    $0x40
 23b:	c3                   	ret    

0000023c <fstat>:
SYSCALL(fstat)
 23c:	b8 08 00 00 00       	mov    $0x8,%eax
 241:	cd 40                	int    $0x40
 243:	c3                   	ret    

00000244 <link>:
SYSCALL(link)
 244:	b8 13 00 00 00       	mov    $0x13,%eax
 249:	cd 40                	int    $0x40
 24b:	c3                   	ret    

0000024c <mkdir>:
SYSCALL(mkdir)
 24c:	b8 14 00 00 00       	mov    $0x14,%eax
 251:	cd 40                	int    $0x40
 253:	c3                   	ret    

00000254 <chdir>:
SYSCALL(chdir)
 254:	b8 09 00 00 00       	mov    $0x9,%eax
 259:	cd 40                	int    $0x40
 25b:	c3                   	ret    

0000025c <dup>:
SYSCALL(dup)
 25c:	b8 0a 00 00 00       	mov    $0xa,%eax
 261:	cd 40                	int    $0x40
 263:	c3                   	ret    

00000264 <getpid>:
SYSCALL(getpid)
 264:	b8 0b 00 00 00       	mov    $0xb,%eax
 269:	cd 40                	int    $0x40
 26b:	c3                   	ret    

0000026c <sbrk>:
SYSCALL(sbrk)
 26c:	b8 0c 00 00 00       	mov    $0xc,%eax
 271:	cd 40                	int    $0x40
 273:	c3                   	ret    

00000274 <sleep>:
SYSCALL(sleep)
 274:	b8 0d 00 00 00       	mov    $0xd,%eax
 279:	cd 40                	int    $0x40
 27b:	c3                   	ret    

0000027c <uptime>:
SYSCALL(uptime)
 27c:	b8 0e 00 00 00       	mov    $0xe,%eax
 281:	cd 40                	int    $0x40
 283:	c3                   	ret    

00000284 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	57                   	push   %edi
 288:	56                   	push   %esi
 289:	53                   	push   %ebx
 28a:	83 ec 4c             	sub    $0x4c,%esp
 28d:	89 c6                	mov    %eax,%esi
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 28f:	89 d0                	mov    %edx,%eax
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 291:	8b 5d 08             	mov    0x8(%ebp),%ebx
 294:	85 db                	test   %ebx,%ebx
 296:	74 04                	je     29c <printint+0x18>
 298:	85 d2                	test   %edx,%edx
 29a:	78 70                	js     30c <printint+0x88>
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 29c:	c7 45 bc 00 00 00 00 	movl   $0x0,-0x44(%ebp)
    x = -xx;
  } else {
    x = xx;
  }

  i = 0;
 2a3:	31 ff                	xor    %edi,%edi
 2a5:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 2a8:	89 75 c0             	mov    %esi,-0x40(%ebp)
 2ab:	89 ce                	mov    %ecx,%esi
 2ad:	eb 03                	jmp    2b2 <printint+0x2e>
 2af:	90                   	nop
  do{
    buf[i++] = digits[x % base];
 2b0:	89 cf                	mov    %ecx,%edi
 2b2:	8d 4f 01             	lea    0x1(%edi),%ecx
 2b5:	31 d2                	xor    %edx,%edx
 2b7:	f7 f6                	div    %esi
 2b9:	8a 92 45 06 00 00    	mov    0x645(%edx),%dl
 2bf:	88 55 c7             	mov    %dl,-0x39(%ebp)
 2c2:	88 14 0b             	mov    %dl,(%ebx,%ecx,1)
  }while((x /= base) != 0);
 2c5:	85 c0                	test   %eax,%eax
 2c7:	75 e7                	jne    2b0 <printint+0x2c>
 2c9:	8b 75 c0             	mov    -0x40(%ebp),%esi
    x = xx;
  }

  i = 0;
  do{
    buf[i++] = digits[x % base];
 2cc:	89 c8                	mov    %ecx,%eax
  }while((x /= base) != 0);
  if(neg)
 2ce:	8b 55 bc             	mov    -0x44(%ebp),%edx
 2d1:	85 d2                	test   %edx,%edx
 2d3:	74 08                	je     2dd <printint+0x59>
    buf[i++] = '-';
 2d5:	8d 4f 02             	lea    0x2(%edi),%ecx
 2d8:	c6 44 05 d8 2d       	movb   $0x2d,-0x28(%ebp,%eax,1)

  while(--i >= 0)
 2dd:	8d 79 ff             	lea    -0x1(%ecx),%edi
 2e0:	8a 44 3d d8          	mov    -0x28(%ebp,%edi,1),%al
 2e4:	88 45 c7             	mov    %al,-0x39(%ebp)
 2e7:	88 45 d7             	mov    %al,-0x29(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 2ea:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 2f1:	00 
 2f2:	89 5c 24 04          	mov    %ebx,0x4(%esp)
 2f6:	89 34 24             	mov    %esi,(%esp)
 2f9:	e8 06 ff ff ff       	call   204 <write>
    buf[i++] = digits[x % base];
  }while((x /= base) != 0);
  if(neg)
    buf[i++] = '-';

  while(--i >= 0)
 2fe:	4f                   	dec    %edi
 2ff:	83 ff ff             	cmp    $0xffffffff,%edi
 302:	75 dc                	jne    2e0 <printint+0x5c>
    putc(fd, buf[i]);
}
 304:	83 c4 4c             	add    $0x4c,%esp
 307:	5b                   	pop    %ebx
 308:	5e                   	pop    %esi
 309:	5f                   	pop    %edi
 30a:	5d                   	pop    %ebp
 30b:	c3                   	ret    
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
    x = -xx;
 30c:	f7 d8                	neg    %eax
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    neg = 1;
 30e:	c7 45 bc 01 00 00 00 	movl   $0x1,-0x44(%ebp)
    x = -xx;
 315:	eb 8c                	jmp    2a3 <printint+0x1f>
 317:	90                   	nop

00000318 <printf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 318:	55                   	push   %ebp
 319:	89 e5                	mov    %esp,%ebp
 31b:	57                   	push   %edi
 31c:	56                   	push   %esi
 31d:	53                   	push   %ebx
 31e:	83 ec 3c             	sub    $0x3c,%esp
 321:	8b 75 08             	mov    0x8(%ebp),%esi
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 324:	8b 5d 0c             	mov    0xc(%ebp),%ebx
 327:	0f b6 13             	movzbl (%ebx),%edx
 32a:	84 d2                	test   %dl,%dl
 32c:	0f 84 be 00 00 00    	je     3f0 <printf+0xd8>
 332:	43                   	inc    %ebx
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
 333:	8d 45 10             	lea    0x10(%ebp),%eax
 336:	89 45 d4             	mov    %eax,-0x2c(%ebp)
{
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 339:	31 ff                	xor    %edi,%edi
 33b:	eb 33                	jmp    370 <printf+0x58>
 33d:	8d 76 00             	lea    0x0(%esi),%esi
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 340:	83 fa 25             	cmp    $0x25,%edx
 343:	0f 84 af 00 00 00    	je     3f8 <printf+0xe0>
        state = '%';
      } else {
        putc(fd, c);
 349:	88 55 e2             	mov    %dl,-0x1e(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 34c:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 353:	00 
 354:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 357:	89 44 24 04          	mov    %eax,0x4(%esp)
 35b:	89 34 24             	mov    %esi,(%esp)
 35e:	e8 a1 fe ff ff       	call   204 <write>
 363:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 364:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 368:	84 d2                	test   %dl,%dl
 36a:	0f 84 80 00 00 00    	je     3f0 <printf+0xd8>
    c = fmt[i] & 0xff;
 370:	0f be c2             	movsbl %dl,%eax
    if(state == 0){
 373:	85 ff                	test   %edi,%edi
 375:	74 c9                	je     340 <printf+0x28>
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 377:	83 ff 25             	cmp    $0x25,%edi
 37a:	75 e7                	jne    363 <printf+0x4b>
      if(c == 'd'){
 37c:	83 fa 64             	cmp    $0x64,%edx
 37f:	0f 84 0f 01 00 00    	je     494 <printf+0x17c>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 385:	25 f7 00 00 00       	and    $0xf7,%eax
 38a:	83 f8 70             	cmp    $0x70,%eax
 38d:	74 75                	je     404 <printf+0xec>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 38f:	83 fa 73             	cmp    $0x73,%edx
 392:	0f 84 90 00 00 00    	je     428 <printf+0x110>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 398:	83 fa 63             	cmp    $0x63,%edx
 39b:	0f 84 c7 00 00 00    	je     468 <printf+0x150>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3a1:	83 fa 25             	cmp    $0x25,%edx
 3a4:	0f 84 0e 01 00 00    	je     4b8 <printf+0x1a0>
 3aa:	89 55 d0             	mov    %edx,-0x30(%ebp)
 3ad:	c6 45 e6 25          	movb   $0x25,-0x1a(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3b1:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3b8:	00 
 3b9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 3bc:	89 44 24 04          	mov    %eax,0x4(%esp)
 3c0:	89 34 24             	mov    %esi,(%esp)
 3c3:	e8 3c fe ff ff       	call   204 <write>
      } else if(c == '%'){
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
 3c8:	8b 55 d0             	mov    -0x30(%ebp),%edx
 3cb:	88 55 e7             	mov    %dl,-0x19(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 3ce:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 3d5:	00 
 3d6:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3d9:	89 44 24 04          	mov    %eax,0x4(%esp)
 3dd:	89 34 24             	mov    %esi,(%esp)
 3e0:	e8 1f fe ff ff       	call   204 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 3e5:	31 ff                	xor    %edi,%edi
 3e7:	43                   	inc    %ebx
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3e8:	0f b6 53 ff          	movzbl -0x1(%ebx),%edx
 3ec:	84 d2                	test   %dl,%dl
 3ee:	75 80                	jne    370 <printf+0x58>
        putc(fd, c);
      }
      state = 0;
    }
  }
}
 3f0:	83 c4 3c             	add    $0x3c,%esp
 3f3:	5b                   	pop    %ebx
 3f4:	5e                   	pop    %esi
 3f5:	5f                   	pop    %edi
 3f6:	5d                   	pop    %ebp
 3f7:	c3                   	ret    
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
 3f8:	bf 25 00 00 00       	mov    $0x25,%edi
 3fd:	e9 61 ff ff ff       	jmp    363 <printf+0x4b>
 402:	66 90                	xchg   %ax,%ax
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
 404:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 40b:	b9 10 00 00 00       	mov    $0x10,%ecx
 410:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 413:	8b 10                	mov    (%eax),%edx
 415:	89 f0                	mov    %esi,%eax
 417:	e8 68 fe ff ff       	call   284 <printint>
        ap++;
 41c:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 420:	31 ff                	xor    %edi,%edi
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
        printint(fd, *ap, 16, 0);
        ap++;
 422:	e9 3c ff ff ff       	jmp    363 <printf+0x4b>
 427:	90                   	nop
      } else if(c == 's'){
        s = (char*)*ap;
 428:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 42b:	8b 38                	mov    (%eax),%edi
        ap++;
 42d:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
        if(s == 0)
 431:	85 ff                	test   %edi,%edi
 433:	0f 84 a1 00 00 00    	je     4da <printf+0x1c2>
          s = "(null)";
        while(*s != 0){
 439:	8a 07                	mov    (%edi),%al
 43b:	84 c0                	test   %al,%al
 43d:	74 22                	je     461 <printf+0x149>
 43f:	90                   	nop
 440:	88 45 e3             	mov    %al,-0x1d(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 443:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 44a:	00 
 44b:	8d 45 e3             	lea    -0x1d(%ebp),%eax
 44e:	89 44 24 04          	mov    %eax,0x4(%esp)
 452:	89 34 24             	mov    %esi,(%esp)
 455:	e8 aa fd ff ff       	call   204 <write>
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
 45a:	47                   	inc    %edi
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
        while(*s != 0){
 45b:	8a 07                	mov    (%edi),%al
 45d:	84 c0                	test   %al,%al
 45f:	75 df                	jne    440 <printf+0x128>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 461:	31 ff                	xor    %edi,%edi
 463:	e9 fb fe ff ff       	jmp    363 <printf+0x4b>
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
 468:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 46b:	8b 00                	mov    (%eax),%eax
 46d:	88 45 e4             	mov    %al,-0x1c(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 470:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 477:	00 
 478:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 47b:	89 44 24 04          	mov    %eax,0x4(%esp)
 47f:	89 34 24             	mov    %esi,(%esp)
 482:	e8 7d fd ff ff       	call   204 <write>
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
        putc(fd, *ap);
        ap++;
 487:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 48b:	31 ff                	xor    %edi,%edi
 48d:	e9 d1 fe ff ff       	jmp    363 <printf+0x4b>
 492:	66 90                	xchg   %ax,%ax
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
      if(c == 'd'){
        printint(fd, *ap, 10, 1);
 494:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 49b:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4a0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 4a3:	8b 10                	mov    (%eax),%edx
 4a5:	89 f0                	mov    %esi,%eax
 4a7:	e8 d8 fd ff ff       	call   284 <printint>
        ap++;
 4ac:	83 45 d4 04          	addl   $0x4,-0x2c(%ebp)
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4b0:	66 31 ff             	xor    %di,%di
 4b3:	e9 ab fe ff ff       	jmp    363 <printf+0x4b>
 4b8:	c6 45 e5 25          	movb   $0x25,-0x1b(%ebp)
#include "user.h"

static void
putc(int fd, char c)
{
  write(fd, &c, 1);
 4bc:	c7 44 24 08 01 00 00 	movl   $0x1,0x8(%esp)
 4c3:	00 
 4c4:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 4c7:	89 44 24 04          	mov    %eax,0x4(%esp)
 4cb:	89 34 24             	mov    %esi,(%esp)
 4ce:	e8 31 fd ff ff       	call   204 <write>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 4d3:	31 ff                	xor    %edi,%edi
 4d5:	e9 89 fe ff ff       	jmp    363 <printf+0x4b>
        ap++;
      } else if(c == 's'){
        s = (char*)*ap;
        ap++;
        if(s == 0)
          s = "(null)";
 4da:	bf 3e 06 00 00       	mov    $0x63e,%edi
 4df:	e9 55 ff ff ff       	jmp    439 <printf+0x121>

000004e4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 4e4:	55                   	push   %ebp
 4e5:	89 e5                	mov    %esp,%ebp
 4e7:	57                   	push   %edi
 4e8:	56                   	push   %esi
 4e9:	53                   	push   %ebx
 4ea:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 4ed:	8d 53 f8             	lea    -0x8(%ebx),%edx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4f0:	a1 b8 08 00 00       	mov    0x8b8,%eax
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4f5:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 4f7:	39 d0                	cmp    %edx,%eax
 4f9:	72 11                	jb     50c <free+0x28>
 4fb:	90                   	nop
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 4fc:	39 c8                	cmp    %ecx,%eax
 4fe:	72 04                	jb     504 <free+0x20>
 500:	39 ca                	cmp    %ecx,%edx
 502:	72 10                	jb     514 <free+0x30>
 504:	89 c8                	mov    %ecx,%eax
 506:	8b 08                	mov    (%eax),%ecx
free(void *ap)
{
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 508:	39 d0                	cmp    %edx,%eax
 50a:	73 f0                	jae    4fc <free+0x18>
 50c:	39 ca                	cmp    %ecx,%edx
 50e:	72 04                	jb     514 <free+0x30>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 510:	39 c8                	cmp    %ecx,%eax
 512:	72 f0                	jb     504 <free+0x20>
      break;
  if(bp + bp->s.size == p->s.ptr){
 514:	8b 73 fc             	mov    -0x4(%ebx),%esi
 517:	8d 3c f2             	lea    (%edx,%esi,8),%edi
 51a:	39 cf                	cmp    %ecx,%edi
 51c:	74 1a                	je     538 <free+0x54>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 51e:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  if(p + p->s.size == bp){
 521:	8b 48 04             	mov    0x4(%eax),%ecx
 524:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 527:	39 f2                	cmp    %esi,%edx
 529:	74 24                	je     54f <free+0x6b>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 52b:	89 10                	mov    %edx,(%eax)
  freep = p;
 52d:	a3 b8 08 00 00       	mov    %eax,0x8b8
}
 532:	5b                   	pop    %ebx
 533:	5e                   	pop    %esi
 534:	5f                   	pop    %edi
 535:	5d                   	pop    %ebp
 536:	c3                   	ret    
 537:	90                   	nop
  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
 538:	03 71 04             	add    0x4(%ecx),%esi
 53b:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 53e:	8b 08                	mov    (%eax),%ecx
 540:	8b 09                	mov    (%ecx),%ecx
 542:	89 4b f8             	mov    %ecx,-0x8(%ebx)
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
 545:	8b 48 04             	mov    0x4(%eax),%ecx
 548:	8d 34 c8             	lea    (%eax,%ecx,8),%esi
 54b:	39 f2                	cmp    %esi,%edx
 54d:	75 dc                	jne    52b <free+0x47>
    p->s.size += bp->s.size;
 54f:	03 4b fc             	add    -0x4(%ebx),%ecx
 552:	89 48 04             	mov    %ecx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 555:	8b 53 f8             	mov    -0x8(%ebx),%edx
 558:	89 10                	mov    %edx,(%eax)
  } else
    p->s.ptr = bp;
  freep = p;
 55a:	a3 b8 08 00 00       	mov    %eax,0x8b8
}
 55f:	5b                   	pop    %ebx
 560:	5e                   	pop    %esi
 561:	5f                   	pop    %edi
 562:	5d                   	pop    %ebp
 563:	c3                   	ret    

00000564 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 564:	55                   	push   %ebp
 565:	89 e5                	mov    %esp,%ebp
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	53                   	push   %ebx
 56a:	83 ec 1c             	sub    $0x1c,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 56d:	8b 45 08             	mov    0x8(%ebp),%eax
 570:	8d 70 07             	lea    0x7(%eax),%esi
 573:	c1 ee 03             	shr    $0x3,%esi
 576:	46                   	inc    %esi
  if((prevp = freep) == 0){
 577:	8b 1d b8 08 00 00    	mov    0x8b8,%ebx
 57d:	85 db                	test   %ebx,%ebx
 57f:	0f 84 91 00 00 00    	je     616 <malloc+0xb2>
 585:	8b 13                	mov    (%ebx),%edx
 587:	8b 4a 04             	mov    0x4(%edx),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 58a:	39 ce                	cmp    %ecx,%esi
 58c:	76 52                	jbe    5e0 <malloc+0x7c>
 58e:	8d 1c f5 00 00 00 00 	lea    0x0(,%esi,8),%ebx
 595:	eb 0c                	jmp    5a3 <malloc+0x3f>
 597:	90                   	nop
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 598:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 59a:	8b 48 04             	mov    0x4(%eax),%ecx
 59d:	39 ce                	cmp    %ecx,%esi
 59f:	76 43                	jbe    5e4 <malloc+0x80>
 5a1:	89 c2                	mov    %eax,%edx
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 5a3:	3b 15 b8 08 00 00    	cmp    0x8b8,%edx
 5a9:	75 ed                	jne    598 <malloc+0x34>
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 5ab:	81 fe ff 0f 00 00    	cmp    $0xfff,%esi
 5b1:	76 51                	jbe    604 <malloc+0xa0>
 5b3:	89 d8                	mov    %ebx,%eax
 5b5:	89 f7                	mov    %esi,%edi
    nu = 4096;
  p = sbrk(nu * sizeof(Header));
 5b7:	89 04 24             	mov    %eax,(%esp)
 5ba:	e8 ad fc ff ff       	call   26c <sbrk>
  if(p == (char*)-1)
 5bf:	83 f8 ff             	cmp    $0xffffffff,%eax
 5c2:	74 18                	je     5dc <malloc+0x78>
    return 0;
  hp = (Header*)p;
  hp->s.size = nu;
 5c4:	89 78 04             	mov    %edi,0x4(%eax)
  free((void*)(hp + 1));
 5c7:	83 c0 08             	add    $0x8,%eax
 5ca:	89 04 24             	mov    %eax,(%esp)
 5cd:	e8 12 ff ff ff       	call   4e4 <free>
  return freep;
 5d2:	8b 15 b8 08 00 00    	mov    0x8b8,%edx
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
 5d8:	85 d2                	test   %edx,%edx
 5da:	75 bc                	jne    598 <malloc+0x34>
        return 0;
 5dc:	31 c0                	xor    %eax,%eax
 5de:	eb 1c                	jmp    5fc <malloc+0x98>
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 5e0:	89 d0                	mov    %edx,%eax
 5e2:	89 da                	mov    %ebx,%edx
      if(p->s.size == nunits)
 5e4:	39 ce                	cmp    %ecx,%esi
 5e6:	74 28                	je     610 <malloc+0xac>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5e8:	29 f1                	sub    %esi,%ecx
 5ea:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5ed:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 5f0:	89 70 04             	mov    %esi,0x4(%eax)
      }
      freep = prevp;
 5f3:	89 15 b8 08 00 00    	mov    %edx,0x8b8
      return (void*)(p + 1);
 5f9:	83 c0 08             	add    $0x8,%eax
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 5fc:	83 c4 1c             	add    $0x1c,%esp
 5ff:	5b                   	pop    %ebx
 600:	5e                   	pop    %esi
 601:	5f                   	pop    %edi
 602:	5d                   	pop    %ebp
 603:	c3                   	ret    
morecore(uint nu)
{
  char *p;
  Header *hp;

  if(nu < 4096)
 604:	b8 00 80 00 00       	mov    $0x8000,%eax
    nu = 4096;
 609:	bf 00 10 00 00       	mov    $0x1000,%edi
 60e:	eb a7                	jmp    5b7 <malloc+0x53>
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
      if(p->s.size == nunits)
        prevp->s.ptr = p->s.ptr;
 610:	8b 08                	mov    (%eax),%ecx
 612:	89 0a                	mov    %ecx,(%edx)
 614:	eb dd                	jmp    5f3 <malloc+0x8f>
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
  if((prevp = freep) == 0){
    base.s.ptr = freep = prevp = &base;
 616:	c7 05 b8 08 00 00 bc 	movl   $0x8bc,0x8b8
 61d:	08 00 00 
 620:	c7 05 bc 08 00 00 bc 	movl   $0x8bc,0x8bc
 627:	08 00 00 
    base.s.size = 0;
 62a:	c7 05 c0 08 00 00 00 	movl   $0x0,0x8c0
 631:	00 00 00 
 634:	ba bc 08 00 00       	mov    $0x8bc,%edx
 639:	e9 50 ff ff ff       	jmp    58e <malloc+0x2a>
